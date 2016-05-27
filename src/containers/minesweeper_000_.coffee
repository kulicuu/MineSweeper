

{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2}  = require('../boilerplate.coffee')()

{ connect } = require 'react-redux'

minesweeper = require '../components/minesweeper_000_.coffee'


map_state_to_props = (state, own_props) ->
    # viewport_x = state.get 'viewport_x'
    # viewport_y = state.get 'viewport_y'
    width = state.get 'viewport_width'
    height = state.get 'viewport_height'

    smaller = if width < height then width else height
    larger = if width > height then width else height

    size = 20
    margin = .1
    port = 1 - margin

    transform_matrix = [
        smaller,    0,           0,
        0,          smaller,     0,
        1 / width,      1 / height,      1
    ]

    board_transform = [
        1, 0, 0,
        0, 1, 0,
        (width / 2) - ((port * smaller) / 2) , (height / 2) - ((port * smaller) / 2), 1
    ]

    composed_transform = mat3.multiply mat3.create(), board_transform, transform_matrix

    return {
        margin
        size
        smaller
        height
        width
        tMat: composed_transform
    }

map_dispatch_to_props = (dispatch, own_props) ->
    return {}

module.exports = minesweeper_container = connect(map_state_to_props,
map_dispatch_to_props)(minesweeper)
