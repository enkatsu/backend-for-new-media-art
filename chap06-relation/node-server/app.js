const express = require('express')
const app = express()
app.use(express.json())
const port = 3000
const sqlite3 = require('sqlite3')
const db = new sqlite3.Database('./db.sqlite')


const getAllLines = (callback) => {
  // *** Formatting with JavaScript **
  const query = `
select lines.id as 'line_id', points.id as 'point_id', points.x as 'x', points.y as 'y'
from lines 
inner join points on lines.id = points.line_id`;
  db.all(query, (err, rows) => {
    if (err) {
      throw err
    }
    console.log(rows);

    const lineIds = Array.from(new Set(rows.map(row => row.line_id)))
    const lines = lineIds.map(lineId => {
      const points = rows.filter(row => row.line_id === lineId)
        .map(row => {
          return {
            id: row.point_id,
            x: row.x,
            y: row.y,
          }
        })
      return {
        id: lineId,
        points: points,
      }
    })
    callback(lines)
  })

  // *** Formatting with SQLite **
//   const query = `
// select json_object(
//   'id', lines.id,
//   "points", json_group_array(
//     json_object('id', points.id, 'x', points.x, 'y', points.y)
//   )
// ) line 
// from lines 
// inner join points on lines.id = points.line_id 
// group by lines.id`;
//   db.all(query, (err, rows) => {
//     const lines = rows.map(row => JSON.parse(row.line))
//     callback(lines)
//   })
}

app.get('/lines', (req, res) => {
  getAllLines((lines) => {
    res.json({
      lines: lines,
    })
  })
})

app.post('/lines', (req, res) => {
  db.serialize(() => {
    db.run('insert into lines default values')
    db.get('select id from lines order by id desc limit 1', function(err, row) {
      if (err) {
          throw err
      }
      db.serialize(() => {
        const insertQuery = db.prepare('insert into points (line_id, x, y) values (?, ?, ?)')
        for (const point of req.body.points) {
          insertQuery.run([row.id, point.x, point.y])
        }
        insertQuery.finalize()
        res.status(201).json({
          success: true,
        })
      })
    })
  })
})

app.listen(port, () => {
  console.log(`http://localhost:${port}`)
})
