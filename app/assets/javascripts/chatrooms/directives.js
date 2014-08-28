app.directive('chatroom.header', ['version', function(version) {
    return function(scope, elm, attrs) {
      elm.text(version);
    };
  }]);
