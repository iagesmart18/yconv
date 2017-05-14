window.app = angular.module('app', ['ngToast'
])

window.app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

$(document).on 'turbolinks:load', ->
  angular.bootstrap document.body, ['app']


app.controller 'ApplicationController', ($scope) ->


