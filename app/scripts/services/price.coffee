'use strict'

angular.module('ngBundleApp')
  .factory 'Price', ->
    checkout =
      average: undefined
      purchase: undefined
      timestamp: undefined

    randomCents = ->
      Math.floor(Math.random() * 100)

    # Ensure against loss of precision... Thanks JS
    # Related StackOverflow: http://goo.gl/BZkiA1
    normalizeCurrency = (value) ->
      if typeof(value) == 'number'
        return Number(value.toFixed(2))
      else
        return value

    generate = (baseValue) ->
      cents = randomCents()
      dollars = baseValue + cents / 100
      normalizeCurrency(dollars)

    # Public API here
    {
      normalize: (value) -> normalizeCurrency(value)

      # TODO: unit test
      getCheckout: -> checkout
      # TODO: unit test
      setCheckout: (purchasePrice, avgPrice) ->
        checkout.average = avgPrice
        checkout.purchase = purchasePrice
        checkout.timestamp = Date()

      fetch: ->
        average: generate(5)
        updated: Date()
    }
