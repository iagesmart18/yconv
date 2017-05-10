app.controller 'ConvertController', ['$scope', ($scope) ->
  $scope.active = false
  $scope.init = (url) ->
    $scope.url = url

  $scope.convert = ($event) ->
    $event.preventDefault()
    $scope.active = true
    console.log $scope.video_url
    $scope.video_url = 'https://www.youtube.com/watch?v=a4LVgdGN_8g'
    $.ajax
      url: $scope.url
      method: 'POST'
      data: 
        url: $scope.video_url
      success: (data) ->
        console.log data
      fail: (data) ->
        console.log data
]

