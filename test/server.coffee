assert = require 'assert'

example = require '../src'

describe 'server example', ->
  if window?
    return

  it 'compares equals', ->
    res = example.compare 'a', 'a'
    assert.equal res, true
