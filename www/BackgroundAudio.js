var exec = require('cordova/exec');

var BackgroundAudio = {};

BackgroundAudio.setMediaInfo = function(title, artworkUrl) {
  exec(function(){}, function(){}, 'BackgroundAudio', 'setMediaInfo', []);
};
module.exports = BackgroundAudio;
