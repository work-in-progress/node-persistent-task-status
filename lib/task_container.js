(function() {
  var Task, TaskContainer, constants, mongoose, schema, util, _;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  Task = require('./task');
  mongoose = require('mongoose');
  schema = require('./schema');
  module.exports = TaskContainer = (function() {
    TaskContainer.prototype._instance = null;
    function TaskContainer(name) {
      this.name = name;
    }
    TaskContainer.prototype.addTask = function(name, opts, cb) {
      var instance;
      instance = new schema.TaskModel();
      instance.name = this.name;
      this._instance.tasks.push(instance);
      return this._instance.save(__bind(function(err) {
        var t;
        if (err != null) {
          return cb(err);
        }
        t = new Task(name);
        return cb(null, t);
      }, this));
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
      return instance.save(__bind(function(e) {
        this._instance = instance;
        if (e != null) {
          return cb(e);
        }
        return cb(null);
      }, this));
    };
    return TaskContainer;
  })();
}).call(this);
