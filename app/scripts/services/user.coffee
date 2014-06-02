'use strict'

angular.module('ngBundleApp')
  .factory 'User', ->
    email = undefined

    # Public API here
    {
      # TODO: unit test
      email: -> email
      # TODO: unit test
      setEmail: (newAddress) ->
        email = newAddress
    }
