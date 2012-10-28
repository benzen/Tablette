http = require "http"
querystring = require "querystring"

# omdb 
#
#exports.getMovieDescription = (request, response) ->
#  url= "http://www.omdbapi.com/?i=&t=#{request.params.movieName}"
#  http.get( url, ( getResponse ) ->
#    body = ""
#    getResponse.on("data",(chunk)->
#      body += chunk
#    )
#    getResponse.on(  "end",  ( )->
#      response.send( body )
#    )
#  )

api_key = "449cc224819fdfd8074ee222004d8692"
api_url = "api.themoviedb.org"
#api_url = "private-f1e6-themoviedb.apiary.io"
language = "fr"
options = ( url )->
  option = 
    hostname: api_url
    headers: { "accept":"application/json" }
    path: url
    port: 80
  option

imageConfig=""
http.get(options("/3/configuration?api_key=#{api_key}"), (response)->
  body=""
  response.on("data",(chunk)->
    body+=chunk
  )
  response.on("end",()->
    data = JSON.parse( body )
    imageConfig = "#{data.images.base_url}w342"
  )
)

#the movie db
exports.getMovieDescription = ( request, response ) ->
  movie_id = request.params.movieId
  queryObject = 
    api_key: api_key
    language: language
    append_to_response: "casts"
  qs = querystring.stringify(queryObject)

  url = "/3/movie/#{movie_id}?#{qs}"
  http.get( options(url), (getResponse)->
    body = ""
    getResponse.on("data",(chunk)->
      body += chunk
    )
    getResponse.on(  "end",  ( )->
      movie = JSON.parse(body)
      movie.poster = "#{imageConfig}/#{movie.poster_path}"
      response.json( movie )
    )
  )

exports.searchMovie = (request, response)->
  query = request.params.query
  
  queryObject = 
    api_key: api_key
    query: query
    language: language
  qs = querystring.stringify(queryObject)
  url = "/3/search/movie?#{qs}"
  site= http.get( options(url), ( getResponse )->
    body = ""
    getResponse.on("data",(chunk)->
      body += chunk
    )
    getResponse.on(  "end",  ( )->
      if(body)
        data = JSON.parse( body )
        if(data.total_pages > 1) 
          console.log "There is more than on page of result"
        movies = data.results.map( (movie)->
          movie.poster = "#{imageConfig}/#{movie.poster_path}"
          movie
        )
        response.json( movies )
      else
        response.send 500, "Failed to search this movie name"
    )
  )
