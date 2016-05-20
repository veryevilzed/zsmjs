
ZSM = require "../zsm"
ZSMState = require "../zsmstate"
assert = require "assert"



class SInit extends ZSMState
  constructor: ->
    super("init")
    @t1 = 0
    @t2 = 0
    @one 5, @wait
    @one 1, @tick1
    @loop 1, @tick2

  enter: (args) =>
    console.log "--- INIT ---"

  wait: () =>
    @parent.change("ready")

  tick1: () =>
    @t1++

  tick2: () =>
    @t2++

class SReady extends ZSMState
  constructor: ->
    super("ready")

  enter: (args) =>
    console.log "--- READY ---"


describe "state base", () ->

  zsm = new ZSM({
    init:  new SInit
    ready: new SReady
  })
  zsm.init()
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)
  zsm.__update(1)

  assert.equal zsm.states.init.t1, 1
  assert.equal zsm.states.init.t2, 5
