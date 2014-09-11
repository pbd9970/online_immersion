app.directive('chatHeader', ['$route', function($route) {
  return {
    restrict: 'E',
    templateUrl: $route.current.params.chatroomId + '/views/chatroom_header',
    controller: 'chatHeaderCtrl'
  };
}]);
