'use strict'

angular.module('ngBundleApp')
  .factory 'Item', ->
    items = ({id: n, name:"Item #{n}", locked: n > 4} for n in [1..6])
    unlocked = []


    # Public API
    {
      list: ->
        items

      # TODO: unit test
      unlocked: -> unlocked
      # TODO: unit test
      unlock: (ids) ->
        unlocked = ids
    }
