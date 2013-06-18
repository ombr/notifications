assert = require('chai').assert
sinon = require('sinon')

describe('asasda', ()->
  it('subscribe to redis store if no previous listener', ()->
    # Socket // param ??
    # Channelk // param
    # Callback // param
    # Redis // injection
    # Events // injection


    class Notification
      constructor: (@redis, @events)->
        return
      listen: (channel, callback)->
        @redis.subscribe(channel, callback)


    redis =
      subscribe: sinon.stub()
    events =
      trigger: sinon.stub()


    notification = new Notification(redis, events)

    callback = sinon.spy()
    notification.listen('test', callback)
    assert(redis.subscribe.calledOnce)
    assert(redis.subscribe.calledWith('test'))


  )
  
)
