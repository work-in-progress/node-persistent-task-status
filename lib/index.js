(function() {
  var Client, constants;
  constants = require('./constants');
  module.exports.version = constants.version;
  Client = module.exports.Client = require('./Client');
  module.exports.Task = require('./task');
  module.exports.TaskContainer = require('./task_container');
  module.exports.client = new Client();
}).call(this);
