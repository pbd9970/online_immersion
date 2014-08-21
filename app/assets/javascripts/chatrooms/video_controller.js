app.controller('VideoChatCtrl', ['$scope', 'socket', function ($scope, socket) {
  socket.connect('http://' + $scope.$parent.streamUrl + '/video', {})
  var callSession;
  $scope.videoInit = function (realmVal, impiVal, impuVal, passwordVal, friend) {
    SIPml.init(function(e){
      var stack =  new SIPml.Stack({realm: realmVal, impi: impiVal, impu: impuVal, password: passwordVal,
        events_listener: {
          events: 'started',
          listener: function(e){
            if (e.type == 'started') {
              if ($scope.$parent.startCall) {
                callSession = stack.newSession('call-audiovideo', {
                  video_local : document.getElementById('video-local'),
                  video_remote: document.getElementById('video-remote'),
                  audio_remote: document.getElementById('audio-remote')
                });
                callSession.call($scope.$parent.friend.callName);
              } else {
                stack.newSession('register', {
                  expires: 200,
                  events_listener: {
                    events: '*',
                    listener: function(e) {
                      if (e.type == 'i_new_call') {
                        e.newSession.accept();
                      }
                    }
                  }
                });
              }
              $scope.$on('call:init', function (e, data) {
                callSession.call(data);
              });
            }
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
