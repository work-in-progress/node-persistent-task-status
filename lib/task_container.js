(function() {
  var Task, constants, mongoose, schema, util, _;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  Task = require('./task').Task;
  mongoose = require('mongoose');
  schema = require('./schema');
  exports.TaskContainer = (function() {
    TaskContainer.prototype._taskContainerInstance = null;
    function TaskContainer(name) {
      this.name = name;
      this.getTasks = __bind(this.getTasks, this);
      this.getTask = __bind(this.getTask, this);
      this.getNextTask = __bind(this.getNextTask, this);
    }
    /*
      # Callback that is invoked when adding a task.
      # @typeDoc {function} AddTaskCallback
      # @param {?Error} err The error, if any.
      # @param {?Task} task The task that has been created. 
      */
    /* 
    # Optional parameters for the addTask method.
    # @typeDoc {object} AddTaskOptions
    # No parameters as of now.
    */
    TaskContainer.prototype.addTask = function(name, opts, cb) {
      var instance;
      instance = new schema.TaskModel();
      instance.name = name;
      this._taskContainerInstance.tasks.push(instance);
      return this._taskContainerInstance.save(__bind(function(err) {
        var t;
        if (err != null) {
          return cb(err);
        }
        t = new Task()._init(instance);
        return cb(null, t);
      }, this));
    };
    /*
      # Callback that is invoked when getting the next task to process.
      # @typeDoc {function} GetNextTaskCallback
      # @param {?Error} err The error, if any.
      # @param {?Task} task The next task that can be processed. Can be null if no more tasks are available.
      */
    TaskContainer.prototype.getNextTask = function(name, cb) {
      return cb(null);
    };
    TaskContainer.prototype.getTask = function(name, cb) {
      return cb(null);
    };
    TaskContainer.prototype.getTasks = function(cb) {
      var instance, tasks;
      tasks = (function() {
        var _i, _len, _ref, _results;
        _ref = this._taskContainerInstance.tasks;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          instance = _ref[_i];
          _results.push(new Task()._init(instance));
        }
        return _results;
      }).call(this);
      return cb(null, tasks);
    };
    TaskContainer.prototype.deleteTask = function(taskNameOrTask, cb) {
      return cb(null);
    };
    TaskContainer.prototype.updateTask = function(taskNameOrTask, values, cb) {
      return cb(null);
    };
    TaskContainer.prototype._init = function(instance) {
      this._taskContainerInstance = instance;
      return this.name = instance.name;
    };
    TaskContainer.prototype._create = function(cb) {
      var instance;
      instance = new schema.TaskContainerModel();
      instance.name = this.name;
      return instance.save(__bind(function(e) {
        this._taskContainerInstance = instance;
        if (e != null) {
          return cb(e);
        }
        return cb(null);
      }, this));
    };
    return TaskContainer;
  })();
}).call(this);
