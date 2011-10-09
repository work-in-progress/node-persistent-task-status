vows = require 'vows'
assert = require 'assert'

Task = require('../lib/task').Task
mongoose = require 'mongoose'
schema = require '../lib/schema'


vows.describe("The task").addBatch( 
  "WHEN creating a task": 
    topic: () ->
      taskModel = new schema.TaskModel
      new Task(taskModel)
    "THEN it must exist": (task) ->
      assert.isNotNull task      
).export module

###
"adding a task scope":
  topic: () ->  main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",(e,tc) -> tc.addTask("task1",null,@callback))
  "must exist" : (err,task) ->
    assert.isNull err
    assert.isNotNull task

###
