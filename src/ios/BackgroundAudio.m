#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface BackgroundAudio : CDVPlugin
{}
@end

@implementation BackgroundAudio

- (void)pluginInitialize {
	// initializations go here.
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	BOOL ok;
	NSError *setCategoryError = nil;
	ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
	if (!ok) {
		NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
	}
}

- (void)setMediaInfo:(CDVInvokedUrlCommand*)command {
  NSString* title = [command argumentAtIndex:0];
  NSString* artworkUrl = [command argumentAtIndex:1];
  NSString* duration = [command argumentAtIndex:2];
  NSString* position = [command argumentAtIndex:3];

  // Run in the background since we're doing a network load.
  [self.commandDelegate runInBackground:^{
    // Get a UIImage from the url. // TODO: We could pass in an image, like a datauri.
    UIImage *albumArtImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:artworkUrl]]];
    MPMediaItemArtwork* albumArt = [[MPMediaItemArtwork alloc] initWithImage:albumArtImage];

    NSDictionary *currentlyPlayingTrackInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
        title,
        albumArt,
        duration,
        position,
        nil] 
      forKeys:[NSArray arrayWithObjects:
        MPMediaItemPropertyTitle,
        MPMediaItemPropertyArtwork,
        MPMediaItemPropertyPlaybackDuration,
        MPNowPlayingInfoPropertyElapsedPlaybackTime,
        nil]];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = currentlyPlayingTrackInfo;
  }];
}

@end
