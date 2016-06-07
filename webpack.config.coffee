c = -> console.log.apply console, arguments

path = require 'path'

module.exports = config =
    # worker:
    #     output:
    #         filename: "hash.worker.js"
    #         chunkFilename: "[id].hash.worker.js"
    node:
        fs: "empty"
    context: __dirname
    cache: true
    debug: true
    entry:
        app: ['./src/index.coffee']
    stats:
        colors: on
        reasons: on
    module:
        loaders: [
            # {
            #     test: /\.glsl$/
            #     loader: 'webpack-glsl'
            # },
            # {
            #     test: /\.styl$/
            #     loader: 'style-loader!css-loader!stylus-loader'
            # },
            {
                test: /\.coffee$/
                loaders: ['coffee-loader', 'source-map-loader']
            }
        ]
    output:
        path: __dirname
        filename: "build/app.js"
