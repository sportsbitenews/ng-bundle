'use strict'

describe 'Factory: Split', ->

  # load the service's module
  beforeEach module 'ngBundleApp'

  # instantiate service
  Split = {}
  beforeEach inject (_Split_) ->
    Split = _Split_

  it 'should return three splits', ->
    expect(Split.list().length).toBe 3

  it 'should return splits with unique IDs', ->
    ids = (s.id for s in Split.list())
    uniques = _.uniq(ids)
    expect(ids.length).toBe uniques.length

  it 'should initialize with [3, 6, 1] for ratings', ->
    expect(_.isEqual(Split.ratings(), [3, 6, 1])).toBeTruthy()

  it 'should reject changes in the one split case', ->
    ratings0 = Split.ratings()  # expect

    splits = Split.list()
    _.extend(splits[0], {locked: false, rating: 5})
    Split.balanceRatings(0)

    expect(_.isEqual(Split.ratings(), ratings0)).toBeTruthy()

  it 'should alter the other split as much as possible in the two split case', ->
    splits = Split.list()
    ratings0 = Split.ratings()

    _.extend(splits[0], {locked: false, rating: 5})
    splits[1].locked = false
    Split.balanceRatings(0)
    ratings1 = Split.ratings()

    splits[0].rating = 7
    Split.balanceRatings(0)
    ratings2 = Split.ratings()

    splits[0].rating = 10
    Split.balanceRatings(0)
    ratings4 = Split.ratings()

    splits[0].rating = 12
    Split.balanceRatings(0)
    ratings5 = Split.ratings()

    expect(_.isEqual(ratings1, [5, 4, 1])).toBeTruthy()
    expect(_.isEqual(ratings2, [7, 2, 1])).toBeTruthy()
    expect(_.isEqual(ratings4, [9, 0, 1])).toBeTruthy()
    expect(_.isEqual(ratings5, [9, 0, 1])).toBeTruthy()

  it 'should alter other splits as much as possible in the three split case', ->
    splits = Split.list()
    ratings0 = Split.ratings()

    _.extend(splits[0], {locked: false, rating: 5})
    splits[1].locked = false
    splits[2].locked = false
    Split.balanceRatings(0)
    ratings1 = Split.ratings()

    _.extend(splits[0], {rating: 7})
    Split.balanceRatings(0)
    ratings2 = Split.ratings()

    _.extend(splits[0], {rating: 10})
    Split.balanceRatings(0)
    ratings4 = Split.ratings()

    _.extend(splits[0], {rating: 12})
    Split.balanceRatings(0)
    ratings5 = Split.ratings()

    _.extend(splits[1], {rating: 5})
    Split.balanceRatings(1)
    ratings6 = Split.ratings()

    expect(_.isEqual(ratings1, [5, 4, 1])).toBeTruthy()
    expect(_.isEqual(ratings2, [7, 2, 1])).toBeTruthy()
    expect(_.isEqual(ratings4, [10, 0, 0])).toBeTruthy()
    expect(_.isEqual(ratings5, [10, 0, 0])).toBeTruthy()
    expect(_.isEqual(ratings6, [0, 5, 5]) or _.isEqual(ratings6, [5, 5, 0]))
      .toBeTruthy()
