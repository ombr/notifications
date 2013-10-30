if process.env.NEW_RELIC_LICENSE_KEY? and process.env.NEW_RELIC_APP_NAME
  require('newrelic');
module.exports = {}
express = require('express')
io = require('socket.io')
fs=require('fs')
app = express()
app.use(express.static(__dirname + '/public'))

server = require('http').createServer(app)
io = io.listen(server, {log: false})
io.configure(()->
  io.set("transports", ["xhr-polling"])
  io.set("polling duration", 10)
)
server.listen(process.env.PORT || 5000)

EventEmitter = require('events').EventEmitter
events = new EventEmitter

if (process.env.REDISTOGO_URL)
  rtg   = require("url").parse(process.env.REDISTOGO_URL)
  redis = require("redis").createClient(rtg.port, rtg.hostname)
  redis.auth(rtg.auth.split(":")[1])
else
  redis = require("redis").createClient()


# We should add removeListener before newListener
events.on('removeListener', (channel)->
  #console.log EventEmitter.listenerCount(events, channel)
  if events.listeners(channel).length == 0
    console.log "REDIS UNSUBSCRIBE : #{channel}"
    redis.unsubscribe(channel)
)
events.on('newListener', (channel)->
  #console.log EventEmitter.listenerCount(events, channel)
  if events.listeners(channel).length == 0
    console.log "REDIS SUBSCRIBE : #{channel}"
    redis.subscribe(channel)
)

listen = (socket, channel)->
  callback = (message)->
    socket.emit('code', message)
  events.on(channel, callback)
  socket.on('disconnect', ()->
    events.removeListener(channel, callback)
  )


auth = require('./lib/auth').auth

io.sockets.on('connection', (socket)->
  socket.on('auth', (data)->
    auth(data.token, data.iv, process.env.POUSSE_SECRET, (channel)->
      listen(socket, channel)
    )
  )
)

redis.on("message", (channel, message)->
  #console.log("client1 channel " + channel + ": " + message)
  events.emit(channel, message)
)
