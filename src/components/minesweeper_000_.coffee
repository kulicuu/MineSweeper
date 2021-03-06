{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

PureRenderMixin = require 'react-addons-pure-render-mixin'

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

{ GAME_STATE, SIZE, NOT_STARTED, IN_PROGRESS, FINISHED, GAME_LOST, GAME_WON } = require '../constants/minesweeper_states.coffee'

{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../constants/tile_states.coffee'

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'
feOffset = React.createFactory 'feOffset'


# mine_000 = require './mine_000_.coffee'
flag_001 = require './flag_001_.coffee'
mine_001 = require './mine_001_.coffee'
# zero_000 = require './zero_000_.coffee'
zero_001 = require './zero_001_.coffee'
# one_000 = require './one_000_.coffee'
one_001 = require './one_001_.coffee'
two_000 = require './two_000_.coffee'
three_000 = require './three_000_.coffee'
four_000 = require './four_000_.coffee'
five_000 = require './five_000_.coffee'
six_000 = require './six_000_.coffee'
seven_000 = require './seven_000_.coffee'
eight_000 = require './eight_000_.coffee'
halo_000 = require './end_board_halo_000_.coffee'

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

    restart_button: ->

        switch @props.orientation
            when 'horizontal'
                s_button =
                    x: .91
                    y: .3
                    width: .063
                    height: .063
            when 'vertical'
                s_button =
                    x: .3
                    y: .91
                    width: .063
                    height: .063
        @rect_t s_button



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
        restart_button = @restart_button()
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
                radialGradient
                    id: "rGrad_flag"
                    stop
                        offset: "30%"
                        stopColor: 'black'
                    stop
                        offset:"70%"
                        stopColor: "red"
                    stop
                        offset:"95%"
                        stopColor:"purple"
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
                    do (idx, jdx) =>
                        tile_000 = @props.board["TILE:#{idx}:#{jdx}"]
                        key = "tile:#{idx}:#{jdx}"
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
                        water = =>
                            if flagged is NOT_FLAGGED
                                rect
                                    key: "tile:#{idx}:#{jdx}"
                                    x: tile.x
                                    y: tile.y
                                    width: tile.width
                                    height: tile.height
                                    # fill: color
                                    # filter: 'url(#f1)'
                                    fill: 'url(#rGrad_001)'
                                    # fill: 'red'
                                    # fill: 'yellow'
                                    stroke: 'blue'
                                    onClick: => @props.reveal("#{TILE}:#{idx}:#{jdx}")
                                    onContextMenu: (e) => e.preventDefault(); @props.toggle_flag("#{TILE}:#{idx}:#{jdx}")
                            else
                                rect
                                    key: "tile:#{idx}:#{jdx}"
                                    x: tile.x
                                    y: tile.y
                                    width: tile.width
                                    height: tile.height
                                    # fill: color
                                    # filter: 'url(#f1)'
                                    fill: 'url(#rGrad_flag)'
                                    stroke: 'red'
                                    onClick: => @props.reveal("#{TILE}:#{idx}:#{jdx}")
                                    onContextMenu: (e) => e.preventDefault(); @props.toggle_flag("#{TILE}:#{idx}:#{jdx}")
                        switch revealed
                            when NOT_REVEALED
                                water()
                            when REVEALED
                                switch actual
                                    when MINED
                                        mine_001
                                            key: "tile:#{idx}:#{jdx}"
                                            tMat: j_tMat
                                    when UNMINED_ZERO_MINE_NEIGHBORS
                                        zero_001
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_ONE_MINE_NEIGHBOR
                                        one_001
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_TWO_MINE_NEIGHBORS
                                        two_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_THREE_MINE_NEIGHBORS
                                        three_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_FOUR_MINE_NEIGHBORS
                                        four_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_FIVE_MINE_NEIGHBORS
                                        five_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_SIX_MINE_NEIGHBORS
                                        six_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"
                                    when UNMINED_SEVEN_MINE_NEIGHBORS
                                        seven_000
                                            tMat: j_tMat
                                    when UNMINED_EIGHT_MINE_NEIGHBORS
                                        eight_000
                                            tMat: j_tMat
                                            key: "tile:#{idx}:#{jdx}"

            if @props.GAME_STATE is GAME_LOST
                cursor = @props.GROUND_ZERO.split ':'
                idx = cursor[1]
                jdx = cursor[2]

                smaller = @props.tMat[0]

                port = 1 - @props.margin
                tile_size = port / @props.size # dimension of tile as percentage of viewport size

                x_displacement = jdx * tile_size
                y_displacement = idx * tile_size
                transform_matrix = [
                    tile_size, 0, 0,
                    0, tile_size, 0,
                    x_displacement, y_displacement, 1
                ]

                j_tMat = mat3.multiply mat3.create(), @props.tMat, transform_matrix


                c 'lost'
                halo_000
                    tMat: j_tMat
            rect
                x: restart_button.x
                y: restart_button.y
                width: restart_button.width
                height: restart_button.height
                fill: 'white'
                onClick: @props.start_new_game
                cursor: 'pointer'
            text
                x: restart_button.x + (restart_button.width * .16)
                y: restart_button.y + (restart_button.height * .85)
                fill: 'red'
                fontSize: restart_button.height * .8
                fontFamily: 'sans'
                onClick: @props.start_new_game
                cursor: 'pointer'
                ,
                "↻"
