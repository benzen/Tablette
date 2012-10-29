express = require 'express'
router = require "./routes"
db = require "./db"
app = express()

app.configure( ()->
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session( { secret: "nodeMovieListSecret" } )
  app.use express.static( __dirname + "/../../public" )
  app.use express.methodOverride()
  app.use express.logger()
)

router.setUpRoutes(app)


port = 8080;
app.listen(port, ()->
  console.log("Listening on " + port)
)



