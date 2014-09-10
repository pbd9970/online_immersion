app.directive('videoChat', ['$route', function($route) {
  return {
    restrict: 'E',
    templateUrl: $route.current.params.chatroomId + '/views/video_chat',
    controller: 'videoChatCtrl'
  };
}]);
