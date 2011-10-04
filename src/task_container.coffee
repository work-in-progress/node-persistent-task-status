# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#
# A task container is a unit that contains 0 .. n tasks. The number of tasks
# within a task container should be rather low (less than a thousand).
# Each task container reflects one workflow or entity, however you want to look at this.
# Example: 1 TaskContainer per day per EPF import process
# or 1 TaskContainer per Movie entity in the database.
#
# 

_ = require 'underscore'
constants = require './constants'
util = require './util'
Task = require './task'
mongoose = require 'mongoose'
schema = require './schema'


module.exports = class TaskContainer

  # A task container has a unique name
  constructor: (@name) ->
  
  
  addTask: (name,opts,cb) ->
    t = new Task()
    cb null,t
    
  deleteTask: (task,cb) ->
    cb null
  
  updateTask: (task,values,cb) ->  
    cb null

  _create: (connection,cb) ->
    instance = new schema.TaskContainerModel()
    instance.name = @name
    
    instance.save (e) ->
      return cb(e) if e?
      cb null