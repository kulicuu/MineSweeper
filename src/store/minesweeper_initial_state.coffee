



# it occurred to me it may be a good idea to have intial state as an invariant that can be required from
# a variety of places.

# so but also we want to keep game state separate from ui stuff like boundingClientRect


# these can both be set up as raw javasrcript objects and then merged into an Immutable Map on
# startup


module.exports =
    layla: null
