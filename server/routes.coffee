express = require 'express'
fs = require 'fs'

app = express.createServer express.logger() 
app.set 'view engine', 'jade'
app.set 'view options', { layout: false }
app.use express.bodyParser()

port = process.env.PORT || 3000;
app.listen(port, ()->
  console.log("Listening on " + port)
)

app.get( "/", (req,res)->
	console.log "/index"
	res.render "index" 
)

app.get("/movies", (req,res)->
	fs.readFile( "movieList.json", "utf-8",(error, data)->
		if(error)
			console.error("Could not open file: %s", error)
    		process.exit(1)
  		res.send data.toString()

	)
		
)
