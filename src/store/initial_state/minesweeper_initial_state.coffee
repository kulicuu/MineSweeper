
{ c, _ } = require('../../boilerplate.coffee')()

{ NOT_STARTED, IN_PROGRESS, FINISHED, TIME_ELAPSED, GAME_STATE, SIZE } = require '../../constants/minesweeper_states.coffee'


{ TILE, FLAGGED, NOT_FLAGGED, MINED, UNMINED, UNMINED_ZERO_MINE_NEIGHBORS, UNMINED_ONE_MINE_NEIGHBOR, UNMINED_TWO_MINE_NEIGHBORS, UNMINED_THREE_MINE_NEIGHBORS, UNMINED_FOUR_MINE_NEIGHBORS, UNMINED_FIVE_MINE_NEIGHBORS, UNMINED_SIX_MINE_NEIGHBORS, UNMINED_SEVEN_MINE_NEIGHBORS, UNMINED_EIGHT_MINE_NEIGHBORS, REVEALED, NOT_REVEALED } = require '../../constants/tile_states.coffee'

lay_mines = (size = 20, acc = {}, mined_probability = .133) ->
        for idx in [0 .. (size - 1)]
            for jdx in [0 .. (size - 1)]
                if Math.random() < mined_probability
                    acc["#{TILE}:#{idx}:#{jdx}"] = MINED
                else
                    acc["#{TILE}:#{idx}:#{jdx}"] = UNMINED
        return acc

mine_and_salt_water = (size = 20, acc = {}) ->
    arq = lay_mines(size, {})
    for idx in [0 .. (size - 1)]
        for jdx in [0 .. (size - 1)]
            if arq["#{TILE}:#{idx}:#{jdx}"] is UNMINED
                counter = 0
                if idx > 0
                    if arq["#{TILE}:#{idx - 1}:#{jdx}"] is MINED then counter++
                    if jdx > 0
                        if arq["#{TILE}:#{idx - 1}:#{jdx - 1}"] is MINED then counter++
                    if jdx < (size - 1)
                        if arq["#{TILE}:#{idx - 1}:#{jdx + 1}"] is MINED then counter++
                if idx < (size - 1)
                    if arq["#{TILE}:#{idx + 1}:#{jdx}"] is MINED then counter++
                    if jdx > 0
                        if arq["#{TILE}:#{idx + 1}:#{jdx - 1}"] is MINED then counter++
                    if jdx < (size - 1)
                        if arq["#{TILE}:#{idx + 1}:#{jdx + 1}"] is MINED then counter++
                if jdx > 0
                    if arq["#{TILE}:#{idx}:#{jdx - 1}"] is MINED then counter++
                if jdx < (size - 1)
                    if arq["#{TILE}:#{idx}:#{jdx + 1}"] is MINED then counter++

                number = switch counter
                    when 0 then UNMINED_ZERO_MINE_NEIGHBORS
                    when 1 then UNMINED_ONE_MINE_NEIGHBOR
                    when 2 then UNMINED_TWO_MINE_NEIGHBORS
                    when 3 then UNMINED_THREE_MINE_NEIGHBORS
                    when 4 then UNMINED_FOUR_MINE_NEIGHBORS
                    when 5 then UNMINED_FIVE_MINE_NEIGHBORS
                    when 6 then UNMINED_SIX_MINE_NEIGHBORS
                    when 7 then UNMINED_SEVEN_MINE_NEIGHBORS
                    when 8 then UNMINED_EIGHT_MINE_NEIGHBORS
                acc["#{TILE}:#{idx}:#{jdx}"] = "#{number}:#{NOT_REVEALED}:#{NOT_FLAGGED}"
            else if arq["#{TILE}:#{idx}:#{jdx}"] is MINED
                acc["#{TILE}:#{idx}:#{jdx}"] = "#{MINED}:#{NOT_REVEALED}:#{NOT_FLAGGED}"
            else
                throw "problem in salt water"
    return acc

module.exports = ( size = 20 ) ->

    starting_board = mine_and_salt_water(size)

    game_meta =
        TIME_ELAPSED: 0
        GAME_STATE: NOT_STARTED
        SIZE: size

    return _.assign(game_meta, starting_board)
