vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

mongoose = require 'mongoose'
specHelper = require './spec_helper'

defaultContainerName = "freshfugu:epf:20110930"
alternateTaskName = "task1"
defaultTask2Name = "task2"

specHelper.connectDatabase()

# Please note that the specs here are mimicing a real use case,
# hence the namespacing with : and stuff.

vows.describe("integration_task")
  .addBatch
    "CLEANING DATABASE" :
      topic: () -> 
        specHelper.cleanDatabase @callback
        return
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true
  .addBatch 
    "WHEN creating a task container without tasks and we call getTasks": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTasks  @callback
        return
      "THEN it must not fails": (err,tasks) ->
        assert.isNull err
      "THEN it must be an array": (err,tasks) ->
        assert.isArray tasks
      "THEN it must return an empty array": (err,tasks) ->
        assert.equal tasks.length,0
        
  .addBatch 
    "WHEN creating a task container and adding a task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.addTask defaultTask2Name,null, @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must exist": (err,task) ->
        assert.isNotNull task      
      "THEN it must have the correct name": (err,task) ->
        assert.equal task.name, defaultTask2Name
  .addBatch 
    "WHEN retrieving an existing task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTask defaultTask2Name, @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must exist": (err,task) ->
        assert.isNotNull task      
      "THEN it must have the correct name": (err,task) ->
        assert.equal task.name, defaultTask2Name
      "THEN it must have it's instance assigned": (err,task) ->
        assert.isNotNull task._taskInstance
        
  .addBatch 
    "WHEN retrieving a non existant task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTask "somenonexistantname", @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must not exist": (err,task) ->
        assert.isNull task      
  .addBatch 
    "WHEN accessing a task container with 1 task and we call getTasks": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTasks  @callback
        return
      "THEN it must not fails": (err,tasks) ->
        assert.isNull err
      "THEN it must be an array": (err,tasks) ->
        assert.isArray tasks
      "THEN it must return an array with 1 item": (err,tasks) ->
        assert.equal tasks.length,1
      "THEN the first task must have the right name": (err,tasks) ->
        assert.equal tasks[0].name,defaultTask2Name
      "THEN the first task must have it's instance assigned": (err,tasks) ->
        assert.isNotNull tasks[0]._taskInstance

  .addBatch 
    "WHEN changing the name of a nonexisting task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.updateTask "blah", name : alternateTaskName , @callback
        return
      "THEN it must fail": (err,task) ->
        assert.isNotNull err
  
  .addBatch 
    "WHEN changing the name of an existing task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.updateTask defaultTask2Name, name : alternateTaskName , @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must return a task": (err,task) ->
        assert.isNotNull task      
      "THEN it must return a task with a valid _taskInstance": (err,task) ->
        assert.isNotNull task._taskInstance      
      "THEN it must return a task whose name has been changed": (err,task) ->
        assert.equal task.name,alternateTaskName     
  .addBatch 
    "WHEN changing the name back and update the other props of an existing task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.updateTask alternateTaskName, 
              name : defaultTask2Name
              isComplete : true
              percentageComplete : 65
              statusText: "Status TEXT"
              taskData: 
                foo: 'bar'
              processingData:
                hello: 'world'
              invokeCount : 2
              taskDurationInMilliseconds : 3291
              maxRetries : 67
              delayBetweenRetriesInSeconds : 19
              hasFailed : true
              lastInvokedAt :  Date(3001)
              taskEndedAt : Date(4002)
              leasedTill : Date(5003)
            , @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must return a task": (err,task) ->
        assert.isNotNull task      
      "THEN it must return a task with a valid _taskInstance": (err,task) ->
        assert.isNotNull task._taskInstance      
      "THEN it must return a task whose name has been changed": (err,task) ->
        assert.equal task.name,defaultTask2Name     
      "THEN it must return a task whose isComplete property has changed": (err,task) ->
        assert.isTrue task.isComplete()     
      "THEN it must return a task whose hasFailed property has changed": (err,task) ->
        assert.isTrue task.hasFailed()     
      "THEN it must return a task whose percentageComplete has been changed": (err,task) ->
        assert.equal task.percentageComplete(),65
      "THEN it must return a task whose statusText has been changed": (err,task) ->
        assert.equal task.statusText(),"Status TEXT"
      "THEN it must return a task whose invokeCount has been changed": (err,task) ->
        assert.equal task.invokeCount(),2
      "THEN it must return a task whose taskDurationInMilliseconds has been changed": (err,task) ->
        assert.equal task.taskDurationInMilliseconds(),3291
      "THEN it must return a task whose maxRetries has been changed": (err,task) ->
        assert.equal task.maxRetries(),67
      "THEN it must return a task whose delayBetweenRetriesInSeconds has been changed": (err,task) ->
        assert.equal task.delayBetweenRetriesInSeconds(),19
      "THEN it must return a task whose taskData has been changed": (err,task) ->
        assert.isNotNull task.taskData()
      "THEN it must return a task whose taskData has been changed and contains a value": (err,task) ->
        assert.equal task.taskData().foo, "bar"
      "THEN it must return a task whose processingData has been changed": (err,task) ->
        assert.isNotNull task.processingData()
      "THEN it must return a task whose processingData has been changed and contains a value": (err,task) ->
        assert.equal task.processingData().hello, "world"
      "THEN it must return a task whose lastInvokedAt has been changed": (err,task) ->
        assert.equal task.lastInvokedAt(),Date(3001)
      "THEN it must return a task whose taskEndedAt has been changed": (err,task) ->
        assert.equal task.taskEndedAt(),Date(4002)
      "THEN it must return a task whose leasedTill has been changed": (err,task) ->
        assert.equal task.leasedTill(),Date(5003)
        
  .addBatch 
    "WHEN reloading the changed task the props still need to be correct": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTask defaultTask2Name, @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must return a task": (err,task) ->
        assert.isNotNull task      
      "THEN it must return a task with a valid _taskInstance": (err,task) ->
        assert.isNotNull task._taskInstance      
      "THEN it must return a task whose name has been changed": (err,task) ->
        assert.equal task.name,defaultTask2Name     
      "THEN it must return a task whose isComplete property has changed": (err,task) ->
        assert.isTrue task.isComplete()     
      "THEN it must return a task whose hasFailed property has changed": (err,task) ->
        assert.isTrue task.hasFailed()     
      "THEN it must return a task whose percentageComplete has been changed": (err,task) ->
        assert.equal task.percentageComplete(),65
      "THEN it must return a task whose statusText has been changed": (err,task) ->
        assert.equal task.statusText(),"Status TEXT"
      "THEN it must return a task whose invokeCount has been changed": (err,task) ->
        assert.equal task.invokeCount(),2
      "THEN it must return a task whose taskDurationInMilliseconds has been changed": (err,task) ->
        assert.equal task.taskDurationInMilliseconds(),3291
      "THEN it must return a task whose maxRetries has been changed": (err,task) ->
        assert.equal task.maxRetries(),67
      "THEN it must return a task whose delayBetweenRetriesInSeconds has been changed": (err,task) ->
        assert.equal task.delayBetweenRetriesInSeconds(),19
      "THEN it must return a task whose taskData has been changed": (err,task) ->
        assert.isNotNull task.taskData()
      "THEN it must return a task whose taskData has been changed and contains a value": (err,task) ->
        assert.equal task.taskData().foo, "bar"
      "THEN it must return a task whose processingData has been changed": (err,task) ->
        assert.isNotNull task.processingData()
      "THEN it must return a task whose processingData has been changed and contains a value": (err,task) ->
        assert.equal task.processingData().hello, "world"
      "THEN it must return a task whose lastInvokedAt has been changed": (err,task) ->
        assert.equal task.lastInvokedAt(),Date(3001)
      "THEN it must return a task whose taskEndedAt has been changed": (err,task) ->
        assert.equal task.taskEndedAt(),Date(4002)
      "THEN it must return a task whose leasedTill has been changed": (err,task) ->
        assert.equal task.leasedTill(),Date(5003)

  .addBatch 
    "WHEN deleting an existing task (we changed the name previously)": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.deleteTask defaultTask2Name, @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must return a task": (err,task) ->
        assert.isNotNull task      
      "THEN it must return a task with a _taskInstance set to null": (err,task) ->
        assert.isNull task._taskInstance      
      "THEN it must return a task whose properties are still accessible": (err,task) ->
        assert.equal task.name,defaultTask2Name     
      # TODO: We need to make sure that the task has been removed from the mongoose array too.
  .addBatch 
    "WHEN accessing a task container after we deleted the only task and we call getTasks": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.getTasks  @callback
        return
      "THEN it must not fails": (err,tasks) ->
        assert.isNull err
      "THEN it must be an array": (err,tasks) ->
        assert.isArray tasks
      "THEN it must return an array with 0 item": (err,tasks) ->
        assert.equal tasks.length,0
        
  .addBatch 
    "WHEN deleting a nonexisting task": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.deleteTask "somename", @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must return null as task": (err,task) ->
        assert.isNull task


  .export module

