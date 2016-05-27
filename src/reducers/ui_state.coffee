

{ HOME, ABOUT } = require('../constants/ui_states.coffee')

{ LOCATION_CHANGE, NAV_ABOUT, NAV_HOME, SET_BOUNDING_RECT } = require('../constants/action_types.coffee')

ui_state = ( prev_state = initial_state, action ) ->
    switch action.type
        when NAV_HOME
            return HOME
        when NAV_ABOUT
            return ABOUT
        else
            return prev_state


module.exports = { ui_state }
