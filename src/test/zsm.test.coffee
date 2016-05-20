

ZSM = require "../zsm"
assert = require "assert"

describe "zsm base", () ->
    zsm = new ZSM({
      init:
        data: "HI"
        enter: () ->
          console.log "Enter State Init"
        exit: () ->
          console.log "Exit State Init"
      ready: {
        data: "READY", enter: () -> console.log "Enter State Ready"
      }
    })
    zsm.init("init")

    assert.equal zsm.current.data, "HI"
    zsm.__change("ready")
    assert.equal zsm.current.data, "READY"


describe "zsm auto", () ->
    zsm = new ZSM({
      init:
        data: "HI"
        enter: () ->
          console.log "Enter State Init"
          "ready"
        exit: () ->
          console.log "Exit State Init"
      ready: {
        data: "READY", enter: () -> console.log "Enter State Ready"
      }
    })
    zsm.init("init")
    assert.equal zsm.current.data, "READY"


describe "zsm signal", () ->
    zsm = new ZSM({
      init:
        data: "HI"
        enter: () ->
          console.log "Enter State Init"
        signal: (arg) ->
          return "ready"
        exit: () ->
          console.log "Exit State Init"
      ready: {
        data: "READY", enter: () -> console.log "Enter State Ready"
      }
    })
    zsm.init("init")
    zsm.signal("")
    assert.equal zsm.current.data, "READY"


describe "zsm parent", () ->
    zsm = new ZSM({
      init:
        data: "HI"
        enter: () ->
          console.log "Enter State Init"
        signal: (arg) ->
          @parent.change("ready")
          return null
        exit: () ->
          console.log "Exit State Init"
      ready: {
        data: "READY", enter: () -> console.log "Enter State Ready"
      }
    })
    zsm.init("init")
    zsm.signal("")
    assert.equal zsm.current.data, "READY"

class Init

describe "zsm state", () ->
  zsm = new ZSM();


_ = require('lodash')

describe "t", () ->
  a = [1,2,3]

  _.remove(a, (i) -> i == 1 )

  for i in t?
    console.log i

  assert.equal a[0], 2
