
{ _, c } = require('../boilerplate.coffee')()
{ combineReducers } = require 'redux-immutable'
{ START_NEW_GAME, REVEAL, TOGGLE_FLAG, REVEAL_MULTIPLE, WIN_GAME, LOSE_GAME } = require '../constants/minesweeper_actions_000_.coffee'

Immutable = require 'immutable'

module.exports = ({initial_state, initial_state_pre}) ->

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
            { viewport_width: width, viewport_height: height } = state.toJS()
            state = undefined

            initial_state_pre = require('../store/initial_state/index.coffee')({width, height})
            initial_state2 = Immutable.Map initial_state_pre
            return app_reducer(state = initial_state2, action)
        else
            return app_reducer(state, action)
    # return app_reducer(arq_1)

    return root_reducer



    # return combineReducers arq_1
