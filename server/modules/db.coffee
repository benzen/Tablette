pg = require "pg"
properties = require("nropf").use( __dirname + "/../app.properties")

db_url = "pgsql://#{properties.db_user}:#{properties.db_password}@#{properties.db_host}:#{properties.db_port}/#{properties.db_name}"

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
