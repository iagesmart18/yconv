window.app = angular.module('app', [
])

window.app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

app.controller 'ApplicationController', ($scope) ->


