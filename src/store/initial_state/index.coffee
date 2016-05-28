

{ _, c } = require('../../boilerplate.coffee')()


module.exports = initial_state = ({width, height}) ->
    ui_base = require('./ui_base.coffee')({width, height})
    minesweeper = require('./minesweeper_initial_state.coffee')()
    return _.assign(ui_base, minesweeper)
