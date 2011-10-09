# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#
# A task is a tracked unit of work. 
# All tasks listed in a task container are sequential by nature

_ = require 'underscore'
constants = require './constants'
util = require './util'
mongoose = require 'mongoose'
schema = require './schema'


class exports.Task

  # The cached instance (from mongoose)
  # @type {TaskSchema}
  # @private
  _taskInstance: null
  
  # Initializes the task object from the mongoose model object and
  # sets the @see _taskInstance property.
  # @param {!TaskSchema} instance The model from mongoose. Must not be null.
  # @return {!Task} Returns a reference to this to allow for chaining.
  _init: (instance) -> 
    @_taskInstance = instance
    @name = instance.name
    @

  # Parameters for the @see _update method.
  # @typeDoc {object} _UpdateValues
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
  # Internal function that updates this already initialized task with the values provided.
  # @param {_UpdateValues} values The values to be set
  _update: (values) ->
    # add the code here that extracts the properties and assigns them to
    # _instanceTask
    # TODO: Optimize this code through use of utility function, no need
    # to explicitly define all this
    @_taskInstance.name = values.name if values.name?
    @_taskInstance.isComplete = values.isComplete if values.isComplete?      
    @_taskInstance.percentageComplete = values.percentageComplete if values.percentageComplete?
    @_taskInstance.statusText = values.statusText if values.statusText?
    @_taskInstance.taskData = values.taskData if values.taskData?
    @_taskInstance.processingData = values.processingData if values.processingData?
    @_taskInstance.invokeCount = values.invokeCount if values.invokeCount?
    @_taskInstance.lastInvokedAt = values.lastInvokedAt if values.lastInvokedAt?
    @_taskInstance.taskDurationInMilliseconds = values.taskDurationInMilliseconds if values.taskDurationInMilliseconds?
    @_taskInstance.taskEndedAt = values.taskEndedAt if values.taskEndedAt?
    @_taskInstance.leasedTill = values.leasedTill if values.leasedTill?
    @_taskInstance.maxRetries = values.maxRetries if values.maxRetries?
    @_taskInstance.delayBetweenRetriesInSeconds = values.delayBetweenRetriesInSeconds if values.delayBetweenRetriesInSeconds?
    @_taskInstance.hasFailed = values.hasFailed if values.hasFailed?
    
  # Initializes as new task. 
  # @constructor
  # @param {?string} name The unique name (within task container) of this task
  constructor: (@name) ->
  
  # Boolean indicating whether the task has been completed or not.
  # @return {bool} True if this task has been completed, otherwise false.
  isComplete: () ->
    @_taskInstance.isComplete
    
  # The completion percentage of this task. This is to be treated as informative only.
  # @return {number} A number ranging from 0 to 100 
  percentageComplete: () ->
    @_taskInstance.percentageComplete

  # The current status of this task.
  # @return {string} A text. Can be null or empty. Typically a single sentence. 
  statusText: () ->
    @_taskInstance.statusText
    
  # Custom data for this task. This type of data should be considered immutable
  # and contain information necessary to complete the task.
  # @return {object} An object containing custom task data, or null.
  taskData: () ->
    @_taskInstance.taskData
    
  # Data used during processing of this task. This might be intermediate results
  # that you want to save so that you can continue after a failure.
  # @return {object} An object containing processing task data, or null.
  processingData: () ->
    @_taskInstance.processingData 

  # Number of times this task has been invoked. Always increase this before you
  # start a new task.
  # @return {number} A positive integer or 0
  invokeCount: () ->
    @_taskInstance.invokeCount 

  # Set this to the UTC date before you start processing a task.
  # @return {date} The date this task was last invoked at or null if it has not been invoked yet.
  lastInvokedAt: () ->
    @_taskInstance.lastInvokedAt 

  # Set this to the UTC date after you finish processing a task.
  # @return {date} The date this task has ended or null if it has not been invoked yet.
  taskEndedAt: () ->
    @_taskInstance.taskEndedAt 

  # Should contain the total processing time in milliseconds, if applicable.
  # @return {number} The total processing time in milliseconds, or null
  taskDurationInMilliseconds: () ->
    @_taskInstance.taskDurationInMilliseconds 

  # Use this if you want to implement a check out / lease kind of algorithm where tasks are leased 
  # for a specific amount of time and considered a failure/abandoned if not completed within that time frame.
  # @return {date} The date until this task has been leased.
  leasedTill: () ->
    @_taskInstance.leasedTill 

  # The maximum number of reties for this task until it is considered failed.
  # @return {number} An positive integer or 0. 3 to 10 seems like reasonable defaults.
  maxRetries: () ->
    @_taskInstance.maxRetries 

  # Base value indicating how many seconds need to pass between retries.
  # Might be used as a base for multiplier when using exponential back off
  # @return {number} An positive integer or 0. Set this to a non zero value if you perform web requests.
  delayBetweenRetriesInSeconds: () ->
    @_taskInstance.delayBetweenRetriesInSeconds 

  # True only when @see isCompleted is true as well, indicating that the task
  # has failed.
  # @return {bool} True if this task has failed, otherwise false.
  hasFailed: () ->
    @_taskInstance.hasFailed 
  
 
    
    