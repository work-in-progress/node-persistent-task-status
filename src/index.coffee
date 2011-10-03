#async = require 'async'
constants = require '.constants'

TaskContainer = require './task_container'

# The current version of this module.
module.exports.version = constants.version

# export config *see pow


module.exports.getOrCreateTaskContainer = (name,cb) ->   
  cur = new TaskContainer(name)
  cb null,cur

