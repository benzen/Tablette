pg = require "pg"

dbUrl = ""

var client = new pg.Client( dbUrl );
client.connect();

var ifTableAlreadyExistLogAMessage = function(tableName){
  return function(){ console.info("Database Table " + tableName + " already exist") };
};
var ifTableWasCreatedLogAMessage = function(tableName){
  return function(){ console.info("Database Table " + tableName + " was exist") };
};
var createTable = function(query, tableName){
  var query = client.query( query );
  query.on("error", ifTableAlreadyExistLogAMessage(tableName));
}

createTable( "CREATE TABLE \"movie\" (id SERIAL PRIMARY KEY, description json);","movie" );

exports.db = client;
