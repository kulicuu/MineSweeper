

{_, c} = require('../boilerplate.coffee')()


{ START_NEW_GAME, REVEAL, TOGGLE_FLAG } = require '../constants/minesweeper_actions_000_.coffee'


start_new_game = ->
    c 'start new game'

reveal = (tile_coord) ->

    c 'reveal tile at coord', tile_coord

toggle_flag = (tile_coord) ->

    c 'toggle_flag at coord', tile_coord


module.exports = { start_new_game, reveal, toggle_flag }
