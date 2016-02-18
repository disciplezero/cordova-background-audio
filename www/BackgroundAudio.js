var exec = require('cordova/exec');

var BackgroundAudio = {};

BackgroundAudio.setMediaInfo = function(title, artworkUrl, duration, position) {
  exec(function(){}, function(){}, 'BackgroundAudio', 'setMediaInfo', [title, artworkUrl, ''+duration, ''+position]);
};
module.exports = BackgroundAudio;
