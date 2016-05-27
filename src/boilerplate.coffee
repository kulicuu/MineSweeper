
c = -> console.log.apply console, arguments

React = require 'react'
React_DOM = require 'react-dom'
_ = require 'lodash'
shortid = require 'shortid'
gl_mat = require 'gl-matrix'
request = require 'superagent'

mat3 = gl_mat.mat3
vec3 = gl_mat.vec3
vec2 = gl_mat.vec2

module.exports = ->
    mat3: mat3
    vec3: vec3
    vec2: vec2
    request: request
    gl_mat: gl_mat
    _: _
    React: React
    React_DOM: React_DOM
    rr: -> React.createFactory(React.createClass.apply(React, arguments))
    c: c
    shortid: shortid
    assign: -> _.assign.apply(_, arguments)
    keys: -> _.keys.apply(_, arguments)


# {_, React, React_DOM, rr, c, shortid, assign, keys} = require('./boilerplate.coffee')()
