# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#
# The client is the primary, front facing mechanism. 
# The default instance is exposed as client.
# Required features:
# getOrCreate a TaskContainer
# delete a TaskContainer
# clients can be case insensitive (should be default) - if so then the names are automatically converted

_ = require 'underscore'
constants = require './constants'
mongoose = require 'mongoose'
util = require './util'
TaskContainer = require './task_container'
schema = require './schema'

module.exports = class Client
  caseSensitiveNames : false
  
  # Initializes a new client
  # Takes a hash that can contain
  # opts.connection : mongodb connection (through mongoose) or null
  # opts.connectionUrl : url with database connection info 
  # opts.caseSensitiveNames : true | false, optional. When set to false all names will be converted to downcase before saving / accessing
  constructor: (opts) ->
    opts = opts || {}
    @caseSensitiveName = opts.caseSensitiveNames if opts.caseSensitiveNames? 


  # Gets a task container, if it exists.
  # Callback parameters
  # err: Set to an Error object in case of error.
  # tc: The TaskContainer object, or null if it does not exists 
  getTaskContainer : (name,cb) =>       
    schema.TaskContainerModel.findOne name : name,(e,doc) =>
      return cb(e) if e? 
      return cb(null,null) unless doc?
      
      tc = new TaskContainer(doc.name)      
      cb null,tc
    
  # Gets or creates a task container.
  # Callback parameters
  # err: Set to an Error object in case of error.
  # tc: TaskContainer object
  # isNew : true if this task container has been newly created, otherwise false
  getOrCreateTaskContainer : (name,cb) =>  
    @getTaskContainer name, (e,tc) ->
      return cb(e) if e?
      return cb(null,tc,false) if tc?
      
      tc = new TaskContainer(name)
      
      tc._create  (e) ->
        return cb e if e?
        cb null,tc,true
    
  # Deletes a task container from the store. If it does not exist then
  # it is simply ignored
  # Callback parameters:
  # err: Set to an Error object in case of error.
  # name: Set to the name of the task container that has been deleted.
  deleteTaskContainer : (name,cb) ->
    schema.TaskContainerModel.remove name : name, (e) ->
      return cb(e) if e?
      cb null, name
