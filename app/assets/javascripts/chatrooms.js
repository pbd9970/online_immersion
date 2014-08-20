// var app = angular.module('chatroom', ['ngRoute']);
// 
// app.config(['$routeProvider', function ($routeProvider) {
// // app.config(function ($routeProvider) {
// 
//   $routeProvider.when('/users/:userId/chatrooms/:chatroomId',
//                       {
//                         controller: 'PageController',
//                         templateUrl:'/views/chatroom.html'
//                       })
//                 .otherwise({ redirectTo: '/' });
// }]);
// 
var app = angular.module('chatroom', ['ngRoute']);

app.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
  // $locationProvider.html5Mode(true);
  $routeProvider.
    when('/:chatroomId', {
      controller: 'PageCtrl',
      templateUrl: function(urlParams) {
        return urlParams.chatroomId + "/view";
      },
    }).
    otherwise({
      redirectTo: '/'
    });
}]);
