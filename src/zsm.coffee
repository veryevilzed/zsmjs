
class ZSM
  constructor: (states = {}) ->
    @current = null
    @states = {}
    for k,v of states
      v.name = k
      @add(v)


  add: (state) ->
    @states[state.name] = state
    state.parent = this

  init: (stateName, args = {}) ->
    if (@current != null)
      throw "State already set"
    @__change(stateName, args)

  __change: (stateName, args = {}) ->
    if (@current && @current.exit)
      res = @current.exit args
      if (res)
        stateName = res
    @current = @states[stateName]
    if (@current.enter)
      res = @current.enter args
      if (res)
        @__change(res)

  change: (stateName, args = {}) ->
    @__change(stateName, args)

  signal: (args = {}) ->
    if (@current && @current.signal)
      res = @current.signal args
      if res
        @__change(res)



module.exports = ZSM
