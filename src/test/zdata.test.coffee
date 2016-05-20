

ZData = require "../zdata"
assert = require "assert"

console.log ZData

class ZMyData extends ZData
  constructor: () ->
    super()
    super({
      a: 5,
      name: "zed"
      })


class ZTestClass
  constructor: () ->
    @data = new ZMyData
    @data.events.add "change.a", @changed
    @data.events.add "change.name", @changed
    @data.set("a", @data.get("a", 0) + 1)
    @data.events.remove("change.name", @changed)
    @data.set("a", @data.get("a", 0) + 1)
    @data.events.clear(@changed)
    @data.set("a", 99)
    @data.set("name", "!!")

  changed: (args) =>
    console.log "a changed: #{args.key} = #{args.value}"



describe "zdata", () ->
  t = new ZTestClass
