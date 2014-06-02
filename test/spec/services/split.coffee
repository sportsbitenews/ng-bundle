'use strict'

describe 'Service: Split', ->

  # load the service's module
  beforeEach module 'ngBundleApp'

  # instantiate service
  Split = {}
  beforeEach inject (_Split_) ->
    Split = _Split_

  it 'should return three splits', ->
    expect(Split.default().length).toBe 3

  it 'should return splits with unique IDs', ->
    ids = (s.id for s in Split.default())
    uniques = _.uniq(ids)
    expect(ids.length).toBe uniques.length

  it 'should return splits with ratings that sum to 10', ->
    ratings = (s.rating for s in Split.default())
    sum = ratings.reduce (a, b) -> a + b
    expect(sum).toBe 10
