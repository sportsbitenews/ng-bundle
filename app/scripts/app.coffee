'use strict'

angular
  .module('ngBundleApp', [
    'ngResource',
    'ngRoute',
    'ui.bootstrap'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/checkout',
        templateUrl: 'views/checkout.html'
        controller: 'CheckoutCtrl'
      .otherwise
        redirectTo: '/'
