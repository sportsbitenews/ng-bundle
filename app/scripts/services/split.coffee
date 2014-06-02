'use strict'

angular.module('ngBundleApp')
  .factory 'Split', ->
    defaultSplit = [
      {id: 0, name: 'Charity', rating: 3, locked: true, hover: undefined},
      {id: 1, name: 'Developers', rating: 6, locked: true, hover: undefined},
      {id: 2, name: 'Humble Tip', rating: 1, locked: true, hover: undefined}
    ]

    # Public API here
    {
      default: ->
        defaultSplit
    }
