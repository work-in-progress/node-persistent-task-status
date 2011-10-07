vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

mongoose = require 'mongoose'
specHelper = require './spec_helper'

defaultContainerName = "freshfugu:epf:20110930"
defaultTask1Name = "task1"
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

  .export module

