http = require "http"

exports.getMovieDescription = (request, response) ->
  url= "http://www.omdbapi.com/?i=&t=#{request.params.name}"
  http.get( url, ( getResponse)->
    body="";
    getResponse.on("data",(chunk)->
      body+=chunk
    )
    getResponse.on(  "end",  ( )->
      console.log getResponse.statusCode
      console.log body
      response.send(body)
    )
  )