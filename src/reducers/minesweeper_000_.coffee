



{ c, _ } = require('../boilerplate.coffee')()

{ START_NEW_GAME, REVEAL, TOGGLE_FLAG } = require '../constants/minesweeper_actions_000_.coffee'

tile_reducer_factory = ({idx, jdx, initial_state}) ->
    tile_reducer = (prev_state = initial_state, action) ->
        # c 'lets see prev_state anyway', prev_state
        if (action.type is REVEAL) and (payload is "TILE:#{idx}:#{jdx}")
            sparc = prev_state
            c 'sparc', sparc
            return prev_state
        else
            # c 'got else'
            return prev_state
    return tile_reducer

game_generics_reducer_factory = (initial_state) ->
    size_reducer = (prev_state = initial_state, action) ->
        return prev_state
    # return size_reducer

    game_state_reducer = (prev_state = initial_state, action) ->
        return prev_state

    time_elapsed_reducer = (prev_state = initial_state, action) ->
        return prev_state

    return { size_reducer, game_state_reducer, time_elapsed_reducer }


module.exports = ({initial_state})->
    # c 'initial_state_pre', initial_state_pre
    # size = initial_state_pre.SIZE

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
