// Generated by CoffeeScript 1.7.1
(function() {
  module.exports = function(config) {
    return config.set({
      basePath: '',
      frameworks: ['jasmine'],
      files: ['app/bower_components/angular/angular.js', 'app/bower_components/angular-mocks/angular-mocks.js', 'app/bower_components/angular-resource/angular-resource.js', 'app/bower_components/angular-route/angular-route.js', 'app/bower_components/angular-bootstrap/ui-bootstrap-tpls.js', 'app/bower_components/underscore/underscore.js', 'app/scripts/*.coffee', 'app/scripts/**/*.coffee', 'test/mock/**/*.coffee', 'test/spec/**/*.coffee'],
      preprocessors: {
        '**/*.coffee': 'coffee'
      },
      exclude: [],
      port: 8080,
      logLevel: config.LOG_INFO,
      browsers: ['PhantomJS'],
      plugins: ['karma-phantomjs-launcher', 'karma-jasmine', 'karma-coffee-preprocessor'],
      autoWatch: true,
      singleRun: false,
      colors: true
    });
  };

}).call(this);