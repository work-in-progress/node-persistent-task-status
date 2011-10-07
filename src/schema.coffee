# (C) 2011 Martin Wawrusch (http://martinatsunset.com)
# MIT licensed
#

mongoose = require 'mongoose'
Schema = mongoose.Schema

taskSchema =  new Schema
  name : String
  percentageComplete : Number
  taskData : Schema.Types.Mixed
  instanceData : Schema.Types.Mixed

taskContainerSchema = new Schema
  name : String
  tasks : [taskSchema]

class SchemaAndModels
  TaskSchema : taskSchema
  TaskContainerSchema : taskContainerSchema
  TaskModel : mongoose.model "Task",taskSchema
  TaskContainerModel : mongoose.model "TaskContainer",taskContainerSchema
  

module.exports = new SchemaAndModels
  