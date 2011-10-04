# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#
# A task is a tracked unit of work. 
# All tasks listed in a task container are sequential by nature
# A task can reference another task container as a sub task

_ = require 'underscore'
constants = require './constants'
util = require './util'

module.exports = class Task

  # A task container has a unique name
  constructor: (@name) ->
  
  
  isComplete: () ->
    false
  
  processingState:() ->
    @processingState
  
  percentageComplete : () ->
    23.0
    
  percentageCompleteAsString : () ->
    "23%"
  
  statusText: () ->
    "Retrieving a file"

  retryCount: () ->
    0
    
  maxRetries: () ->
    100
    
  delayBetweenRetriesInSeconds: () ->
    2
    
    