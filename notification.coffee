module.exports = {}
express = require('express')
io = require('socket.io')
fs=require('fs')
app = express()
app.get('/',(req,res)->
  res.sendfile('index.html')
)
app.get('/js/jquery.js',(req,res)->
  res.sendfile('js/jquery.js')
)
server = require('http').createServer(app)
io = io.listen(server)
server.listen(3000)

io.sockets.on('connection', (socket)->
  socket.emit('news', { hello: 'world' })
  socket.on('auth', (data)->
    for i in [1..10000]
      console.log i
    socket.emit('connected', "yeah token : #{data.token}")
    socket.emit('code', "$('body').append('Hello World ! lalala');")
  )
)

app.get('/token',(req,res)->
  res.send('{"channel": "lalala"}')
)
