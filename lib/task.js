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
      return false;
    };
    Task.prototype.processingState = function() {
      return this.processingState;
    };
    Task.prototype.percentageComplete = function() {
      return 23.0;
    };
    Task.prototype.percentageCompleteAsString = function() {
      return "23%";
    };
    Task.prototype.statusText = function() {
      return "Retrieving a file";
    };
    Task.prototype.retryCount = function() {
      return 0;
    };
    Task.prototype.maxRetries = function() {
      return 100;
    };
    Task.prototype.delayBetweenRetriesInSeconds = function() {
      return 2;
    };
    return Task;
  })();
}).call(this);
