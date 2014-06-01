'use strict'

angular.module('ngBundleApp')
  .directive 'currency', ->
    require: 'ngModel',
    link: (scope, element, attrs, ngModel) ->
      ngModel.$formatters.push (val) ->
        "#{val}"
      ngModel.$parsers.push (val) ->
        val.replace(/^\$/, '')
