
_ = require('lodash')

class ZSMState
  constructor: (name) ->
    @name = name
    @timers = { one: [], loop: [] }

  __update_timer: (deltaTime) ->

    if !@timers
      return



    for o in @timers.one || []
      if !o.used
        o.timeout -= deltaTime
        if (o.timeout<=0)
          o.exec()
          o.used = true;



    for o in @timers.loop || []
      o.timeout -= deltaTime
      if (o.timeout<=0)
        o.exec()
        o.timeout = o.init

  __update: (deltaTime) =>
    @__update_timer?(deltaTime)
    @update?(deltaTime)

  one: (timeout, callback) ->
    @timers.one.push( { exec: callback, timeout: timeout, init: timeout, used: false } )
    callback

  loop: (timeout, initTimeout, callback) ->
    if !callback
      callback = initTimeout
      initTimeout = timeout

    @timers.loop.push( { exec: callback, timeout: timeout, init: initTimeout } )
    callback

  __enter: (args) ->
    for o in @timers.one?
      o.timeout = o.init
      o.used = false

    for o in @timers.loop?
      o.timeout = o.init

module.exports = ZSMState
