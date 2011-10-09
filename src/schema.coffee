# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#

mongoose = require 'mongoose'
Schema = mongoose.Schema

taskSchema =  new Schema

  # The name of the task. Must be unique within it's container
  name : 
    required: true
    type: String
    trim: true
    default: null
  # Boolean indicating whether the task has been completed or not.
  isComplete :
    type: Boolean
    required: true
    default : false    
  # The completion percentage, from 0 to 100.
  percentageComplete : 
    type: Number
    required: true
    default : 0
    min: 0
    max: 100
  # The current status of this task.
  statusText : 
    type: String
    #required: true
    default : ''
  
  # Custom data for this task.
  taskData :
    type:  Schema.Types.Mixed
    #required: true
    default : null
  
  # Custom work result data.
  processingData : 
    type:  Schema.Types.Mixed
    #required: true
    default : null

  # Number of times this task has been invoked.
  invokeCount:
    type: Number
    required: true
    default : 0
    min: 0
  
  # The date when the task was last invoked, UTC, or null
  lastInvokedAt :
    type:  Date
    #required: true
    default : null
  
  # The total processing time in milliseconds, if applicable, or null
  taskDurationInMilliseconds :
    type: Number
    required: false
    default : null
    min: 0
    
  
  # The date when the task has ended, or null.
  taskEndedAt : 
    type:  Date
    #required: true
    default : null

  # The date until this task has been leased (eg is being processed), UTC.
  leasedTill : 
    type:  Date
    #required: true
    default : null
  
  # The maximum number of reties for this task until it is considered failed.
  maxRetries :
    type: Number
    required: true
    default : 3
    min: 0

  # Base value indicating how many seconds need to pass between retries.
  # Might be used as a base for multiplier when using exponential back off
  delayBetweenRetriesInSeconds :
    type: Number
    required: true
    default : 30
    min: 0

  # True only when @see isCompleted is true as well, indicating that the task
  # has failed.
  hasFailed :
    type: Boolean
    required: true
    default : false
  
taskContainerSchema = new Schema
  name : 
    required: true
    type: String
    unique: true
    trim: true
  isComplete : 
    type: Boolean
    required: true
    default : false
  tasks : [taskSchema]

class SchemaAndModels
  TaskSchema : taskSchema
  TaskContainerSchema : taskContainerSchema
  TaskModel : mongoose.model "Task",taskSchema
  TaskContainerModel : mongoose.model "TaskContainer",taskContainerSchema
  

module.exports = new SchemaAndModels
  