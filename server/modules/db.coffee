pg = require "pg"

db_host = "tablette-benzen.azva.dotcloud.net"
db_port = "39960"
db_user = "tablette"
db_password = "etagere"
db_name = "tablettedb"
db_url = "pgsql://#{db_user}:#{db_password}@#{db_host}:#{db_port}/#{db_name}"
client = new pg.Client( db_url )
client.connect()

ifTableAlreadyExistLogAMessage = (tableName)->
  ()->
    console.info("Database Table " + tableName + " already exist")

ifTableWasCreatedLogAMessage = (tableName)->
  (e)->
    console.info("Database Table " + tableName + " was exist")
    console.log(e)

createTable = (query, tableName)->
  query = client.query( query )
  query.on("error", ifTableAlreadyExistLogAMessage(tableName))


createTable( "CREATE TABLE movie (id SERIAL PRIMARY KEY, description text);","movie" )

exports.db = client
