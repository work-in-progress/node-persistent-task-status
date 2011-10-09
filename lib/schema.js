(function() {
  var Schema, SchemaAndModels, mongoose, taskContainerSchema, taskSchema;
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  taskSchema = new Schema({
    name: {
      required: true,
      type: String,
      trim: true,
      "default": null
    },
    isComplete: {
      type: Boolean,
      required: true,
      "default": false
    },
    percentageComplete: {
      type: Number,
      required: true,
      "default": 0,
      min: 0,
      max: 100
    },
    statusText: {
      type: String,
      "default": ''
    },
    taskData: {
      type: Schema.Types.Mixed,
      "default": null
    },
    processingData: {
      type: Schema.Types.Mixed,
      "default": null
    },
    invokeCount: {
      type: Number,
      required: true,
      "default": 0,
      min: 0
    },
    lastInvokedAt: {
      type: Date,
      "default": null
    },
    taskDurationInMilliseconds: {
      type: Number,
      required: false,
      "default": null,
      min: 0
    },
    taskEndedAt: {
      type: Date,
      "default": null
    },
    leasedTill: {
      type: Date,
      "default": null
    },
    maxRetries: {
      type: Number,
      required: true,
      "default": 3,
      min: 0
    },
    delayBetweenRetriesInSeconds: {
      type: Number,
      required: true,
      "default": 30,
      min: 0
    },
    hasFailed: {
      type: Boolean,
      required: true,
      "default": false
    }
  });
  taskContainerSchema = new Schema({
    name: {
      required: true,
      type: String,
      unique: true,
      trim: true
    },
    isComplete: {
      type: Boolean,
      required: true,
      "default": false
    },
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
