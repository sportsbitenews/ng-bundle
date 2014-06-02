'use strict'

describe 'Controller: MainCtrl', ->
  # initalize namespace
  MainCtrl = scope = {}

  beforeEach ->
    # load the controller's module
    module 'ngBundleApp'

    # initialize the controller and a mock scope
    inject ($controller, $rootScope) ->
      scope = $rootScope.$new()
      MainCtrl = $controller 'MainCtrl', {
        $scope: scope
      }
      scope.private.cancelUpdate()

  it 'should update the purchase price if the user has not yet altered it', ->
    expect(scope.price.value).toBe scope.price.purchase
    scope.private.updatePrice()
    expect(scope.price.value).toBe scope.price.purchase

  it 'should not update the purchase price if the user has altered it', ->
    # Ensure previous test holds initially
    expect(scope.price.value).toBe scope.price.purchase
    scope.price.changed = true

    # Count how often the average value and the purchase values are the same
    sameTally = 0

    for [0..100]
      scope.private.updatePrice()
      if scope.price.value == scope.price.purchase then sameTally++

    # Generated prices are more likely to be different than the same
    expect(sameTally).toBeLessThan(100-sameTally)

  it 'should mark an item as eligible if unlocked', ->
    unlockedItem = {locked: false}
    expect(scope.eligible(unlockedItem)).toBeTruthy()

  it 'should mark an item as eligible if the average has been beat', ->
    item = {locked: true}
    scope.price.purchase = 6
    scope.price.value = 5
    expect(scope.eligible(item)).toBeTruthy()
    scope.price.purchase = 4
    scope.price.value = 5
    expect(scope.eligible(item)).toBeFalsy()

  it "should update unlocked split's hover values", ->
    value = 20
    unlockedItem = {hover: 0, locked: false}
    scope.private.updateHover(unlockedItem, value)
    expect(unlockedItem.hover).toBe value

  it "should not update locked split's hover values", ->
    value = 20
    lockedItem = {hover: 0, locked: true}
    scope.private.updateHover(lockedItem, value)
    expect(lockedItem.hover).not.toBe value
