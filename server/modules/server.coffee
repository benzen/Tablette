express = require 'express'
router = require "./routes"
db = require "./db"
app = express()

oneYear = 31557600000;

app.configure( ()->
  app.use express.compress()
  app.use express.bodyParser()
#  app.use express.cookieParser()
#  app.use express.session( { secret: "nodeMovieListSecret" } )
  app.use express.static( __dirname + "/../../public", {maxAge: oneYear} )
  app.use express.methodOverride()
#  app.use express.logger()
 
)

router.setUpRoutes(app)


port = 8080;
app.listen(port, ()->
  console.log("Listening on " + port)
)



