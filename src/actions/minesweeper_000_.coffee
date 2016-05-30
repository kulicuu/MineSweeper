

{_, c} = require('../boilerplate.coffee')()


{ START_NEW_GAME, REVEAL, REVEAL_MULTIPLE, TOGGLE_FLAG, LOSE_GAME, WIN_GAME } = require '../constants/minesweeper_actions_000_.coffee'

{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../constants/tile_states.coffee'

{ NOT_STARTED, IN_PROGRESS, FINISHED, TIME_ELAPSED, GAME_STATE, SIZE } = require '../constants/minesweeper_states.coffee'


start_new_game = ->
    c 'start new game'
    type: START_NEW_GAME

reveal = (tile_coord) ->
    c 'reveaoling', tile_coord
    type: REVEAL
    payload: tile_coord

reveal_multiple = (rayy_zeros) ->
    type: REVEAL_MULTIPLE
    payload: rayy_zeros


lose_game = (payload) ->
    type: LOSE_GAME

win_game = ->
    type: WIN_GAME


reveal_thunk = (tile_coord) ->
    c tile_coord

    check_game_state = (get_state) ->
        state = get_state()
        size = state.get SIZE
        basket_cloaked_clean_water = []
        game_over_blown_up = false
        for idx in [0 .. (size - 1)]
            for jdx in [0 .. (size - 1)]
                cursor = "#{TILE}:#{idx}:#{jdx}"
                [is_mined, is_revealed, is_flagged] = state.get(cursor).split ':'
                if (is_mined is MINED) and (is_revealed is REVEALED)
                    c 'game over man'
                    game_over_blown_up = true
                if (is_mined isnt MINED) and (is_revealed is NOT_REVEALED)
                    basket_cloaked_clean_water.push cursor
        game_over_won = basket_cloaked_clean_water.length is 0
        return {
            game_over_blown_up
            game_over_won
        }


    recursive_zero_reveal_002 = ({idx, jdx, stack, state, size, counter}) ->
        ac = arguments.callee
        cursor = "#{TILE}:#{idx}:#{jdx}"
        stack.push "#{TILE}:#{idx}:#{jdx}"
        if state[cursor].split(':')[0] is UNMINED_ZERO_MINE_NEIGHBORS
            if jdx < (size - 1)
                if not _.includes(stack, "#{TILE}:#{idx}:#{jdx + 1}")
                    ac {idx, jdx: jdx + 1, stack, state, size}
            if jdx > 0
                if not _.includes(stack, "#{TILE}:#{idx}:#{jdx - 1}")
                    ac {idx, jdx: jdx - 1, stack, state, size}
            if idx > 0
                if not _.includes(stack, "#{TILE}:#{idx - 1}:#{jdx}")
                    ac {idx: idx - 1, jdx, stack, state, size}
                if jdx > 0
                    if not _.includes(stack, "#{TILE}:#{idx - 1}:#{jdx - 1}")
                        ac {idx: idx - 1, jdx: jdx - 1, stack, state, size}
                if jdx < (size - 1)
                    if not _.includes(stack, "#{TILE}:#{idx - 1}:#{jdx + 1}")
                        ac {idx: idx - 1, jdx: jdx + 1, stack, state, size}
            if idx < (size - 1)
                if not _.includes(stack, "#{TILE}:#{idx + 1}:#{jdx}")
                    ac {idx: idx + 1, jdx, stack, state, size}
                if jdx > 0
                    if not _.includes(stack, "#{TILE}:#{idx + 1}:#{jdx - 1}")
                        ac {idx: idx + 1, jdx: jdx - 1, stack, state, size}
                if jdx < (size - 1)
                    if not _.includes(stack, "#{TILE}:#{idx + 1}:#{jdx + 1}")
                        ac {idx: idx + 1, jdx: jdx + 1, stack, state, size}

        return stack




    zero_reveal = (get_state) ->
        c 'tile_coord is scoped here also', tile_coord
        state = get_state()
        size = state.get SIZE
        rayy = tile_coord.split ':'
        idx = parseInt rayy[1]
        jdx = parseInt rayy[2]
        arq = state.toJS()
        stack = recursive_zero_reveal_002 {idx, jdx, stack: [], state: arq, size, counter: 0}
        return stack



    func_000 = (dispatch, get_state) =>
        c 'the', dispatch, get_state
        before_state = get_state().get(tile_coord)
        c 'before_state', before_state
        [is_mined, is_revealed, is_flagged] = before_state.split(':')
        c 'is_mined', is_mined
        if is_mined is UNMINED_ZERO_MINE_NEIGHBORS
            c 'CALL THE RECURSIVE ZERO REVEALER !!!!!!!!!!!!!!!!!!!!!!'

            rayy_zeros = zero_reveal get_state
            c 'rayy_zeros', rayy_zeros
            dispatch(reveal_multiple(rayy_zeros))

        else
            dispatch(reveal(tile_coord))

        c 'after state', get_state().get(tile_coord)
        game_status = check_game_state get_state
        c 'game_status', game_status
        if game_status.game_over_blown_up is true
            dispatch(lose_game())
        else if game_status.game_over_won is true
            dispatch(win_game())



    return func_000






toggle_flag = (tile_coord) ->

    c 'toggle_flag at coord', tile_coord


module.exports = { start_new_game, reveal: reveal_thunk, toggle_flag }
