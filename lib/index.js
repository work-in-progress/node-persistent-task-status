(function() {
  var TaskContainer, constants;
  constants = require('.constants');
  TaskContainer = require('./task_container');
  module.exports.version = constants.version;
  module.exports.getOrCreateTaskContainer = function(name, cb) {
    var cur;
    cur = new TaskContainer(name);
    return cb(null, cur);
  };
}).call(this);
