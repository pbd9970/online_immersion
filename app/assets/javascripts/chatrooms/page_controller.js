function PageCtrl($scope, socket) {

  $scope.friend = {
    name: "Waiting..."
  }

  $scope.sendMessage = function () {
    socket.emit('send:message', {
      message: $scope.message
    });

    $scope.messages.push({
      user: $scope.name,
      text: $scope.message
    }) ;

    $scope.message = '';
  };
};
