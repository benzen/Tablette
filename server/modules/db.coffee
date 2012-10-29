pg = require "pg"

db_url = "pgsql://moviefan:matrix@nodemovielist-benzen.azva.dotcloud.net:39961/"
db_name = "movies"
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
