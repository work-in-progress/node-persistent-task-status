vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

mongoose = require 'mongoose'
specHelper = require './spec_helper'

defaultContainerName = "freshfugu:epf:20110930"
defaultTask1Name = "task1"

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
    "WHEN creating a task container": 
      topic:  () ->
        main.client.getOrCreateTaskContainer defaultContainerName, (err,taskContainer) =>
          taskContainer.addTask defaultTask1Name,null, @callback
        return
      "THEN it must not fail": (err,task) ->
        assert.isNull err
      "THEN it must exist": (err,task) ->
        assert.isNotNull task      
      "THEN it must have the correct name": (err,task) ->
        assert.equal task.name, defaultTask1Name

  .export module

