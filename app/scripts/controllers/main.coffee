'use strict'

angular.module('ngBundleApp')
  .controller 'MainCtrl', ($scope, $interval, Item, Price, Split) ->
    # Use scope.private for enabling unit tests to access private functions
    $scope.private = {}

    ###
    Fetch items
    ###
    $scope.items = Item.list()

    ###
    Fetch price
    ###
    # Initialize
    $scope.price = Price.fetch()
    $scope.price.purchase = $scope.price.value
    $scope.price.changed = false

    # Update at an interval
    updatePrice = $scope.private.updatePrice = ->
      _.extend($scope.price, Price.fetch())
      if !$scope.price.changed
        $scope.price.purchase = $scope.price.value

    priceUpdateRate = 2000
    intervalId = $interval(updatePrice, priceUpdateRate)

    # Handle memory leak
    cancelUpdate = $scope.private.cancelUpdate = ->
      $interval.cancel(intervalId)
    $scope.$on '$destroy', -> cancelUpdate()

    ###
    Determine eligibilty for locked items
    ###
    $scope.beatAvg = -> $scope.price.purchase > $scope.price.value
    $scope.eligible = (item) -> !item.locked or $scope.beatAvg()

    ###
    User data
    ###
    $scope.user =
      email: undefined

    ###
    Split data
    ###
    # Initialize
    $scope.splits = Split.list()

    # Percentile
    # TODO: Once stabilized, refactor into directive
    $scope.percentile = (val) ->
      # 100 * (val / max)
      10 * val

    # Enable hover data binding
    $scope.private.updateHover = (item, value) ->
      if !item.locked then item.hover = value
    $scope.updateHover = (index, value) ->
      $scope.private.updateHover($scope.splits[index], value)

    # Watch for split updates and request rebalance on rating changes
    for index in [0..$scope.splits.length]
      $scope.$watchCollection "splits[#{index}]", (newE, oldE) ->
        if oldE and newE and oldE.rating != newE.rating
          console.log "#{newE.name}: #{oldE.rating} -> #{newE.rating}"
          Split.propagateChange(newE.id)
