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
      console.log("getTaskContainer Searching for " + name);
      return schema.TaskContainerModel.findOne({
        name: name
      }, function(e, doc) {
        var tc;
        console.log('HERE');
        console.log("Finding one: " + e + " DOC " + doc);
        if (e != null) {
          return cb(e);
        }
        console.log('HERE 1');
        if (doc != null) {
          return cb(null, null);
        }
        console.log('HERE 2');
        tc = new TaskContainer(doc.name);
        console.log('HERE 3');
        cb(null, tc);
        return console.log('HERE 4');
      });
    };
    Client.prototype.getOrCreateTaskContainer = function(name, cb) {
      console.log("getOrCreateTaskContainer Searching for " + name);
      return this.getTaskContainer(name, function(e, tc) {
        console.log("I AM HERE: " + e + " || " + tc);
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
      cb(null, name);
      return null;
    };
    return Client;
  })();
}).call(this);
