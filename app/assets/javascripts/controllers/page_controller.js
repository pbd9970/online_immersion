app.controller('PageCtrl', ['$scope', '$route', '$routeParams', function ($scope, $route, $routeParams) {

  $scope.streamUrl = "online-immersion-stream.herokuapp.com";
  $scope.SIP_Url = "online-immersion-stream.herokuapp.com";
  $scope.startCall = false;
  $scope.chatroom = {
    chatroomId : $routeParams.chatroomId || $route.current.params.chatroomId
  };

  $scope.friend = {
    userName: "Waiting...",
  };

  $scope.textCtrlUserObj;

  $scope.getTextCtrlUserObj = function () {
    if (typeof $scope.textCtrlUserObj !== 'undefined') { return $scope.textCtrlUserObj; }
    $scope.textCtrlUserObj = {};
    $scope.textCtrlUserObj['0'] = 'chatroom';
    $scope.textCtrlUserObj[$scope.user.userId] = 'You';
    return $scope.textCtrlUserObj;
  };

  //$scope.$on('user:join', function (e, data) {
  $scope.$on('init', function (e, data) {
    // check if you are second caller
    for (userId in data) {
      if (userId != $scope.user.userId && userId != '0') {
        $scope.friend.userId = userId;
        $scope.friend.userName = data[userId].userName;
        $scope.startCall = true;
        $scope.friend.callName = $scope.friend.userName + '_' + $scope.friend.userId;
        $scope.$emit('call:init', $scope.friend.callName);
      } 
      data[userId] = data[userId].userName;
    }
    $scope.broadcastTxtCtrlUserObj(data);
  });

  $scope.$on('user:join', function (e, data) {
    if (typeof $scope.friend.userId === 'undefined') {
      $scope.friend.userId = data.userId;
      $scope.friend.userName = data.userName;
    }
    var txtObj = {}
    txtObj[data.userId] = data.userName
    $scope.broadcastTxtCtrlUserObj(txtObj);
  });

  $scope.broadcastTxtCtrlUserObj = function (data) {
    // merge return object with textControllerUserObject
    var txtObj = $scope.getTextCtrlUserObj();
    for (userId in txtObj) {
      data[userId] = txtObj[userId];
    }
    $scope.$broadcast('user:object', data);
  };
}]);
