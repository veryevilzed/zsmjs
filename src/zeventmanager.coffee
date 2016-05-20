
_ = require('lodash')

class ZEventManager
  constructor: (listeners = {}) ->
    @listeners = listeners

  invoke: (name, args={}) =>
    for listener in @listeners[name] || []
      listener(args)

  add: (name, listener) =>
    if !@listeners[name]
      @listeners[name] = []
    @listeners[name].push listener


  remove: (name, method) =>
    ls = @listeners[name] || []
    _.remove(ls, (o) -> o == method)

  clear: (method) =>
    for k,v in @listeners
      remove(k, method)

module.exports = ZEventManager
