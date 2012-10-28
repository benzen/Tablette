fs = require 'fs'

file = "movies.json"

exports.getMovieList = () ->
  movies = fs.readFileSync( file, "utf-8" )
  JSON.parse( movies )

exports.addMovie=(request, response)->
  moviesAsString = fs.readFileSync( file, "utf-8" )
  movies = JSON.parse( moviesAsString )
  movie = request.body
  movies.push(movie)
  fs.writeFileSync( file, JSON.stringify( movies ) )
  response.send("")

exports.updateMovie= (request, response)->
  moviesAsString = fs.readFileSync( file, "utf-8" )
  movies = JSON.parse( moviesAsString )
  newMovie = request.body
  movie_id = parseInt( request.params.movie_id )
  # remove old version of the movie
  newMovies = movies.map ( movie )-> 
    if( movie.id == movie_id)
      return newMovie
    return movie
  #update
  fs.writeFileSync( file, JSON.stringify( newMovies ) )
  response.send("")  

exports.getMovie = (request, response)->
  moviesAsString = fs.readFileSync( file, "utf-8" )
  movie_id = parseInt( request.params.movie_id )
  movies = JSON.parse( moviesAsString )
  requestedMovie = movies.filter( ( movie ) -> 
    movie.id == movie_id
  ) 
  response.json requestedMovie[0]
