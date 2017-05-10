app.controller 'ConvertController', ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->
  $scope.active = false
  $scope.pollIds = []
  loadTime = 1000
  errorCount = 0
  loadPromise = null

  $scope.init = (url, poll_url) ->
    $scope.url = url
    $scope.poll_url = poll_url


  poll = ->
    $http.post(
      $scope.poll_url,
        ids: $scope.pollIds
    ).then( (resp) ->
        console.log 'success'
        console.log resp
    )

  $scope.convert = ($event) ->
    $event.preventDefault()
    $scope.active = true
    console.log $scope.video_url
    $scope.video_url = 'https://www.youtube.com/watch?v=a4LVgdGN_8g'
    $http.post(
      $scope.url,
        url: $scope.video_url
      ).then( (resp) ->
        console.log resp.data
      )
]

