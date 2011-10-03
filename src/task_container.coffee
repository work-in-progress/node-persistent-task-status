# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#

_ = require 'underscore'
constants = require './constants'
util = require './util'

module.exports = class TaskContainer

  # A task container has a unique name
  constructor: (@name) ->
  
