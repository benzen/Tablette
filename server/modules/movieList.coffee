fs = require 'fs'

file = "movieList.json"

exports.getMovieList = () ->
  movies = fs.readFileSync( "movieList.json", "utf-8" )
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
  movie = request.body
  # remove old version of the movie
  newMovies = movies.filter (m)-> 
    m.Title != movie.Title  
  # add new one
  newMovies.push(movie)
  #update
  fs.writeFileSync( file, JSON.stringify( newMovies ) )
  response.send("")  

exports.getMovie = (request, response)->
  moviesAsString = fs.readFileSync( file, "utf-8" )
  movies = JSON.parse( moviesAsString )
  requestedMovie = movies.filter (movie)->
    movie.Title == request.params.movieName
  response.json requestedMovie[0]
