const express = require('express')
const app = express()
app.use(express.json())
const port = 3000
const sqlite3 = require('sqlite3')
const db = new sqlite3.Database('./db.sqlite')

app.get('/balls', (req, res) => {
  db.serialize(() => {
    db.all('select * from balls', (err, row) => {
      if (err) {
        console.error(err)
      }
      
      res.json({
        balls: row,
      })
    })
  })
})

app.post('/balls', (req, res) => {
  console.log(req.body)
  const x = req.body.x
  const y = req.body.y
  const r = req.body.r
  db.run('insert into balls(x, y, r) values (?, ?, ?)', [x, y, r], (err) => {
    if (console.error(err)) {
      console.error(err)
    }

    res.status(201).json({
      success: true,
    });
  })
})

app.delete('/balls/:id', (req, res) => {
  console.log(req.body)
  db.run('delete from balls where id = ?', [req.params.id], (err) => {
    if (console.error(err)) {
      console.error(err)
    }

    res.status(201).json({
      success: true,
    });
  })
})

app.listen(port, () => {
  console.log(`http://localhost:${port}`)
})
