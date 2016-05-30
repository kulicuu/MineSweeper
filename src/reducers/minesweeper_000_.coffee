



{ c, _ } = require('../boilerplate.coffee')()

{ combineReducers } = require 'redux-immutable'

{ START_NEW_GAME, REVEAL, TOGGLE_FLAG, REVEAL_MULTIPLE, WIN_GAME, LOSE_GAME } = require '../constants/minesweeper_actions_000_.coffee'

{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../constants/tile_states.coffee'

tile_reducer_factory = ({idx, jdx, initial_state}) ->
    tile_reducer = (prev_state = initial_state, action) ->
        [is_mined, is_revealed, is_flagged] = prev_state.split ':'
        if (action.type is REVEAL) and (action.payload is "TILE:#{idx}:#{jdx}") and (is_revealed is NOT_REVEALED)
            return [is_mined, REVEALED, is_flagged].join(':')
        else if (action.type is REVEAL_MULTIPLE) and (_.includes(action.payload, "#{TILE}:#{idx}:#{jdx}")) and (is_revealed is NOT_REVEALED)
            return [is_mined, REVEALED, is_flagged].join(':')
        else
            return prev_state
    return tile_reducer

game_generics_reducer_factory = (initial_state) ->
    size_reducer = (prev_state = initial_state, action) ->
        return prev_state
    # return size_reducer

    game_state_reducer = (prev_state = initial_state, action) ->
        c 'in game state reducer'
        if action.type is START_NEW_GAME
            c 'starting new game'


        return prev_state

    time_elapsed_reducer = (prev_state = initial_state, action) ->
        return prev_state

    return { size_reducer, game_state_reducer, time_elapsed_reducer }


module.exports = ({initial_state, arq_0})->


    { size_reducer, game_state_reducer, time_elapsed_reducer } = game_generics_reducer_factory(initial_state)
    arq = {
        SIZE: size_reducer
        GAME_STATE: game_state_reducer
        TIME_ELAPSED: time_elapsed_reducer
    }

    size = initial_state.get 'SIZE'
    for idx in [0 .. (size - 1)]
        for jdx in [0 .. (size - 1)]
            arq["TILE:#{idx}:#{jdx}"] = tile_reducer_factory({idx, jdx, initial_state})


    return arq # but merge it with the other attributes first
