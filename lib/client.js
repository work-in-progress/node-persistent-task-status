(function() {
  var Client, TaskContainer, constants, util, _;
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  TaskContainer = require('./task_container');
  module.exports = Client = (function() {
    function Client(opts) {
      opts || (opts = {});
    }
    Client.prototype.getOrCreateTaskContainer = function(name, cb) {
      var cur;
      cur = new TaskContainer(name);
      return cb(null, cur);
    };
    return Client;
  })();
}).call(this);
