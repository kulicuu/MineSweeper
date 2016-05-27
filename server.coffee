c = -> console.log.apply console, arguments



express = require 'express'
app = express()
body_parser = require 'body-parser'
path = require 'path'
public_dir = __dirname + '/build'

app.get '/', (req, res) ->
    res.sendFile(path.join(public_dir, "/index.html"))

# app.use '/', (req, res) ->
#     res.sendFile(path.join(public_dir, "/index.html"))

app.use(body_parser.json())

app.use(express.static(public_dir))


app.listen 3000, 'localhost', ->
    c 'server listening on 3000'
