(function() {
  var constants, mongoose, schema, util, _;
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  mongoose = require('mongoose');
  schema = require('./schema');
  exports.Task = (function() {
    Task.prototype._taskInstance = null;
    function Task(mongooseTaskInstance) {
      this._taskInstance = mongooseTaskInstance;
      this.name = mongooseTaskInstance.name;
    }
    Task.prototype._init = function(instance) {
      this._taskInstance = instance;
      this.name = instance.name;
      return this;
    };
    /*
      */
    Task.prototype._update = function(values) {
      if (values.name != null) {
        this._taskInstance.name = values.name;
      }
      if (values.isComplete != null) {
        this._taskInstance.isComplete = values.isComplete;
      }
      if (values.percentageComplete != null) {
        this._taskInstance.percentageComplete = values.percentageComplete;
      }
      if (values.statusText != null) {
        this._taskInstance.statusText = values.statusText;
      }
      if (values.taskData != null) {
        this._taskInstance.taskData = values.taskData;
      }
      if (values.processingData != null) {
        this._taskInstance.processingData = values.processingData;
      }
      if (values.invokeCount != null) {
        this._taskInstance.invokeCount = values.invokeCount;
      }
      if (values.lastInvokedAt != null) {
        this._taskInstance.lastInvokedAt = values.lastInvokedAt;
      }
      if (values.taskDurationInMilliseconds != null) {
        this._taskInstance.taskDurationInMilliseconds = values.taskDurationInMilliseconds;
      }
      if (values.taskEndedAt != null) {
        this._taskInstance.taskEndedAt = values.taskEndedAt;
      }
      if (values.leasedTill != null) {
        this._taskInstance.leasedTill = values.leasedTill;
      }
      if (values.maxRetries != null) {
        this._taskInstance.maxRetries = values.maxRetries;
      }
      if (values.delayBetweenRetriesInSeconds != null) {
        this._taskInstance.delayBetweenRetriesInSeconds = values.delayBetweenRetriesInSeconds;
      }
      if (values.hasFailed != null) {
        return this._taskInstance.hasFailed = values.hasFailed;
      }
    };
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
