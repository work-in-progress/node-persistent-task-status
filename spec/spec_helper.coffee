mongoose = require 'mongoose'
DatabaseCleaner = require 'database-cleaner'

dbUrl = 'mongodb://localhost/pts_test' 

module.exports = 
  database : dbUrl

  connectDatabase: (cb) ->
    mongoose.connect dbUrl
    cb null
    
  cleanDatabase : (cb) ->
    databaseCleaner = new DatabaseCleaner('mongodb')
    databaseCleaner.clean mongoose.createConnection(dbUrl).db, (err) ->
      return cb err if e?
      cb null