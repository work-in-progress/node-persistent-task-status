mongoose = require 'mongoose'
DatabaseCleaner = require 'database-cleaner'

dbUrl = 'mongodb://localhost/pts_test' 

module.exports = 
  database : dbUrl
  
  # Connect to the test database.
  connectDatabase: () ->
    mongoose.connect dbUrl
    
  cleanDatabase : (cb) ->
    databaseCleaner = new DatabaseCleaner('mongodb')
    databaseCleaner.clean mongoose.createConnection(dbUrl).db, (err) ->
      return cb err if e?
      cb null