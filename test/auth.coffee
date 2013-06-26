assert = require('chai').assert
sinon = require('sinon')

describe('Auth', ()->

  describe('#validate_json_array_of_string', ()->
    it('does not accept empty array', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate('[]'), false)
    )
    describe('#validate_json_array_of_string', ()->
      it('accept single item', ()->
        validate = require('../lib/auth').validate_json_array_of_string
        assert.equal(validate('["test"]'), true)
      )
    )
    it('does not accept trailling space', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate(' ["test"]'), false)
      assert.equal(validate('  ["test"]'), false)
      assert.equal(validate('["test"] '), false)
      assert.equal(validate('["test"]  '), false)
    )

    it('does not accept trailling space', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate('[ "test"]'), true)
      assert.equal(validate('[  "test"]'), true)
      assert.equal(validate('["test" ]'), true)
      assert.equal(validate('["test"  ]'), true)
      assert.equal(validate('[ "test" ]'), true)
    )

    it('accept two channels', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate('[ "test" , "lalala"]'), true)
      assert.equal(validate('["test","lalala"]'), true)
      assert.equal(validate('[ "test", "lalala" ]'), true)
      assert.equal(validate('[ "test" , "lalala" ]'), true)
    )

    it('accept three channels upcase and numbers', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate('[ "tesASD123213" , "la12lASDla"]'), true)
      assert.equal(validate('["test","laASDFADSf12123"]'), true)
      assert.equal(validate('[ "tsad43t", "laaSDFSDF23234lala" ]'), true)
      assert.equal(validate('[ "test1123" , "lalaFFFla" ]'), true)
      assert.equal(validate('[ "test03" , "lalaFFFla" ]'), true)
      assert.equal(validate('[ "test03" , "lal0aFFFla" ]'), true)
    )

    it('does not accept special chars', ()->
      validate = require('../lib/auth').validate_json_array_of_string
      assert.equal(validate('[ "123@#" , "la12lASDla"]'), false)
      assert.equal(validate('["!t"]'), false)
      assert.equal(validate('[ "t^&" , "lalaFFFla" ]'), false)
    )
  )


  it('call listen for each channels', ()->
    listen = sinon
      .stub()
      .returns(true)
    # ["test"]
    require('../lib/auth').auth(
      'MQIr2Y2mrt8QMCsxeIba2w==',
      'y5aDG0V1CZfWjgGGcvQs3w==',
      'poussette',
      listen
    )
    sinon.assert.calledWithMatch(listen, 'test')
  )

  it('does not work with invalid encryted json', ()->
    listen = sinon
      .stub()
      .returns(true)
    #json = ․asdasd;as::A:SdasdAS:D
    require('../lib/auth').auth(
      'xJSBKMLTQtpnrAa2niHkiCa/5JN85MUt07LDVRK3Ltg=',
      'wXcydW7YKN5CHVFBKdVlng==',
      'poussette',
      listen
    )
    sinon.assert.notCalled(listen)
  )

  it('does not work with invalid encryted string', ()->
    listen = sinon
      .stub()
      .returns(true)
    #json = ․asdasd;as::A:SdasdAS:D
    require('../lib/auth').auth(
      'xJSBKMLTQtpnrAa2niHkiCa/5JN85MUt07',
      'wXcydW7YKN5CHVFBKdVlng==asdasd',
      'poussette',
      listen
    )
    sinon.assert.notCalled(listen)
  )
)
