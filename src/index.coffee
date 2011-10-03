#async = require 'async'
constants = require './constants'

TaskContainer = require './task_container'
Client = require './Client'

# The current version of this module.
module.exports.version = constants.version
module.exports.Client = Client
# export config *see pow

module.exports.client = new Client()
