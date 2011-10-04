(function() {
  var Client, TaskContainer, constants, mongoose, schema, util, _;
  _ = require('underscore');
  constants = require('./constants');
  mongoose = require('mongoose');
  util = require('./util');
  TaskContainer = require('./task_container');
  schema = require('./schema');
  module.exports = Client = (function() {
    Client.prototype.caseSensitiveNames = false;
    function Client(opts) {
      opts = opts || {};
      if (opts.caseSensitiveNames != null) {
        this.caseSensitiveName = opts.caseSensitiveNames;
      }
    }
    Client.prototype.getTaskContainer = function(name, cb) {
      var tc;
      tc = null;
      return cb(null, tc);
    };
    Client.prototype.getOrCreateTaskContainer = function(name, cb) {
      return this.getTaskContainer(name, function(e, tc) {
        if (e != null) {
          return cb(e);
        }
        if (tc) {
          cb(null, tc, false);
        }
        tc = new TaskContainer(name);
        return tc._create(mongoose.connection, function(e) {
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
