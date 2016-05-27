

{_, c} = require('../boilerplate.coffee')()


{ SET_BOUNDING_RECT } = require '../constants/action_types.coffee'

set_bounding_rect = ({viewport_x, viewport_y, viewport_width, viewport_height}) ->
    return {
        type: SET_BOUNDING_RECT
        viewport_x
        viewport_y
        viewport_width
        viewport_height
    }

module.exports = { set_bounding_rect }
