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
Task = require('./task').Task
mongoose = require 'mongoose'
schema = require './schema'

# A task container that groups individual tasks together.
class exports.TaskContainer

  # The cached instance
  # @type {TaskContainerSchema}
  # @private
  _taskContainerInstance : null
  
  # Initializes as new task container
  # @constructor
  # @param {?string} name The unique name of this task container
  constructor: (@name) ->
  
  
  # Callback that is invoked when calling @see addTask.
  # @typeDoc {function} AddTaskCallback
  # @param {?Error} err The error, if any.
  # @param {?Task} task The task that has been created. 
  ###
  ### 
  # Optional parameters for the addTask method.
  # @typeDoc {object} AddTaskOptions
  # No parameters as of now.
  ###
  ###
  # Add a task to a container. The new task is immediately persisted.
  # @param {string} name The name of the task. Required and must be unique within a container.
  # @param {?AddTaskOptions} opts Additional options. Can be null
  # @param {AddTaskCallback} cb Callback that is invoked on completion.
  addTask: (name,opts,cb) ->
    instance =new schema.TaskModel()
    instance.name = name
    @_taskContainerInstance.tasks.push instance
    @_taskContainerInstance.save (err) =>
      return cb(err) if err?
      t = new Task()._init(instance)
      cb null,t
    
  # Callback that is invoked when calling @getNextTask.
  # @typeDoc {function} GetNextTaskCallback
  # @param {?Error} err The error, if any.
  # @param {?Task} task The next task that can be processed. Can be null if no more tasks are available.
  ###
  ###
  # Gets the next task that has not been completed.
  # @param {string} name The name of the task. Required and must exist.
  # @param {GetNextTaskCallback} cb Callback that is invoked on completion.
  getNextTask: (name,cb) =>
    cb null

  # Callback that is invoked when calling @see getTask.
  # @typeDoc {function} GetNextTaskCallback
  # @param {?Error} err The error, if any.
  # @param {?Task} task The task, Can be null if task is not found.
  ###
  ###
  # Gets the next task that has not been completed.
  # @param {string} name The name of the task. Required.
  # @param {GetTaskCallback} cb Callback that is invoked on completion.
  getTask: (name,cb) =>
    found = _.select(@_taskContainerInstance.tasks, (t) -> t.name == name)
    return cb(null,_.first(found)) if found? && found.length > 0  
    cb null,null

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