

viewport_width = (prev_state = initial_state, action)->
    if action.viewport_width isnt undefined
        return action.viewport_width
    else
        return prev_state

viewport_height = (prev_state = initial_state, action)->
    if action.viewport_height isnt undefined
        return action.viewport_height
    else
        return prev_state

# viewport_y = (prev_state = initial_state, action)->
#     if action.viewport_y isnt undefined
#         return action.viewport_y
#     else
#         return prev_state
#
# viewport_x = (prev_state = initial_state, action)->
#     if action.viewport_x isnt undefined
#         return action.viewport_x
#     else
#         return prev_state


# module.exports = {viewport_x, viewport_y, viewport_width, viewport_height}

module.exports = { viewport_width, viewport_height }
