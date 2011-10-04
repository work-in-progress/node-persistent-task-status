(function() {
  var Schema, mongoose, taskContainerSchema, taskSchema;
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  taskSchema = new Schema({
    name: String,
    percentageComplete: Number,
    taskData: Schema.Types.Mixed,
    instanceData: Schema.Types.Mixed
  });
  taskContainerSchema = new Schema({
    name: String,
    tasks: [taskSchema]
  });
  module.exports = {
    TaskSchema: taskSchema,
    TaskContainerSchema: taskContainerSchema,
    TaskModel: mongoose.model("Task", taskSchema),
    TaskContainerModel: mongoose.model("TaskContainer", taskSchema)
  };
}).call(this);
