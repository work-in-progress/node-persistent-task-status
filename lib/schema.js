(function() {
  var Schema, SchemaAndModels, mongoose, taskContainerSchema, taskSchema;
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
