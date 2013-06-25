crypto = require('crypto')

#http://stackoverflow.com/questions/11299659/
#aes-256-cbc-with-digest-from-ruby-to-nodejs
module.exports = {}
crypto = require('crypto')
module.exports.decrypt = (key, iv, data)->
  encoded   = new Buffer(data, 'base64')
  decodeKey = crypto
    .createHash('sha256').update(key, 'ascii')
    .digest()
  decipher  = crypto.createDecipheriv('aes-256-cbc', decodeKey, iv)

  result = decipher.update(encoded)
  result += decipher.final()
  result
