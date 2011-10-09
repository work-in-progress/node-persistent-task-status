(function() {
  var Schema, SchemaAndModels, mongoose, taskContainerSchema, taskSchema;
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  taskSchema = new Schema({
    name: String,
    isComplete: Boolean,
    percentageComplete: Number,
    statusText: String,
    taskData: Schema.Types.Mixed,
    processingData: Schema.Types.Mixed,
    invokeCount: Number,
    lastInvokedAt: Date,
    taskDurationInMilliseconds: Number,
    taskEndedAt: Date,
    leasedTill: Date,
    maxRetries: Number,
    delayBetweenRetriesInSeconds: Number,
    hasFailed: Boolean
  });
  taskContainerSchema = new Schema({
    name: String,
    isComplete: Boolean,
    tasks: [taskSchema]
  });
  SchemaAndModels = (function() {
    function SchemaAndModels() {}
    SchemaAndModels.prototype.TaskSchema = taskSchema;
    SchemaAndModels.prototype.TaskContainerSchema = taskContainerSchema;
    SchemaAndModels.prototype.TaskModel = mongoose.model("Task", taskSchema);
    SchemaAndModels.prototype.TaskContainerModel = mongoose.model("TaskContainer", taskContainerSchema);
    return SchemaAndModels;
  })();
  module.exports = new SchemaAndModels;
}).call(this);
