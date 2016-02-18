var exec = require('cordova/exec');

var BackgroundAudio = {};

BackgroundAudio.setMediaInfo = function(title, artworkUrl) {
  exec(function(){}, function(){}, 'BackgroundAudio', 'setMediaInfo', [title, artworkUrl]);
};
module.exports = BackgroundAudio;
