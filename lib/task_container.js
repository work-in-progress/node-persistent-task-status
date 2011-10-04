(function() {
  var Task, TaskContainer, constants, mongoose, schema, util, _;
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  Task = require('./task');
  mongoose = require('mongoose');
  schema = require('./schema');
  module.exports = TaskContainer = (function() {
    function TaskContainer(name) {
      this.name = name;
    }
    TaskContainer.prototype.addTask = function(name, opts, cb) {
      var t;
      t = new Task();
      return cb(null, t);
    };
    TaskContainer.prototype.deleteTask = function(task, cb) {
      return cb(null);
    };
    TaskContainer.prototype.updateTask = function(task, values, cb) {
      return cb(null);
    };
    TaskContainer.prototype._create = function(cb) {
      var instance;
      instance = new schema.TaskContainerModel();
      instance.name = this.name;
      return instance.save(function(e) {
        if (e != null) {
          return cb(e);
        }
        return cb(null);
      });
    };
    return TaskContainer;
  })();
}).call(this);
