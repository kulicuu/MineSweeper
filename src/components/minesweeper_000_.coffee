{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'

# font_awesome = require 'react-fontawesome'

module.exports = minesweeper = rr

    rect_t: (s_rect) ->
        { width, height, x, y } = s_rect
        origin = vec2.transformMat3 vec2.create(), [x, y], @props.tMat
        x: origin[0]
        y: origin[1]
        width: width * @props.tMat[0]
        height: height * @props.tMat[4]

    rect_l_t: (s_rect, l_tMat) ->
        { width, height, x, y } = s_rect
        origin = vec2.transformMat3 vec2.create(), [x, y], l_tMat
        x: origin[0]
        y: origin[1]
        width: width * l_tMat[0]
        height: height * l_tMat[4]

    tile_000: (l_tMat) ->
        s_rect =
            width: 1
            height: 1
            x: 0
            y: 0
        @rect_l_t s_rect, l_tMat



    tile_transforms: ->

        smaller = @props.tMat[0]

        port = 1 - @props.margin
        tile_size = port / @props.size # dimension of tile as percentage of viewport size
        for idx in [0 .. (@props.size - 1)]
            for jdx in [0 .. (@props.size - 1)]
                x_displacement = jdx * tile_size
                y_displacement = idx * tile_size
                transform_matrix = [
                    tile_size, 0, 0,
                    0, tile_size, 0,
                    x_displacement, y_displacement, 1
                ]




    render: ->

        transforms = @tile_transforms()

        svg
            width: '100%'
            height: '100%'
            ,

            for row, idx in transforms
                for l_tMat, jdx in row
                    switch ((idx * jdx) + idx) % 5
                        when 0
                            color = 'white'
                        when 1
                            color = 'blue'
                        when 2
                            color = 'orange'
                        when 3
                            color = 'purple'
                        when 4
                            color = 'green'
                    tile_0 = @tile_000 l_tMat
                    tile = @rect_t tile_0
                    rect
                        x: tile.x
                        y: tile.y
                        width: tile.width
                        height: tile.height
                        fill: color
