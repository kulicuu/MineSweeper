

{_, c} = require('../boilerplate.coffee')()


{ START_NEW_GAME, REVEAL, TOGGLE_FLAG } = require '../constants/minesweeper_actions_000_.coffee'


start_new_game = ->
    c 'start new game'

reveal = (tile_coord) ->
    c 'reveaoling', tile_coord
    type: REVEAL
    payload: tile_coord


reveal_thunk = (tile_coord) ->
    c tile_coord
    func_000 = (dispatch, get_state) =>
        c 'the', dispatch, get_state
        c 'before state', get_state().get(tile_coord)
        dispatch(reveal(tile_coord))
        c 'after state', get_state().get(tile_coord)

    return func_000.bind({tile_coord})



toggle_flag = (tile_coord) ->

    c 'toggle_flag at coord', tile_coord


module.exports = { start_new_game, reveal: reveal_thunk, toggle_flag }
