c = -> console.log.apply console, arguments
_ = require 'lodash'
express = require 'express'
app = express()
body_parser = require 'body-parser'
path = require 'path'
public_dir = __dirname + '/build'

if process.env.NODE_ENV is 'production'
    index = '/prod_index.html'
else
    index = '/dev_index.html'

app.get '/', (req, res) ->
    res.sendFile(path.join(public_dir, index))

# app.use '/', (req, res) ->
#     res.sendFile(path.join(public_dir, "/index.html"))

app.use(body_parser.json())

app.use(express.static(public_dir))
port = process.env.PORT or 3000

app.listen port, ->
    c 'server listening on ', port
