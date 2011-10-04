vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

mongoose = require 'mongoose'
specHelper = require './spec_helper'

defaultContainerName = "freshfugu:epf:20110930"

specHelper.connectDatabase()

# Please note that the specs here are mimicing a real use case,
# hence the namespacing with : and stuff.

vows.describe("integration")
  .addBatch
    "CLEANING DATABASE" :
      topic: () -> 
        specHelper.cleanDatabase @callback
        return
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true
  .addBatch 
    "WHEN I access a task container on an empty database": 
      topic:  () -> 
        cb = @callback
        main.client.getTaskContainer('freshfugu:epf:20110930',cb)
        return
      "THEN it must not exist": (err,taskContainer) ->
        assert.isNull err
        assert.isNull taskContainer
  .addBatch 
    "WHEN creating a task container": 
      topic:  () ->
        cb = @callback 
        main.client.getOrCreateTaskContainer(defaultContainerName,cb)
        return
      "must exist": (err,taskContainer) ->
        assert.isNull err
        assert.isNotNull taskContainer      
  .addBatch 
    "WHEN accessing a task container after get or create": 
      topic:  () -> 
        cb = @callback
        main.client.getTaskContainer(defaultContainerName,cb)
        return
      "must exist": (err,taskContainer) ->
        assert.isNull err
        assert.isNotNull taskContainer
  .export module

