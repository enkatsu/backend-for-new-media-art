const express = require('express')
const app = express()
const port = 3000

app.get('/balls', (req, res) => {
  const balls = [];
  for (let i = 0; i < 50; i++) {
    balls.push({
      x: Math.random(),
      y: Math.random(),
      r: Math.random(),
    });
  }
  res.json({
    balls,
  })
})

app.listen(port, () => {
  console.log(`http://localhost:${port}`)
})
