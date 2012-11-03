fs = require 'fs'
db = require( "./db" ).db

file = "movies.json"

exports.getMovieList = ( request, response ) ->
  createEvent= ( eventType, eventData ) ->
    "event:#{eventType}\ndata:#{eventData}\n\n"
  response.writeHead( 200, { 
    "Content-Type":"text/event-stream",
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive'
  } );
  response.write("");
  query = db.query("select * from movie;")

  
  query.on("row",(row)->
    response.write( createEvent( "movie", row.description ) );
  )

  query.on("end",()->
    response.write( createEvent("end","") );
    response.end();
  )

exports.addMovie=(request, response)->
  movie = request.body
  query = db.query("INSERT INTO movie VALUES( $1, $2 )", [ movie.id, JSON.stringify(movie) ] );
  query.on("end",()->
    response.send("")
  )
  

exports.updateMovie= (request, response)->
  new_movie = request.body
  query = db.query( "UPDATE movie set description = $1 where id=$2", [ JSON.stringify(new_movie), new_movie.id ] )
  query.on("end",()->
    response.send("")  
  )
  

exports.getMovie = (request, response)->
  movie_id = parseInt( request.params.movie_id )
  query = db.query("SELECT * FROM movie WHERE id=$1",[movie_id])
  query.on("row",(row)->
    response.json JSON.parse( row.description ) 
  )

###
moviesAsString = fs.readFileSync( file, "utf-8" )
movies = JSON.parse( moviesAsString )
for movie in movies
  query = db.query("INSERT INTO movie VALUES( $1, $2 )", [ movie.id, JSON.stringify(movie) ] )
  query.on("error", (e)->
    console.log movie.title
  )
###