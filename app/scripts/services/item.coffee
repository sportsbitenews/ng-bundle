'use strict'

angular.module('ngBundleApp')
  .factory 'Item', ->
    items = ({id: n, name:"Item #{n}", locked: n > 4} for n in [1..6])

    # Public API
    {
      list: ->
        items
    }
