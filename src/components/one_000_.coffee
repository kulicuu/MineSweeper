{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

PureRenderMixin = require 'react-addons-pure-render-mixin'

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'
feOffset = React.createFactory 'feOffset'

module.exports = one = rr
    render: ->

        i_origin = [0, 0]
        i_side = 1
        # o_origin = math.multiply M, i_origin
        o_origin = vec2.transformMat3 vec2.create(), i_origin, @props.tMat

        # o_side = i_side * M[0][0]
        o_side = i_side * @props.tMat[0]

        # f_zero_x = .5 * M[0][0]
        f_zero_x = .5 * @props.tMat[0]

        # f_zero_y = .5 * M[1][1]
        f_zero_y = .5 * @props.tMat[4]

        # std_dev = .9 * M[0][0]
        std_dev = .9 * @props.tMat[0]


        # text_origin_in = [0, 0, 1]
        text_origin_in = [.5, .5]
        # text_origin_out = math.multiply M, text_origin_in
        text_origin_out = vec2.transformMat3 vec2.create(), text_origin_in, @props.tMat
        r_000 = .4
        # r_001 = M[0][0] * r_000
        r_001 = @props.tMat[0] * r_000


        svg
            width: '100%'
            height: '100%'
            defs
                radialGradient
                    id: "one_grad_000"
                    stop
                        offset: "30%"
                        stopColor: 'lightgrey'
                    stop
                        offset:"70%"
                        stopColor: "lightgreen"
                    stop
                        offset:"95%"
                        stopColor:"yellow"
                filter
                    id: 'f_zero'
                    feGaussianBlur
                        in: "SourceGraphic"
                        result: "blurOut"
                        stdDeviation: std_dev
                    feOffset
                        in: "blurOut"
                        result: "dropBlur"
                        dx: f_zero_x
                        dy: f_zero_y

            rect
                x: o_origin[0]
                y: o_origin[1]
                width: o_side
                height: o_side
                filter: 'url(#f_zero)'
                fill: 'hsl(33,99%,99%)'
                onContextMenu: (e) -> e.preventDefault()
                # onClick: @props.onClick
            rect
                x: o_origin[0]
                y: o_origin[1]
                width: o_side
                height: o_side
                opacity: .87
                fill: 'url(#one_grad_000)'
                stroke: 'blue'
                onContextMenu: (e) -> e.preventDefault()
                # onClick: @props.onClick
            text
                style:
                    MozUserSelect: 'none'
                cursor: 'default'
                onContextMenu: (e) -> e.preventDefault()
                # onClick: @props.onClick
                x: text_origin_out[0] - ((r_001 * .9) / 4)
                y: text_origin_out[1] + ((r_001 * .9) / 3)
                fontSize: r_001 * .9
                1
