
{ _, c } = require('../boilerplate.coffee')()
{ combineReducers } = require 'redux-immutable'

module.exports = (initial_state) ->

    routeReducer = require './routeReducer.coffee'

    { viewport_height, viewport_width } = require './boundingClientRect.coffee'


    return combineReducers {

        viewport_width
        viewport_height


        routing: routeReducer
    }
