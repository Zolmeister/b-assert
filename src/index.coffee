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

  null

 partial = (args...) ->
  if args.length is 1
    if args[0] is false
      try
        b args[0], true
      catch error
        Error.captureStackTrace? error, partial
        throw error
    else
      _.partial b, args[0]
  else
    b args...

module.exports = partial
