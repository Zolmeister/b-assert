_ = require 'lodash'
util = require 'util'

b = (given, expected, message) ->
  if _.isFunction given
    try
      given = given()
    catch err
      given = err

  givenString = util.inspect given
  thrower = (message) ->
    error = new Error message
    Error.captureStackTrace? error, b
    throw error

  if _.isFunction(expected)
    if not expected(given) is true
      message ?= "Expected #{givenString} to return true"
      thrower message
  else if not _.isEqual given, expected
    expectedString = util.inspect expected
    message ?= "Expected #{givenString} to be #{expectedString}"
    thrower message

module.exports = _.curry b, 2
