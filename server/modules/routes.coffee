movieList = require "./movieList"
movieResolver = require "./movieResolver"

exports.setUpRoutes = (app)->

  app.get("/movies", (request,response)->
    response.json movieList.getMovieList()
  )


  app.get("/getMovie/:name", (request, response)->
    movieResolver.getMovieDescription( request, response )
  )