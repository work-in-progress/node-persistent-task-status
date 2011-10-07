(function() {
  var Client, constants;
  constants = require('./constants');
  module.exports.version = constants.version;
  Client = module.exports.Client = require('./client').Client;
  module.exports.Task = require('./task').Task;
  module.exports.TaskContainer = require('./task_container').TaskContainer;
  module.exports.client = new Client();
}).call(this);
