#async = require 'async'
constants = require './constants'


# The current version of this module.
module.exports.version = constants.version
Client = module.exports.Client = require('./client').Client
module.exports.Task = require('./task').Task
module.exports.TaskContainer = require('./task_container').TaskContainer

# export config *see pow

module.exports.client = new Client()
