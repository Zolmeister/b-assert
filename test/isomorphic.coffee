_ = require 'lodash'
assert = require 'assert'

b = require '../src'

describe 'b-assert', ->
  it 'compares equals', ->
    b 'a', 'a'
    b 1, 1
    b true, true
    b false, false
    date = new Date()
    b date, date
    b {a: 'x'}, {a: 'x'}
    b NaN, NaN
    b undefined, undefined
    b null, null
    b true

  it 'runs function for equality', ->
    b 'a', _.isString
    b 1, _.isNumber
    b false, (f) -> f is false

  it 'runs function for value', ->
    b (-> 'a'), 'a'
    err = new Error()
    b (-> throw err), err
    b (-> false), (f) -> f is false

  it 'compares non-equals', ->
    assert.throws ->
      b 'a', 'b'

    assert.throws ->
      b false

  it 'runs function for inequality', ->
    assert.throws ->
      b 'a', -> false

  it 'runs function for value inequality', ->
    assert.throws ->
      b (-> 'a'), 'b'

  it 'returns errors with messages', ->
    try
      b 'a', 'b'
    catch error
      b error.message, 'Expected \'a\' to be \'b\''

    try
      b 'a', -> false
    catch error
      b error.message, 'Expected \'a\' to return true'

    try
      b 'a', 'b', 'msg'
    catch error
      b error.message, 'msg'

    try
      b 'a', (-> false), 'msg'
    catch error
      b error.message, 'msg'

  it 'partials', ->
    bA = b 'a'
    bA 'a'

    assert.throws ->
      bA 'x'

    try
      bA('x', 'msg')
    catch error
      b error.message, 'msg'

  it 'returns undefined', ->
    b b('a', 'a'), undefined
