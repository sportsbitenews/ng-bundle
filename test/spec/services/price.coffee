'use strict'

describe 'Service: Price', ->
  # initialize namespace
  Price = {}

  # load the service's module
  beforeEach ->
    module 'ngBundleApp'
    inject (_Price_) ->
      Price = _Price_

  it 'should normalize errornous numbers precision loss', ->
    nums = [
      {input: 4.34838, output: 4.35}
      {input: 12.82053205, output: 12.82}
      {input: -9.135124, output: -9.14}
      {input: 3.3, output: 3.3}
      {input: 34, output: 34}
    ]
    for n in nums
      expect(Price.normalize n.input).toBe n.output

  it 'should timestamp its output', ->
    timestamp = Price.fetch().updated
    expect(Boolean Date.parse timestamp.toString()).toBe true

  it 'should generate a randomized value between 5 and 6', ->
    for [0..10000]
      value = Price.fetch().value
      expect(value >= 5).toBeTruthy()
      expect(value <= 6).toBeTruthy()
