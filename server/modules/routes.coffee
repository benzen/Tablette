movieList = require "./movieList"
movieResolver = require "./movieResolver"

exports.setUpRoutes = (app)->

  app.get("/movies", (request,response)->
    response.json movieList.getMovieList()
  )
  app.get("/movie/search/:query", movieResolver.searchMovie )
  app.get("/movie/:movie_id", movieResolver.getMovieDescription )

  app.get("/movies/:movie_id", movieList.getMovie )
  app.post( "/movies/new", movieList.addMovie )
  app.put( "/movies/update", movieList.updateMovie )

  app.get( "/movie/:movieName", movieList.getMovie )

  app.get( "^/*/*[^(.*)]$" )

  
