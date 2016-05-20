
class ZSM
  constructor: (states = {}) ->
    @current = null
    @states = {}
    for k,v of states
      v.name = k
      @add(v)

  add: (state) ->
    @states[state.name] = state
    state.parent = @
    state.change = (name) -> @change(name)

  init: (stateName = "init", args = {}) ->
    if (@current != null)
      throw "State already set"
    @__change(stateName, args)

  change: (stateName, args = {}) ->
    @__change(stateName, args)

  signal: (args = {}) ->
    @__change(@current?.signal? args)

  __update: (deltaTime) =>
      @current?.__update?(deltaTime)

  __change: (stateName, args = {}) ->
    if !stateName
      return
    @current?.__exit?()
    res = @current?.exit? args
    if (res)
      stateName = res
    @current = @states[stateName]
    @current?.__enter?()
    @__change(@current?.enter? args)


module.exports = ZSM
