'use strict'

angular.module('ngBundleApp')
  .controller 'MainCtrl', ($scope, $interval) ->
    # Mock inventory data
    $scope.items = ({id: n, name:"Item #{n}", locked: n > 4} for n in [1..6])

    # Initialize and randomize price
    $scope.price =
      updated: Date()
      value: 5.25
      purchase: 5.25
      changed: false
    $scope.user =
      email: undefined

    updatePrice = ->
      val = Math.floor(Math.random() * 100)/100
      $scope.price.updated = Date()
      $scope.price.value = 5 + val
      if !$scope.price.changed
        $scope.price.purchase = $scope.price.value

    # Attach price updates to interval
    intervalId = $interval(updatePrice, 4500)
    $scope.$on '$destroy', ->
      $interval.cancel(intervalId)

    # Eligibility criteria for locked items
    $scope.beatAvg = -> $scope.price.purchase > $scope.price.value
    $scope.eligible = (item) ->
      !item.locked or $scope.beatAvg()
