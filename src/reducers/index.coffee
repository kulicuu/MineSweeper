
{ _, c } = require('../boilerplate.coffee')()
{ combineReducers } = require 'redux-immutable'
{ START_NEW_GAME, REVEAL, TOGGLE_FLAG, REVEAL_MULTIPLE, WIN_GAME, LOSE_GAME } = require '../constants/minesweeper_actions_000_.coffee'


module.exports = ({initial_state, initial_state_pre}) ->
    c 'initial_state in reducer index', initial_state
    routeReducer = require './routeReducer.coffee'

    { viewport_height, viewport_width } = require './boundingClientRect.coffee'

    arq_0 = {
        viewport_width
        viewport_height
        routing: routeReducer
    }

    arq_2 = require('./minesweeper_000_.coffee')({initial_state, arq_0})



    arq_1 = _.assign arq_0, arq_2

    # root_reducer = (state, action) =>

    app_reducer = combineReducers(arq_1)

    root_reducer = (state, action) =>
        if action.type is START_NEW_GAME
            state = undefined
            return app_reducer(state = initial_state, action)
        else
            return app_reducer(state, action)
    # return app_reducer(arq_1)

    return root_reducer



    # return combineReducers arq_1
