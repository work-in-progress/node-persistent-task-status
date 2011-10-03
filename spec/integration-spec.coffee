vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

# Please note that the specs here are mimicing a real use case,
# hence the namespacing with : and stuff.

vows.describe("the main workflow").addBatch( 
  "creating a task scope": 
    topic:  () -> main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",@callback) 
    "must exist": (err,taskContainer) ->
      assert.isNull err
      assert.isNotNull taskContainer
).export module