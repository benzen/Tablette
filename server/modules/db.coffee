pg = require "pg"

db_url = "pgsql://tablette:tablette@tablette-benzen.azva.dotcloud.net:39960"
db_name = "tablette"
client = new pg.Client( "#{db_url}#{db_name}" )
client.connect()

ifTableAlreadyExistLogAMessage = (tableName)->
  ()->
    console.info("Database Table " + tableName + " already exist")

ifTableWasCreatedLogAMessage = (tableName)->
  ()->
    console.info("Database Table " + tableName + " was exist")

createTable = (query, tableName)->
  query = client.query( query )
  query.on("error", ifTableAlreadyExistLogAMessage(tableName))


createTable( "CREATE TABLE movie (id SERIAL PRIMARY KEY, description text);","movie" )

exports.db = client
