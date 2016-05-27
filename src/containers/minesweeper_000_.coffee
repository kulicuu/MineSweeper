

{ _, c } = require('../boilerplate.coffee')()

{ connect } = require 'react-redux'

minesweeper = require '../components/minesweeper_000_.coffee'

# example_mapStateToProps = (state, ownProps) ->
#     viewport_x = state.get 'viewport_x'
#     viewport_y = state.get 'viewport_y'
#     viewport_width = state.get 'viewport_width'
#     viewport_height = state.get 'viewport_height'
#     # ui_state = state.get 'ui_state'
#     # location = state.get 'location'
#     return {
#         location
#         ui_state
#         viewport_x
#         viewport_y
#         viewport_width
#         viewport_height
#
#     }


# example_transform_matrix = [
#     [z, 0, (@state.view_width / 2)],
#     [0, -z, (@state.view_height / 2)],
#      [0, 0, 1]

# x = [
#     smaller ,    0 ,     0,
#     0,      smaller,     0,
#     width, height, 1
# ]
 # smaller = if @state.view_width < @state.view_height then @state.view_width else @state.view_height

# payload_003: ->
#     M_003 = [
#         @state.view_width / 200, 0, 0,
#         0, -@state.view_width / 200, 0,
#         (@state.view_width / 2), (@state.view_height / 2), 1
#     ]


map_state_to_props = (state, own_props) ->
    # viewport_x = state.get 'viewport_x'
    # viewport_y = state.get 'viewport_y'
    width = state.get 'viewport_width'
    height = state.get 'viewport_height'

    smaller = if width < height then width else height

    transform_matrix = [
        smaller,    0,           0,
        0,          smaller,     0,
        1 / width,      1 / height,      1
    ]



    return { tMat: transform_matrix }

map_dispatch_to_props = (dispatch, own_props) ->
    return {}

module.exports = minesweeper_container = connect(map_state_to_props,
map_dispatch_to_props)(minesweeper)
