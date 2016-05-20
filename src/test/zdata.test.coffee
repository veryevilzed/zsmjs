

ZData = require "../zdata"
assert = require "assert"

console.log ZData

class ZMyData extends ZData
  constructor: () ->
    super()
    # super({
    #   a: 5,
    #   name: "zed"
    #   })


class ZTestClass
  constructor: () ->
    @data = new ZMyData
    @data.events.add "change.a", @changed
    @data.set("a", 6)

  changed: () ->
    console.log "a changed"


describe "zdata", () ->
  t = new ZTestClass
