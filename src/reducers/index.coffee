
{ _, c } = require('../boilerplate.coffee')()
{ combineReducers } = require 'redux-immutable'

module.exports = ({initial_state, initial_state_pre}) ->
    c 'initial_state in reducer index', initial_state
    routeReducer = require './routeReducer.coffee'

    { viewport_height, viewport_width } = require './boundingClientRect.coffee'

    arq_2 = require('./minesweeper_000_.coffee')({initial_state_pre, initial_state})

    arq_0 = {
        viewport_width
        viewport_height
        routing: routeReducer
    }

    arq_1 = _.assign arq_0, arq_2

    return combineReducers arq_1
