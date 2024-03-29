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
      this.deleteTask = __bind(this.deleteTask, this);
      this.getTasks = __bind(this.getTasks, this);
      this.getTask = __bind(this.getTask, this);
      this.getNextTask = __bind(this.getNextTask, this);
    }
    TaskContainer.prototype.isComplete = function() {
      return this._taskContainerInstance.isComplete;
    };
    /*
      */
    /*
      */
    TaskContainer.prototype.addTask = function(name, values, cb) {
      var instance, task;
      if (!values) {
        values = {};
      }
      instance = new schema.TaskModel();
      task = new Task(instance);
      values.name = name;
      task._update(values);
      this._taskContainerInstance.tasks.push(instance);
      this._updateTaskContainerIsComplete();
      return this._taskContainerInstance.save(__bind(function(err) {
        if (err != null) {
          return cb(err);
        }
        return cb(null, task);
      }, this));
    };
    /*
      */
    TaskContainer.prototype.getNextTask = function(name, cb) {
      return cb(null);
    };
    /*
      */
    TaskContainer.prototype.getTask = function(name, cb) {
      var found;
      found = _.select(this._taskContainerInstance.tasks, function(t) {
        return t.name === name;
      });
      if ((found != null) && found.length > 0) {
        return cb(null, new Task(_.first(found)));
      }
      return cb(null, null);
    };
    /*
      */
    TaskContainer.prototype.getTasks = function(cb) {
      var instance, tasks;
      tasks = (function() {
        var _i, _len, _ref, _results;
        _ref = this._taskContainerInstance.tasks;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          instance = _ref[_i];
          _results.push(new Task(instance));
        }
        return _results;
      }).call(this);
      return cb(null, tasks);
    };
    /*
      */
    TaskContainer.prototype.deleteTask = function(name, cb) {
      return this.getTask(name, __bind(function(err, t) {
        if (err != null) {
          return cb(err);
        }
        if (!t) {
          return cb(null, null);
        }
        t._taskInstance.remove();
        this._updateTaskContainerIsComplete();
        return this._taskContainerInstance.save(__bind(function(e) {
          if (e != null) {
            return cb(e);
          }
          t._taskInstance = null;
          return cb(null, t);
        }, this));
      }, this));
    };
    /*
      */
    /*
      */
    TaskContainer.prototype.updateTask = function(name, values, cb) {
      return this.getTask(name, __bind(function(err, t) {
        if (err != null) {
          return cb(err);
        }
        if (!t) {
          return cb(new Error("Task '" + name + "' not found"));
        }
        t._update(values);
        this._updateTaskContainerIsComplete();
        return this._taskContainerInstance.save(__bind(function(e) {
          if (e != null) {
            return cb(e);
          }
          return cb(null, t);
        }, this));
      }, this));
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
    TaskContainer.prototype._areTasksCompleted = function() {
      return _.all(this._taskContainerInstance.tasks, function(taskModel) {
        return taskModel.isComplete;
      });
    };
    TaskContainer.prototype._updateTaskContainerIsComplete = function() {
      return this._taskContainerInstance.isComplete = this._areTasksCompleted();
    };
    return TaskContainer;
  })();
}).call(this);
