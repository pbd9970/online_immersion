app.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
  // $locationProvider.html5Mode(true);
  $routeProvider.
    when('/:chatroomId', {
      controller: 'pageCtrl',
      templateUrl: function(urlParams) {
        return urlParams.chatroomId + "/views/page";
      },
    }).
    otherwise({
      redirectTo: '/'
    });
}]);

