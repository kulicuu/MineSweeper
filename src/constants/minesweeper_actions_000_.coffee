




keymirror = require 'keymirror'


module.exports = minesweeper_action_types = keymirror

    #actions the player can induce directly
    START_NEW_GAME: null

    REVEAL: null

    TOGGLE_FLAG: null


    # actions induced only by the computer directly; player indirectly
    LOSE_GAME: null

    WIN_GAME: null

    REVEAL_MULTIPLE: null

    FALLOUT: null
