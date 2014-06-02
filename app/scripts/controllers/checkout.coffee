'use strict'

angular.module('ngBundleApp')
  .controller 'CheckoutCtrl', ($scope, $location, Item, Price, Split, User) ->
    # TODO: unit test

    if not (Item.unlocked().length and Boolean(User.email()))
      $location.path '/'

    $scope.items = Item.list()
    $scope.email = User.email()
    $scope.checkout = Price.getCheckout()
    $scope.splits = Split.list()

    $scope.eligible = (id) -> id in Item.unlocked()
