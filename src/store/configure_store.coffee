{c, _} = require('../boilerplate.coffee')()
{ createStore, applyMiddleware } = require 'redux'

thunk = require('redux-thunk').default

promise = require 'redux-promise'
createLogger = require 'redux-logger'
logger = createLogger()


configure_store = module.exports = (initial_state) ->
    # return createStore(root_reducer, initial_state, applyMiddleware(api))
    root_reducer = require('../reducers/index.coffee')(initial_state)
    return createStore(root_reducer, initial_state, applyMiddleware(thunk, promise, logger))
