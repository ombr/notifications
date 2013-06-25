assert = require('chai').assert
sinon = require('sinon')

describe('Crypt', ()->

  it('Decrypt', ()->
    Crypt = require('../lib/crypt')
    key='poussette'
    data='L/uU+eE3lvqasw0Y1Bw3srqXaagwlT8R3v8UqSIjrRA='
    iv='H9pshToAiZEb8Ek9NZloGQ=='
    dec = Crypt.decrypt(data, key, iv)
    assert.equal(dec, '["test", "asdasd"]')
  )

  it('Decrypt', ()->
    Crypt = require('../lib/crypt')
    key='poussette'
    data='BIA4AZYPe0Cin76MZSGq0A=='
    iv='qVRdXHW5lTf51Gecb2sxxw=='
    dec = Crypt.decrypt(data, key, iv)
    assert.equal(dec, '["test"]')
  )

)
