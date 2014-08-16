var videoInit = function (realmVal, impiVal, impuVal, passwordVal, friend) {
  var videoChat = {}
  SIPml.init(function(e){
    var stack =  new SIPml.Stack({
      realm: realmVal,
      impi: impiVal,
      impu: impuVal,
      password: passwordVal,
      events_listener: {
        events: 'started',
        listener: function(e){
          videoChat.session = stack.newSession('call-audiovideo', {
            video_local : document.getElementById('video-local' ),
            video_remote: document.getElementById('video-remote'),
            audio_remote: document.getElementById('audio-remote')
          });
          if (friend) {
            videoChat.session.call(friend);
          } else {
            videoChat;
          }
        } 
      }
    });
    stack.start();
  });
  return videoChat;
};
videoChat = videoInit('example.org', 'bob', 'sip:bob@example.org', 'mysecret')
//videoChat.session.call('alice')
