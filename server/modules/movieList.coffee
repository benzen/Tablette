fs = require 'fs'

exports.getMovieList = () ->
  movies = fs.readFileSync( "movieList.json", "utf-8" )
  JSON.parse( movies )
