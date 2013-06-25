assert = require('chai').assert
sinon = require('sinon')

describe('Encrypt', ()->

  it('decrypt', ()->
    Crypt = require('../lib/crypt')
    source = "Here is some data for the coding"
    c = "rShSmqpB/ILClbRl82HqFFtoj6zEKU1FSqG0uykYFE2yPsVAquddl8981JEf\nvZwp\n"
    key = 'superKey'
    iv = '1234567890123456'
    dec = Crypt.decrypt(key, iv, c)
    assert.equal(dec, source)
  )
)
