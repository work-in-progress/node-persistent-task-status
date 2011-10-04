vows = require 'vows'
assert = require 'assert'

Task = require '../lib/task'

# Please note that the specs here are mimicing a real use case,
# hence the namespacing with : and stuff.

vows.describe("The task").addBatch( 
  "creating a task scope": 
    topic: new(Task)
    "must exist": (task) ->
      assert.isNotNull task      
).export module

###
"adding a task scope":
  topic: () ->  main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",(e,tc) -> tc.addTask("task1",null,@callback))
  "must exist" : (err,task) ->
    assert.isNull err
    assert.isNotNull task

###
