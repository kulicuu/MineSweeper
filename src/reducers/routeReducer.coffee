
{ LOCATION_CHANGE } = require 'react-router-redux'
c = -> console.log.apply console, arguments
routeReducer = (prev_state = initial_state, action) ->
    if action.type is LOCATION_CHANGE
        return _.assign(prev_state, {
            locationBeforeTransitions: action.payload
        })
    else
        return prev_state

module.exports = routeReducer
