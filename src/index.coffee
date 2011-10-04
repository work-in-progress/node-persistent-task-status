#async = require 'async'
constants = require './constants'


# The current version of this module.
module.exports.version = constants.version
Client = module.exports.Client = require './Client'
module.exports.Task = require './task'
module.exports.TaskContainer = require './task_container'

# export config *see pow

module.exports.client = new Client()
