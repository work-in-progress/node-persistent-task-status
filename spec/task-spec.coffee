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
    "THEN it must return a task with a valid _taskInstance": (task) ->
      assert.isNotNull task._taskInstance      
    "THEN it must return a task whose name is null": (task) ->
      assert.isNull task.name
    "THEN it must return a task whose isComplete property is false": (task) ->
      assert.isFalse task.isComplete()     
    "THEN it must return a task whose hasFailed property is false": (task) ->
      assert.isFalse task.hasFailed()     
    "THEN it must return a task whose percentageComplete is 0": (task) ->
      assert.equal task.percentageComplete(),0
    "THEN it must return a task whose statusText is empty": (task) ->
      assert.equal task.statusText(),""
    "THEN it must return a task whose invokeCount is 0": (task) ->
      assert.equal task.invokeCount(),0
    "THEN it must return a task whose taskDurationInMilliseconds is null": (task) ->
      assert.isNull task.taskDurationInMilliseconds()
    "THEN it must return a task whose maxRetries is 3": (task) ->
      assert.equal task.maxRetries(),3
    "THEN it must return a task whose delayBetweenRetriesInSeconds is 30": (task) ->
      assert.equal task.delayBetweenRetriesInSeconds(),30
    "THEN it must return a task whose taskData is null": (task) ->
      assert.isNull task.taskData()
    "THEN it must return a task whose processingData has is null": (task) ->
      assert.isNull task.processingData()
    "THEN it must return a task whose lastInvokedAt is null": (task) ->
      assert.isNull task.lastInvokedAt()
    "THEN it must return a task whose taskEndedAt is Null": (task) ->
      assert.isNull task.taskEndedAt()
    "THEN it must return a task whose leasedTill isNull": (task) ->
      assert.isNull task.leasedTill()
        
).export module

###
"adding a task scope":
  topic: () ->  main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",(e,tc) -> tc.addTask("task1",null,@callback))
  "must exist" : (err,task) ->
    assert.isNull err
    assert.isNotNull task

###
