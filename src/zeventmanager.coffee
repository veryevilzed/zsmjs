
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
    if @listeners[name].indexOf(listener) == -1
      @listeners[name].push listener


  remove: (name, method) =>
    ls = @listeners[name] || []
    console.log ls
    _.remove(ls, (o) -> o == method)

  clear: (method) =>
    for k,v of @listeners
      @remove(k, method)

module.exports = ZEventManager
