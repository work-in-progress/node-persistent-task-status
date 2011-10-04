vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'

mongoose = require 'mongoose'
specHelper = require './spec_helper'

specHelper.cleanDatabase ->
  specHelper.connectDatabase ->

    # Please note that the specs here are mimicing a real use case,
    # hence the namespacing with : and stuff.

    vows.describe("the main workflow").addBatch( 
      "creating a task scope": 
        topic:  () -> main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",@callback) 
        "must exist": (err,taskContainer) ->
          assert.isNull err
          assert.isNotNull taskContainer      
    ).export module

    ###
    "adding a task scope":
      topic: () ->  main.client.getOrCreateTaskContainer("freshfugu:epf:20110930",(e,tc) -> tc.addTask("task1",null,@callback))
      "must exist" : (err,task) ->
        assert.isNull err
        assert.isNotNull task

    ###
