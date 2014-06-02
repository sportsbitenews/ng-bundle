'use strict'

angular.module('ngBundleApp')
  .factory 'Split', ->
    splits = [
      {id: 0, name: 'Charity', rating: 3, locked: true, hover: undefined},
      {id: 1, name: 'Developers', rating: 6, locked: true, hover: undefined},
      {id: 2, name: 'Humble Tip', rating: 1, locked: true, hover: undefined}
    ]

    lowerBound = (val, bound) -> if val >= bound then val else bound
    upperBound = (val, bound) -> if val <= bound then val else bound
    getUnlockedSplits = -> (s for s in splits when !s.locked)
    ratings = -> (s.rating for s in splits)
    totalRating = -> ratings().reduce (a, b) -> a + b

    balanceRatings = (changedId) ->
      # Sort unlocked splits s.t. recently changedSplit is adjusted last
      sorted = _.sortBy(getUnlockedSplits(), (i) -> changedId == i.id)
      for item in sorted
        offset = totalRating() - 10
        if offset > 0
          difference = item.rating - offset
          item.rating = lowerBound(difference, 0)
        else if offset < 0
          difference = item.rating + (-offset)
          item.rating = upperBound(difference, 10)
        else
          console.log "Rating balance reached"
          break

    # Public API here
    {
      list: ->
        splits

      propagateChange: (sourceId) ->
        balanceRatings(sourceId)

      # For unit testing
      ratings: -> ratings()
      balanceRatings: (id) -> balanceRatings(id)
    }
