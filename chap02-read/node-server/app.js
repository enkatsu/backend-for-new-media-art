const express = require('express')
const app = express()
const port = 3000
const sqlite3 = require('sqlite3')

app.get('/balls', (req, res) => {
  const db = new sqlite3.Database('./db.sqlite')
  db.serialize(() => {
    db.all('select * from balls', (err, row) => {
      res.json({
        balls: row,
      })
    })
  })
  db.close()
})

app.listen(port, () => {
  console.log(`http://localhost:${port}`)
})
