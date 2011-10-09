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
    /*
      */
    /*
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
        return cb(null, new Task()._init(_.first(found)));
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
          _results.push(new Task()._init(instance));
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
        return this._taskContainerInstance.save(__bind(function(e) {
          if (e != null) {
            cb(e);
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
        if (values.name != null) {
          t._taskInstance.name = values.name;
        }
        if (values.isComplete != null) {
          t._taskInstance.isComplete = values.isComplete;
        }
        if (values.percentageComplete != null) {
          t._taskInstance.percentageComplete = values.percentageComplete;
        }
        if (values.statusText != null) {
          t._taskInstance.statusText = values.statusText;
        }
        if (values.taskData != null) {
          t._taskInstance.taskData = values.taskData;
        }
        if (values.processingData != null) {
          t._taskInstance.processingData = values.processingData;
        }
        if (values.invokeCount != null) {
          t._taskInstance.invokeCount = values.invokeCount;
        }
        if (values.lastInvokedAt != null) {
          t._taskInstance.lastInvokedAt = values.lastInvokedAt;
        }
        if (values.taskDurationInMilliseconds != null) {
          t._taskInstance.taskDurationInMilliseconds = values.taskDurationInMilliseconds;
        }
        if (values.taskEndedAt != null) {
          t._taskInstance.taskEndedAt = values.taskEndedAt;
        }
        if (values.leasedTill != null) {
          t._taskInstance.leasedTill = values.leasedTill;
        }
        if (values.maxRetries != null) {
          t._taskInstance.maxRetries = values.maxRetries;
        }
        if (values.delayBetweenRetriesInSeconds != null) {
          t._taskInstance.delayBetweenRetriesInSeconds = values.delayBetweenRetriesInSeconds;
        }
        if (values.hasFailed != null) {
          t._taskInstance.hasFailed = values.hasFailed;
        }
        return this._taskContainerInstance.save(__bind(function(e) {
          if (e != null) {
            cb(e);
          }
          t._init(t._taskInstance);
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
    return TaskContainer;
  })();
}).call(this);
