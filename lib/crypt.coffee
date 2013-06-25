module.exports = {}

#http://stackoverflow.com/questions/11299659/
#aes-256-cbc-with-digest-from-ruby-to-nodejs
crypto = require('crypto')

module.exports.decrypt = (data, key, iv)->
  encoded   = new Buffer(data, 'base64')
  decodeKey = crypto
    .createHash('sha256').update(key, 'ascii')
    .digest()
  decipher  = crypto.createDecipheriv('aes-256-cbc', decodeKey, new Buffer(iv, 'base64').toString('binary'))

  result = decipher.update(encoded)
  result += decipher.final()
  result
