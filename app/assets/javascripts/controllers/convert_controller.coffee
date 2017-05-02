app.controller 'ConvertController', ['$scope', ($scope) ->
  $scope.active = false
  $scope.convert = ($event) ->
    $event.preventDefault()
    $scope.active = true
]

