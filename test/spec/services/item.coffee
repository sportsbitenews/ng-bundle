'use strict'

describe 'Factory: Item', ->
  # initialize namespace
  Item = {}

  # load the service's module
  beforeEach ->
    module 'ngBundleApp'
    inject (_Item_) ->
      Item = _Item_

  it 'should list six sample items with correct names', ->
    expect(Item.list().length).toBe 6

  it 'should list sample items named "Item 1", "Item 2", etc.', ->
    for item in Item.list()
      expect(item.name).toBe "Item #{item.id}"

  it 'should have two locked items', ->
    locked = (i for i in Item.list() when i.locked)
    expect(locked.length).toBe 2
