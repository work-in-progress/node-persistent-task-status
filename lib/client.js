(function() {
  var Client, TaskContainer, constants, mongoose, schema, util, _;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  _ = require('underscore');
  constants = require('./constants');
  mongoose = require('mongoose');
  util = require('./util');
  TaskContainer = require('./task_container');
  schema = require('./schema');
  module.exports = Client = (function() {
    Client.prototype.caseSensitiveNames = false;
    function Client(opts) {
      this.getOrCreateTaskContainer = __bind(this.getOrCreateTaskContainer, this);
      this.getTaskContainer = __bind(this.getTaskContainer, this);      opts = opts || {};
      if (opts.caseSensitiveNames != null) {
        this.caseSensitiveName = opts.caseSensitiveNames;
      }
    }
    Client.prototype.getTaskContainer = function(name, cb) {
      return schema.TaskContainerModel.findOne({
        name: name
      }, __bind(function(e, doc) {
        var tc;
        if (e != null) {
          return cb(e);
        }
        if (doc == null) {
          return cb(null, null);
        }
        tc = new TaskContainer(doc.name);
        return cb(null, tc);
      }, this));
    };
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
    Client.prototype.deleteTaskContainer = function(name, cb) {
      return cb(null, name);
    };
    return Client;
  })();
}).call(this);
