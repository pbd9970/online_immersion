var app = angular.module('chatroom', ['ngRoute', 'chatroom.filters', 'chatroom.directives']);

app.config(function ($routeProvider) {

  $routeProvider.when('/users/:userId/chatrooms/:chatroomId',
                      {
                        controller: 'PageController',
                        templateUrl:'/users/:userId/chatrooms/:chatroomId.html'
                      })
                .otherwise({ redirectTo: '/' });
});
