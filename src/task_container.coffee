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

  # The cached instance (from mongoose)
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
  # Additional values for the @see addTask method.
  # @typeDoc {object} AddTaskValues
  # @param {bool} isComplete True if this task has been completed, otherwise false.
  # @param {number} percentageComplete A number ranging from 0 to 100 
  # @param {string} statusText A text. Can be null or empty. Typically a single sentence. 
  # @param {object} taskData An object containing custom task data, or null.
  # @param {object} processingData An object containing processing task data, or null.
  # @param {number} invokeCount A positive integer or 0
  # @param {date} lastInvokedAt The date this task was last invoked at or null if it has not been invoked yet.
  # @param {date} taskEndedAt The date this task has ended or null if it has not been invoked yet.
  # @param {number} taskDurationInMilliseconds The total processing time in milliseconds, or null
  # @param {date} leasedTill The date until this task has been leased.
  # @param {number} maxRetries An positive integer or 0. 3 to 10 seems like reasonable defaults.
  # @param {number} delayBetweenRetriesInSeconds An positive integer or 0. Set this to a non zero value if you perform web requests.
  # @param {bool} hasFailed True if this task has failed, otherwise false.
  ###
  ###
  # Add a task to a container. The new task is immediately persisted.
  # @param {string} name The name of the task. Required and must be unique within a container.
  # @param {?AddTaskValues|null} opts Additional values. Can be null
  # @param {AddTaskCallback} cb Callback that is invoked on completion.
  addTask: (name,values,cb) ->
    values = {} unless values
    
    instance =new schema.TaskModel()
    task = new Task(instance)
  #  task._taskInstance = instance
    task._update values
    instance.name = name
    
    @_taskContainerInstance.tasks.push instance
    @_taskContainerInstance.save (err) =>
      return cb(err) if err?
      task.name = task._taskInstance.name
      #t = t._init(instance) # force reload?
      cb null,task
    
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
    return cb(null,new Task(_.first(found))) if found? && found.length > 0  
    cb null,null

  # Callback that is invoked when calling @see getTasks.
  # @typeDoc {function} GetTasksCallback
  # @param {?Error} err The error, if any.
  # @param {Array.<Task>} tasks An array of @see Task objects. Never null, but the array can be empty.
  ###
  ###
  # Retrieves all tasks belonging to this task container
  # @param {GetTasksCallback} cb Callback that is invoked on completion.
  getTasks: (cb) =>
    tasks = ( new Task(instance) for instance in @_taskContainerInstance.tasks)
    cb null,tasks
    
    
  # Callback that is invoked when calling @see deleteTask.
  # @typeDoc {function} DeleteTaskCallback
  # @param {?Error} err The error, if any.
  # @param {Task} task The task that has been deleted, for reference only. Do not invoke any methods on it, only access properties. Set to null if the task did not exist.
  ###
  ###
  # Deletes a task.
  # @param {string} name The name of the task. Required.
  # @param {DeleteTaskCallback} cb Callback that is invoked on completion.
  deleteTask: (name,cb) =>
    @getTask name, (err,t) =>
      return cb(err) if err?
      return cb(null,null) unless t
      
      t._taskInstance.remove()
      @_taskContainerInstance.save (e) =>
        cb(e) if e?
        t._taskInstance = null
        cb null,t
  
  # Callback that is invoked when calling @see updateTask.
  # @typeDoc {function} UpdateTaskCallback
  # @param {?Error} err The error, if any. A non existing task is an error condition (unlike delete).
  # @param {Task} task The task that has been updated
  ###
  ### 
  # Parameters for the @see updateTask method.
  # @typeDoc {object} UpdateTaskValues
  # @param {?string} name The name of the task. Ignored if null or undefined
  # @param {bool} isComplete True if this task has been completed, otherwise false.
  # @param {number} percentageComplete A number ranging from 0 to 100 
  # @param {string} statusText A text. Can be null or empty. Typically a single sentence. 
  # @param {object} taskData An object containing custom task data, or null.
  # @param {object} processingData An object containing processing task data, or null.
  # @param {number} invokeCount A positive integer or 0
  # @param {date} lastInvokedAt The date this task was last invoked at or null if it has not been invoked yet.
  # @param {date} taskEndedAt The date this task has ended or null if it has not been invoked yet.
  # @param {number} taskDurationInMilliseconds The total processing time in milliseconds, or null
  # @param {date} leasedTill The date until this task has been leased.
  # @param {number} maxRetries An positive integer or 0. 3 to 10 seems like reasonable defaults.
  # @param {number} delayBetweenRetriesInSeconds An positive integer or 0. Set this to a non zero value if you perform web requests.
  # @param {bool} hasFailed True if this task has failed, otherwise false.
  ###
  ###
  # Updates a task.
  # @param {string} name The name of the task. Required and must exist.
  # @param {UpdateTaskValues} values The values to be set
  # @param {UpdateTaskCallback} cb Callback that is invoked on completion.
  updateTask: (name,values,cb) ->  
    @getTask name, (err,t) =>
      return cb(err) if err?
      return cb(new Error("Task '#{name}' not found")) unless t

      t._update(values)
      
      @_taskContainerInstance.save (e) =>
        cb(e) if e?
        t._init t._taskInstance # reload property values
        cb(null,t)
  
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