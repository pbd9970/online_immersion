app.directive('chatroomHeader', ['$scope', function(version) {
    return function(scope, elm, attrs) {
      elm.text(version);
    };
  }]);
