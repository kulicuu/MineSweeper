

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

module.exports = { viewport_width, viewport_height }
