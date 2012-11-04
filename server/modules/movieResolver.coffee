http = require "http"
querystring = require "querystring"
properties = require("nropf").use(__dirname+"/../app.properties")

api_key = properties.api_key
api_url = properties.api_url
language = properties.language

options = ( url )->
  option =
    hostname: api_url
    headers: { "accept":"application/json" }
    path: url
    port: 80
  option

imageConfig=""
http.get(options("/3/configuration?api_key=#{properties.api_key}"), (response)->
  body=[]
  response.on("data",(chunk)->
    body.push chunk
  )
  response.on("end",()->
    data = JSON.parse( body.join("") )
    imageConfig = "#{data.images.base_url}w342"
  )
)

#the movie db
exports.getMovieDescription = ( request, response ) ->
  movie_id = request.params.movie_id
  queryObject =
    api_key: properties.api_key
    language: language
    append_to_response: "casts"
  qs = querystring.stringify(queryObject)

  url = "/3/movie/#{movie_id}?#{qs}"
  http.get( options(url), (getResponse)->
    body = []
    getResponse.on("data",(chunk)->
      body.push chunk
    )
    getResponse.on(  "end",  ( )->
      movie = JSON.parse(body.join(""))
      movie.poster = "#{imageConfig}/#{movie.poster_path}"
      response.json( movie )
    )
  )

exports.searchMovie = (request, response)->
  query = request.params.query

  queryObject =
    api_key: properties.api_key
    query: query
    language: language
  qs = querystring.stringify(queryObject)
  url = "/3/search/movie?#{qs}"
  site= http.get( options(url), ( getResponse )->
    body = []
    getResponse.on("data",(chunk)->
      body.push chunk
    )
    getResponse.on(  "end",  ( )->
      if(body)
        data = JSON.parse( body.join("") )
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
