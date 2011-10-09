# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#
# The client is the primary, front facing mechanism. 
# The default instance is exposed as client.

_ = require 'underscore'
constants = require './constants'
mongoose = require 'mongoose'
util = require './util'
TaskContainer = require('./task_container').TaskContainer
schema = require './schema'

class exports.Client
  
  # Initializes a new client
  # @constructor
  constructor: () ->
  
  # Callback that is invoked when calling @see getTaskContainer.
  # @typeDoc {function} GetTaskContainerCallback
  # @param {?Error} err The error, if any.
  # @param {?TaskContainer} taskContainer The task container object, or null if no task has been found.
  ###
  ###
  # Returns a task container..
  # @param {string} name The name of the task container. Required.
  # @param {GetTaskContainerCallback} cb Callback that is invoked on completion.
  getTaskContainer : (name,cb) =>       
    schema.TaskContainerModel.findOne name : name,(e,doc) =>
      return cb(e) if e? 
      return cb(null,null) unless doc?
      
      taskContainer = new TaskContainer(doc.name)  
      taskContainer._init(doc)    
      cb null,taskContainer
    

  # Callback that is invoked when calling @see getOrCreateTaskContainer.
  # @typeDoc {function} GetOrCreateTaskContainerCallback
  # @param {?Error} err The error, if any.
  # @param {?TaskContainer} taskContainer The task container object.
  # @param {Boolean} isNew True if this is a new task container, otherwise false.
  ###
  ###
  # Returns a task container or creates a new one if it does not exist.
  # @param {string} name The name of the task container. Required.
  # @param {GetOrCreateTaskContainerCallback} cb Callback that is invoked on completion.
  getOrCreateTaskContainer : (name,cb) =>  
    @getTaskContainer name, (e,tc) ->
      return cb(e) if e?
      return cb(null,tc,false) if tc?
      
      tc = new TaskContainer(name)
      
      tc._create  (e) ->
        return cb e if e?
        cb null,tc,true
     
  # Callback that is invoked when calling @see deleteTaskContainer.
  # @typeDoc {function} DeleteTaskContainerCallback
  # @param {?Error} err The error, if any.
  # @param {String} name The name of the deleted task container
  ###
  ###
  # Deletes a task container from the store. If it does not exist then
  # it is simply ignored
  # @param {string} name The name of the task container. Required.
  # @param {DeleteTaskContainerCallback} cb Callback that is invoked on completion.
  deleteTaskContainer : (name,cb) ->
    schema.TaskContainerModel.remove name : name, (e) ->
      return cb(e) if e?
      cb null, name
