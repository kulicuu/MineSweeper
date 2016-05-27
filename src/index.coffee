

{_, React, React_DOM, rr, c} = require('./boilerplate.coffee')()

root = document.getElementById 'root'


Provider = React.createFactory require('react-redux').Provider
Immutable = require 'immutable'

{ Router: _Router, Route: _Route, IndexRoute: _IndexRoute, browserHistory } = require 'react-router'
{ syncHistoryWithStore } = require 'react-router-redux'

Router = React.createFactory _Router
Route = React.createFactory _Route

{ set_bounding_rect } = require './actions/set_bounding_rect.coffee'



window.onload = =>
    {width, height, x, y} = root.getBoundingClientRect()

    initial_state = Immutable.Map
        routing: '/'
        viewport_width: width
        viewport_height: height
        # viewport_x: x
        # viewport_y: y

    store = require('./store/configure_store.coffee')(initial_state)

    debounce = (func, wait, immediate) ->
        timeout = 'scoped here'
        ->
            context = @
            args = arguments
            later = ->
                timeout = null
                if not(immediate) then func.apply(context, args)
            callNow = immediate and not(timeout)
            clearTimeout(timeout)
            timeout = setTimeout(later, wait)
            if callNow then func.apply(context, args)

    set_boundingRect = ->
        {width, height, x, y} = root.getBoundingClientRect()
        arq =
            viewport_x: x
            viewport_y: y
            viewport_width: width
            viewport_height: height
        store.dispatch(set_bounding_rect(arq))

    window.onresize = debounce(set_boundingRect, 200, false)

    history = syncHistoryWithStore(browserHistory, store,
        selectLocationState: (state)->
            return state.get('routing')
    )





    minesweeper = React.createFactory require('./containers/minesweeper_000_.coffee')

    index = rr
        render: ->
            Provider
                store: store
                ,
                Router
                    history: history
                    ,
                    Route
                        path: '/'
                        component: minesweeper
                        ,


    React_DOM.render index(), root
