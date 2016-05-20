
ZEventManager = require "./zeventmanager.coffee"

class ZData
  constructor: (data = {}) ->
    @data = data
    @events = new ZEventManager

  get: (key, def=null) =>
    if (@data[key])
      @data[key]
    else
      def

  set: (key, value) =>
    before = @data[key]
    @data[key] = value
    @events.invoke("change.#{key}", {key: key, before: before, value: value})

module.exports = ZData
