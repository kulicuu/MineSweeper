
{ _, c } = require('../boilerplate.coffee')()
{ combineReducers } = require 'redux-immutable'

module.exports = (initial_state) ->

    routeReducer = require './routeReducer.coffee'

    # {viewport_x, viewport_y, viewport_height, viewport_width} = require './boundingClientRect.coffee'

    { viewport_height, viewport_width } = require './boundingClientRect.coffee'

    # { ui_state } = require './ui_state.coffee'

    return combineReducers {

        # ui_state
        viewport_width
        viewport_height
        # viewport_x
        # viewport_y

        routing: routeReducer
    }
