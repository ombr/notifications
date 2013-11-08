assert = require('chai').assert
sinon = require('sinon')
webdriver = require('wd')


browser = webdriver.remote("localhost", 4445, process.env.SAUCE_USERNAME,process.env.SAUCE_ACCESS_KEY)
browser.on "status", (info) ->
  console.log "\u001b[36m%s\u001b[0m", info

browser.on "command", (meth, path) ->
  console.log " > \u001b[33m%s\u001b[0m: %s", meth, path

desired =
  browserName: 'chrome'
  version: ""
  platform: "Linux"
  tags: ['test']
  name: "Test : #{process.env.TRAVIS_JOB_NUMBER}"
#desired["tunnel-identifier"] = process.env.TRAVIS_JOB_NUMBER

describe('Index', ()->
  it('test?', (done)->
    this.timeout(120000)

    poussette = require '../notification'
    console.log browser
    poussette.app.get('/test', (req, res)->
      res.send('<html><head><title>Hello World</title></head><body></body></html>')
    )
    browser.init desired, ->
      browser.get "http://localhost:5000/test", ->
        browser.source (err, title) ->
          console.log err
          assert.equal(title, '<html><head><title>Hello World</title></head><body></body></html>')
          done()
  )
)
