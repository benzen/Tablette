express = require 'express'

app = express.createServer express.logger() 
app.set 'view engine', 'jade'
app.set 'view options', { layout: false }
app.use express.bodyParser()

port = process.env.PORT || 3000;
app.listen(port, ()->
  console.log("Listening on " + port)
)

app.get("/",(req,resp)->
	 console.log "/index"
	res.render "index" 
)
