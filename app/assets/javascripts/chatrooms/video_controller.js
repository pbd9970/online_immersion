app.controller('VideoChatCtrl', ['$scope', '$element', function ($scope, $element) {
  $scope.videoInit = function (realmVal, impiVal, impuVal, passwordVal, friend) {
    SIPml.init(function(e){
      var stack =  new SIPml.Stack({realm: realmVal, impi: impiVal, impu: impuVal, password: passwordVal,
        events_listener: {
          events: 'started',
          listener: function(e){
            var session = stack.newSession('call-audiovideo', {
              video_local : document.getElementById('video-local'),
              video_remote: document.getElementById('video-remote'),
              audio_remote: document.getElementById('audio-remote')
            });
            if ($scope.$parent.startCall) {
              session.call('alice');
                // $scope.$parent.friend.callName);
            }
            $scope.$on('call:init', function () {
              session.call($scope.$parent.friend.callName);
            });
          } 
        }
      });
      stack.start();
    });
  };
  $scope.user = $scope.$parent.user.userName + '_' + $scope.$parent.user.userId;
  $scope.videoInit('http://' + $scope.$parent.SIP_Url, $scope.user, 'sip:' + $scope.user + '@' + $scope.$parent.SIP_Url, 'password')
  //chat.session.call('alice')
}]);
