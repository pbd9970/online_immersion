app.controller('textChatCtrl', ['$scope', 'socket', function ($scope, socket) {

  // Connect to Node WebSocket
  socket.connect('http://' + $scope.$parent.streamUrl, "chatroomId="+ $scope.$parent.chatroom.chatroomId );

  // Initial connection with server supplies any messages
  // and any users already on call
  socket.on('init', function (data) {
    $scope.messages = data.messages;
    $scope.$emit('init', data.users);

    socket.emit('user:join', {
      userName : $scope.$parent.user.userName,
      userId : $scope.$parent.user.userId
    });
  });

  // PageCtrl controls users, TextCtrl gets object with userId keys
  socket.on('user:join', function (data) {
    $scope.displayMessage({
      from: '0',
      message: 'User ' + data.userName + ' has joined.'
    });
    $scope.$emit('user:join', data);
  });

  // Initiate chat session after second person joins
  $scope.$on('user:object', function (e, data) {
    $scope.users = data;
  });

  socket.on('send:message', function (message) {
    $scope.displayMessage(message);
  });

  socket.on('user:left', function (data) {
    $scope.displayMessage({
      from: '0',
      message: 'User ' + $scope.users[data.userId] + ' has left.'
    });
    delete $scope.users[data.userId]
    $scope.$emit('session:close')
  });

  // Helper functions
  $scope.displayMessage = function (msg) {
    $scope.messages.push({
      user: $scope.users[msg.from],
      text: msg.message
    });
  };

  $scope.sendMessage = function () {
    var msg = {
      from : $scope.$parent.user.userId,
      message: $scope.message
    };

    socket.emit('send:message', msg);
    $scope.displayMessage(msg);

    $scope.message = '';
  };
}]);
