{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2} = require('../boilerplate.coffee')()

PureRenderMixin = require 'react-addons-pure-render-mixin'

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, body, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, foreignObject, text, textArea, ellipse, pattern} = React.DOM

textArea = React.createFactory 'textArea'
filter = React.createFactory 'filter'
foreignObject = React.createFactory 'foreignObject'
feGaussianBlur = React.createFactory 'feGaussianBlur'
feImage = React.createFactory 'feImage'
feOffset = React.createFactory 'feOffset'


module.exports = mine = ({tMat, key}) ->


    probe_000 = (aa) ->
        path_commands = [
            ['M', .5, .49]
            ['L', .8, .49]
            ['L', .8, .51]
            ['L', .5, .51]
            ['Z']
        ]
        a = ((2.0 * Math.PI) / 12) * parseFloat(aa)

        x_0 = aa * .3
        y_0 = aa * -.1
        transform_000 = [
            Math.cos(a), -(Math.sin(a)), 0,
            Math.sin(a), Math.cos(a), 0,
            0.0, 0.0, 1.0
        ]
        transform_000 = mat3.transpose mat3.create(), transform_000

        transform_pre = [
            1, 0, 0,
            0, 1, 0,
            -.5, -.5, 1
        ]

        transform_post = [
            1, 0, 0,
            0, 1, 0,
            .5, .5, 1
        ]

        transform_001 = [
            1.0, 0.0, Math.cos(a) * .25,
            0.0, 1.0, Math.sin(a) * .25,
            0.0, 0.0, 1.0
        ]

        transform_001 = mat3.transpose mat3.create(), transform_001

        z = path_commands.reduce (acc, i) =>
            space = if path_commands.indexOf(i) is (path_commands.length - 1) then "" else " "
            switch i[0]
                when 'M', 'L'


                    i_vec = [i[1], i[2]]
                    t_pre = vec2.transformMat3 vec2.create(), i_vec, transform_pre
                    t_0 = vec2.transformMat3 vec2.create(), t_pre, transform_000
                    t_off = vec2.transformMat3 vec2.create(), t_0, transform_001
                    t_post = vec2.transformMat3 vec2.create(), t_off, transform_post
                    t_1 = vec2.transformMat3 vec2.create(), t_post, tMat


                    return acc + "#{i[0]}#{t_1[0]} #{t_1[1]}#{space}"
                when 'Z'
                    return acc + 'Z'
        , ""

        z



    render = ->

        iv = [0.5, 0.5]
        f1_x = .5 * tMat[0]
        f1_y = .5 * tMat[4]
        std_dev = .9 * tMat[4]
        i_r = .45 ; o_r = i_r * tMat[0]
        i_r_001 = .35 ; o_r_001 = i_r_001 * tMat[0]
        ov = vec2.transformMat3 vec2.create(), iv, tMat
        svg
            width: '100%'
            height: '100%'
            key: key
            defs
                radialGradient
                    id: "rGrad_009"
                    stop
                        offset:"80%"
                        stopColor: "gold"
                    stop
                        offset:"95%"
                        stopColor:"purple"
                filter
                    id: 'f2'
                    feGaussianBlur
                        in: "SourceAlpha"
                        result: "blurOut"
                        stdDeviation: std_dev
                    feOffset
                        in: "blurOut"
                        result: "dropBlur"
                        dx: f1_x
                        dy: f1_y
            circle
                cx: ov[0]
                cy: ov[1]
                r: o_r_001
                fill: 'url(#rGrad_009)'
            circle
                cx: ov[0]
                cy: ov[1]
                r: o_r
                #fill: 'url(#rGrad_000)'
                filter: 'url(#f2)'
            for i in [0 .. 11]

                path
                    key: "probe#{i}"
                    # filter: 'url(#f1)'
                    fill: 'white'
                    d: probe_000 i
                    stroke: 'white'

    render()
