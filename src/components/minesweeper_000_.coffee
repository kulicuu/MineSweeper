{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

PureRenderMixin = require 'react-addons-pure-render-mixin'

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../constants/tile_states.coffee'

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'
feOffset = React.createFactory 'feOffset'

# font_awesome = require 'react-fontawesome'

mine_000 = require './mine_000_.coffee'
zero_000 = require './zero_000_.coffee'
one_000 = require './one_000_.coffee'
two_000 = require './two_000_.coffee'
three_000 = require './three_000_.coffee'
four_000 = require './four_000_.coffee'
five_000 = require './five_000_.coffee'
six_000 = require './six_000_.coffee'
seven_000 = require './seven_000_.coffee'
eight_000 = require './eight_000_.coffee'

module.exports = minesweeper = rr

    mixins: [PureRenderMixin]

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
            f1_x = .005 * @props.tMat[0]
            f1_y = .005 * @props.tMat[4]
            std_dev = .001 * @props.tMat[0]
            # f1_x = 4
            # f1_y = 4
            # std_dev = 1.5
            defs
                radialGradient
                    id: "rGrad_001"
                    stop
                        offset: "30%"
                        stopColor: 'lightgrey'
                    stop
                        offset:"70%"
                        stopColor: "blue"
                    stop
                        offset:"95%"
                        stopColor:"lightblue"
                filter
                    id: 'f1'
                    feGaussianBlur
                        in: "SourceGraphic"
                        result: "blurOut"
                        stdDeviation: std_dev
                    feOffset
                        in: "blurOut"
                        result: "dropBlur"
                        dx: f1_x
                        dy: f1_y

            for row, idx in transforms
                for l_tMat, jdx in row
                    tile_000 = @props.board["TILE:#{idx}:#{jdx}"]
                    [actual, revealed, flagged] = tile_000.split ':'

                    # color = switch ((idx * jdx) + idx) % 5
                    #     when 0 then 'white'
                    #     when 1 then 'blue'
                    #     when 2 then 'orange'
                    #     when 3 then 'purple'
                    #     when 4 then 'green'
                    tile_0 = @tile_000 l_tMat
                    tile = @rect_t tile_0
                    j_tMat = mat3.multiply mat3.create(), @props.tMat, l_tMat

                    switch actual
                        when MINED
                            mine_000
                                tMat: j_tMat
                        when UNMINED_ZERO_MINE_NEIGHBORS
                            zero_000
                                tMat: j_tMat
                        when UNMINED_ONE_MINE_NEIGHBOR
                            one_000
                                tMat: j_tMat
                        when UNMINED_TWO_MINE_NEIGHBORS
                            two_000
                                tMat: j_tMat
                        when UNMINED_THREE_MINE_NEIGHBORS
                            three_000
                                tMat: j_tMat
                        when UNMINED_FOUR_MINE_NEIGHBORS
                            four_000
                                tMat: j_tMat
                        when UNMINED_FIVE_MINE_NEIGHBORS
                            five_000
                                tMat: j_tMat
                        # when UNMINED_SIX_MINE_NEIGHBORS
                        #     six_000
                        #         tMat: j_tMat
                        # when UNMINED_SEVEN_MINE_NEIGHBORS
                        #     seven_000
                        #         tMat: j_tMat
                        # when UNMINED_EIGHT_MINE_NEIGHBORS
                        #     eight_000
                        #         tMat: j_tMat
                        else
                            rect
                                x: tile.x
                                y: tile.y
                                width: tile.width
                                height: tile.height
                                # fill: color
                                # filter: 'url(#f1)'
                                fill: 'url(#rGrad_001)'
                                stroke: 'blue'
