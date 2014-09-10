app.directive('textChat', ['$route', function($route) {
  return {
    restrict: 'E',
    templateUrl: $route.current.params.chatroomId + '/views/text_chat',
    controller: 'textChatCtrl'
  };
}]);
