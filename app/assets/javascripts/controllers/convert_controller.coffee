app.controller 'ConvertController', ['$scope', '$http', '$timeout', 'ngToast', ($scope, $http, $timeout, ngToast) ->
  $scope.active = false
  $scope.pollIds = []
  $scope.pollActive = false
  loadTime = 2000
  errorCount = 0
  loadPromise = null

  $scope.init = (url, poll_url) ->
    $scope.url = url
    $scope.poll_url = poll_url

  poll = ->
    $http.post(
      $scope.poll_url,
        ids: $scope.pollIds
    ).then($scope.pollSuccess)

  cancelPoll = ->
    $timeout.cancel loadPromise

  $scope.convert = ($event) ->
    $event.preventDefault()
    $scope.active = true
    # $scope.video_url = 'https://www.youtube.com/watch?v=a4LVgdGN_8g'
    $http.post(
      $scope.url,
        url: $scope.video_url
      ).then($scope.convertResponse)

  $scope.convertResponse = (resp) ->
    data = resp.data
    if data.errors
      ngToast.create
        className: 'danger'
        content: data.errors
    else
      $scope.pollIds.push data.content_id
      cancelPoll()
      loadPromise = $timeout poll, loadTime

  $scope.pollSuccess = (resp) ->
    data = resp.data
    if data.errors.length > 0
      ngToast.create
        className: 'danger'
        content: data.errors
      cancelPoll()
    else
      $('.poll').html data.poll_template
    if data.need_continue
      cancelPoll()
      loadPromise = $timeout poll, loadTime
]

