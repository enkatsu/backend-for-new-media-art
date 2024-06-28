const crypto = require('crypto')
const WebSocket = require('ws').WebSocket
const WebSocketServer = require('ws').WebSocketServer
const wss = new WebSocketServer({ port: 5001 })

wss.on('connection', ws => {
  ws.uuid = crypto.randomUUID()
  ws.on('message', message => {
    const event = JSON.parse(message.toString('utf-8'))
    event.uuid = ws.uuid
    console.log(event)
    wss.clients.forEach(function each(client) {
      if (client.readyState === WebSocket.OPEN) {
        client.send(JSON.stringify(event))
      }
    })
  })
})

console.log(`ws://localhost:${wss.options.port}`)
