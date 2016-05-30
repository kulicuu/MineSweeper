{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

# PureRenderMixin = require 'react-addons-pure-render-mixin'

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

{ GAME_STATE, SIZE, NOT_STARTED, IN_PROGRESS, FINISHED, GAME_LOST, GAME_WON } = require '../constants/minesweeper_states.coffee'

{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../constants/tile_states.coffee'

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'
feOffset = React.createFactory 'feOffset'


module.exports = end_board_halo = rr
    componentWillUnmount: ->
        c "unmounting and halo_interval is", @halo_interval
        clearInterval @halo_interval
    getInitialState: ->
        M = @props.tMat
        # M = mat3.transpose mat3.create(), M
        i_r = 2
        r: i_r * M[0]
    componentDidMount: ->
        @cycle_halo()

    cycle_halo: ->
        M = mat3.transpose mat3.create(), @props.tMat
        start = Date.now()
        @halo_interval = setInterval =>
            now = Date.now()
            delta = now - start
            a_delta = delta * .5
            m_delta = a_delta % 1600
            o_r = a_delta % (1600)
            oo_r = ->
                if o_r < 800
                    o_r
                else
                    1600 - o_r
            # o_r = r * M[0]

            @setState
                #offset_0: (delta / 100) % 100
                #offset_1: (60 + (delta % 30)) + "%"
                r: oo_r()
        , 60
    render: ->
        M = @props.tMat
        i_origin = [0.5, 0.5] ; o_origin = vec2.transformMat3 vec2.create(), i_origin, M
        i_r = 1 ; o_r = i_r * M[0]
        svg
            width: '100%'
            height: '100%'
            defs
                radialGradient
                    id: "end_board_halo_grad"
                    stop
                        offset: "30%"
                        stopColor: 'lightgrey'
                    stop
                        offset: @state?.offset_0 or "60%"
                        stopColor: "red"
                    stop
                        offset: @state?.offset_1  or "95%"
                        stopColor:"lightblue"
            circle
                fill: 'url(#end_board_halo_grad)'
                cx: o_origin[0]
                cy: o_origin[1]
                r: @state.r
                opacity: .33
