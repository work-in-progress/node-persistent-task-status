(function() {
  var TaskContainer, constants, util, _;
  _ = require('underscore');
  constants = require('./constants');
  util = require('./util');
  module.exports = TaskContainer = (function() {
    function TaskContainer(name) {
      this.name = name;
    }
    return TaskContainer;
  })();
}).call(this);
