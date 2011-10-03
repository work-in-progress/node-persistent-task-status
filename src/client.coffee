# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#

_ = require 'underscore'
constants = require './constants'
util = require './util'
TaskContainer = require './task_container'

module.exports = class Client

  # Initializes a new client
  # Takes a hash that can contain
  # opts.connection : mongodb connection (through mongoose) or null
  # opts.connectionUrl : url with database connection info 
  constructor: (opts) ->
    opts ||= {}
    
  getOrCreateTaskContainer : (name,cb) ->   
      cur = new TaskContainer(name)
      cb null,cur