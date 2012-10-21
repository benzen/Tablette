http = require "http"

exports.getMovieDescription = (request, response) ->
  url= "http://www.omdbapi.com/?i=&t=#{request.params.movieName}"
  http.get( url, ( getResponse)->
    body="";
    getResponse.on("data",(chunk)->
      body+=chunk
    )
    getResponse.on(  "end",  ( )->
      response.send(body)
    )
  )