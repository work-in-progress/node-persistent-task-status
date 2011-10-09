# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#

mongoose = require 'mongoose'
Schema = mongoose.Schema

taskSchema =  new Schema

  # The name of the task. Must be unique within it's container
  name : String
  # Boolean indicating whether the task has been completed or not.
  isComplete : Boolean
  # The completion percentage, from 0 to 100.
  percentageComplete : Number
  # The current status of this task.
  statusText : String
  # Custom data for this task.
  taskData : Schema.Types.Mixed
  # Custom work result data.
  processingData : Schema.Types.Mixed

  # Number of times this task has been invoked.
  invokeCount : Number
  
  # The date when the task was last invoked, UTC, or null
  lastInvokedAt : Date
  
  # The total processing time in milliseconds, if applicable, or null
  taskDurationInMilliseconds : Number
  
  # The date when the task has ended, or null.
  taskEndedAt : Date

  # The date until this task has been leased (eg is being processed), UTC.
  leasedTill : Date
  
  # The maximum number of reties for this task until it is considered failed.
  maxRetries : Number 

  # Base value indicating how many seconds need to pass between retries.
  # Might be used as a base for multiplier when using exponential back off
  delayBetweenRetriesInSeconds : Number
  
  # True only when @see isCompleted is true as well, indicating that the task
  # has failed.
  hasFailed : Boolean
  
taskContainerSchema = new Schema
  name : String
  isComplete : Boolean
  tasks : [taskSchema]

class SchemaAndModels
  TaskSchema : taskSchema
  TaskContainerSchema : taskContainerSchema
  TaskModel : mongoose.model "Task",taskSchema
  TaskContainerModel : mongoose.model "TaskContainer",taskContainerSchema
  

module.exports = new SchemaAndModels
  