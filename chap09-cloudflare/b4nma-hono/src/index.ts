import { Hono } from 'hono'

type Bindings = {
  DB: D1Database
}

const app = new Hono<{ Bindings: Bindings }>()

app.get('/balls', async (c) => {
  try {
    const { results } = await c.env.DB.prepare('select * from balls')
      .all()
    return c.json({
      balls: results,
    }, 200)
  } catch (e: any) {
    return c.json({
      success: false,
      err: e.message,
    }, 500)
  }
})

app.post('/balls', async (c) => {
  const body = await c.req.json()
  const x: number = body.x
  const y: number = body.y
  const r: number = body.r
  try {
    await c.env.DB
      .prepare('insert into balls(x, y, r) values (?, ?, ?)')
      .bind(x, y, r)
      .run()
    return c.json({
      success: true,
    }, 201)
  } catch (e: any) {
    return c.json({
      success: false,
      err: e.message,
    }, 500)
  }
})

app.delete('/balls/:id', async (c) => {
  const id: number = Number(c.req.param('id'))
  try {
    await c.env.DB.prepare('delete from balls where id = ?')
      .bind(id)
      .run()
    return c.json({
      success: true,
    }, 201)
  } catch (e: any) {
    return c.json({
      success: false,
      err: e.message,
    }, 500)
  }
})

app.put('/balls/:id', async (c) => {
  const id: number = Number(c.req.param('id'))
  const body = await c.req.json()
  const x: number = body.x
  const y: number = body.y  
  try {
    await c.env.DB.prepare('update balls set x = ?, y = ? where id = ?')
      .bind(x, y, id)
      .run()
    return c.json({
      success: true,
    }, 201)
  } catch (e: any) {
    return c.json({
      success: false,
      err: e.message,
    }, 500)
  }
})

export default app
