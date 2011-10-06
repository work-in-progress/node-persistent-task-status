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

  # The cached instance
  _taskContainerInstance : null
  
  # A task container has a unique name
  constructor: (@name) ->
  
  
  addTask: (name,opts,cb) ->
    instance =new schema.TaskModel()
    instance.name = name
    @_taskContainerInstance.tasks.push instance
    @_taskContainerInstance.save (err) =>
      return cb(err) if err?
      t = new Task()._init(instance)
      cb null,t
      
  # Looks for the next task that has not been completed
  getNextTask: (name,cb) =>
    cb null

  # Returns a task by name.
  # 
  getTask: (name,cb) =>
    cb null

  # Retrieves all tasks belonging to this task container
  getTasks: (cb) =>
    tasks = ( new Task()._init(instance) for instance in @_taskContainerInstance.tasks)
    cb null,tasks
    
    
  deleteTask: (taskNameOrTask,cb) ->
    cb null
  
  updateTask: (taskNameOrTask,values,cb) ->  
    cb null

  _init: (instance) ->
    @_taskContainerInstance = instance
    @name = instance.name
    
  _create: (cb) ->
    instance = new schema.TaskContainerModel()
    instance.name = @name
    
    instance.save (e) =>
      @_taskContainerInstance = instance
      return cb(e) if e?
      cb null