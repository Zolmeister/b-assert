assert = require 'assert'

example = require '../src'

describe 'browser example', ->
  unless window?
    return

  it 'compares equals', ->
    res = example.compare 'a', 'a'
    assert.equal res, true
