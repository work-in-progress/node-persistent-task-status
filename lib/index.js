(function() {
  var Client, TaskContainer, constants;
  constants = require('./constants');
  TaskContainer = require('./task_container');
  Client = require('./Client');
  module.exports.version = constants.version;
  module.exports.Client = Client;
  module.exports.client = new Client();
}).call(this);
