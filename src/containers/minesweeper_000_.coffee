

{_, gl_mat, React, React_DOM, rr, c, shortid, assign, keys, mat3, vec3, vec2}  = require('../boilerplate.coffee')()

{ connect } = require 'react-redux'

{ start_new_game, reveal, toggle_flag } = require '../actions/minesweeper_000_.coffee'

minesweeper = require '../components/minesweeper_000_.coffee'

mine_000 = require '../components/mine_000_.coffee'
one_000 = require '../components/one_000_.coffee'

# grab_board = (state) ->



map_state_to_props = (state, own_props) ->
    # viewport_x = state.get 'viewport_x'
    # viewport_y = state.get 'viewport_y'

    # grab_board state

    # obj_0 = state.toJS()

    obj_1 = state.toObject()



    obj_3 = _.pick obj_1, ['GROUND_ZERO', 'GAME_STATE', 'SIZE', 'TIME_ELAPSED', 'routing', 'viewport_width', 'viewport_height']

    obj_2 = _.omit obj_1, ['GAME_STATE', 'SIZE', 'TIME_ELAPSED']
    { GROUND_ZERO, SIZE, GAME_STATE, TIME_ELAPSED } = obj_3




    width = state.get 'viewport_width'
    height = state.get 'viewport_height'

    smaller = if width < height then width else height
    larger = if width > height then width else height

    orientation = if width < height then 'vertical' else 'horizontal'
    size = state.get 'SIZE'
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

    arq_0 = {
        SIZE # can/could replace redundant lowercased version below
        GAME_STATE
        TIME_ELAPSED
        GROUND_ZERO

        board: obj_2
        margin
        size
        orientation
        smaller
        height
        width
        tMat: composed_transform
    }


    return arq_0

map_dispatch_to_props = (dispatch, own_props) ->

    return {
        toggle_flag: (tile_coord) ->
            dispatch(toggle_flag(tile_coord))
        reveal: (tile_coord) ->
            dispatch(reveal(tile_coord))
        start_new_game: ->
            dispatch(start_new_game())
    }

module.exports = minesweeper_container = connect(map_state_to_props, map_dispatch_to_props)(minesweeper)
# module.exports = sketch_container = connect(map_state_to_props, map_dispatch_to_props)(one_000)
# module.exports = sketch_container = connect(map_state_to_props, map_dispatch_to_props)(mine_000)
