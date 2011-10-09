(function() {
  var TaskContainer, constants, mongoose, schema, util, _;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  _ = require('underscore');
  constants = require('./constants');
  mongoose = require('mongoose');
  util = require('./util');
  TaskContainer = require('./task_container').TaskContainer;
  schema = require('./schema');
  exports.Client = (function() {
    function Client() {
      this.getOrCreateTaskContainer = __bind(this.getOrCreateTaskContainer, this);
      this.getTaskContainer = __bind(this.getTaskContainer, this);
    }
    /*
      */
    Client.prototype.getTaskContainer = function(name, cb) {
      return schema.TaskContainerModel.findOne({
        name: name
      }, __bind(function(e, doc) {
        var taskContainer;
        if (e != null) {
          return cb(e);
        }
        if (doc == null) {
          return cb(null, null);
        }
        taskContainer = new TaskContainer(doc.name);
        taskContainer._init(doc);
        return cb(null, taskContainer);
      }, this));
    };
    /*
      */
    Client.prototype.getOrCreateTaskContainer = function(name, cb) {
      return this.getTaskContainer(name, function(e, tc) {
        if (e != null) {
          return cb(e);
        }
        if (tc != null) {
          return cb(null, tc, false);
        }
        tc = new TaskContainer(name);
        return tc._create(function(e) {
          if (e != null) {
            return cb(e);
          }
          return cb(null, tc, true);
        });
      });
    };
    /*
      */
    Client.prototype.deleteTaskContainer = function(name, cb) {
      return schema.TaskContainerModel.remove({
        name: name
      }, function(e) {
        if (e != null) {
          return cb(e);
        }
        return cb(null, name);
      });
    };
    return Client;
  })();
}).call(this);
