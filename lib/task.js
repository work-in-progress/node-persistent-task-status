(function() {
  var constants, mongoose, schema, util, _;
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  mongoose = require('mongoose');
  schema = require('./schema');
  exports.Task = (function() {
    Task.prototype._taskInstance = null;
    Task.prototype._init = function(instance) {
      this._taskInstance = instance;
      this.name = instance.name;
      return this;
    };
    function Task(name) {
      this.name = name;
    }
    Task.prototype.isComplete = function() {
      return this._taskInstance.isComplete;
    };
    Task.prototype.percentageComplete = function() {
      return this._taskInstance.percentageComplete;
    };
    Task.prototype.statusText = function() {
      return this._taskInstance.statusText;
    };
    Task.prototype.taskData = function() {
      return this._taskInstance.taskData;
    };
    Task.prototype.processingData = function() {
      return this._taskInstance.processingData;
    };
    Task.prototype.invokeCount = function() {
      return this._taskInstance.invokeCount;
    };
    Task.prototype.lastInvokedAt = function() {
      return this._taskInstance.lastInvokedAt;
    };
    Task.prototype.taskEndedAt = function() {
      return this._taskInstance.taskEndedAt;
    };
    Task.prototype.taskDurationInMilliseconds = function() {
      return this._taskInstance.taskDurationInMilliseconds;
    };
    Task.prototype.leasedTill = function() {
      return this._taskInstance.leasedTill;
    };
    Task.prototype.maxRetries = function() {
      return this._taskInstance.maxRetries;
    };
    Task.prototype.delayBetweenRetriesInSeconds = function() {
      return this._taskInstance.delayBetweenRetriesInSeconds;
    };
    Task.prototype.hasFailed = function() {
      return this._taskInstance.hasFailed;
    };
    return Task;
  })();
}).call(this);
