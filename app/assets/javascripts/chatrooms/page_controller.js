function PageCtrl($scope, socket) {
  $scope.user = {
    id: metaData.userId
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
