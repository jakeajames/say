#import <Foundation/Foundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>
#import <AVFoundation/AVFoundation.h>

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];
	[messagingCenter runServerOnCurrentThread];
	[messagingCenter registerForMessageName:@"whattosay" target:self selector:@selector(say:message:)];
}

%new
- (NSDictionary *)say:(NSString *)name message:(NSDictionary *)userInfo {
	NSString *text = [userInfo objectForKey:@"message"];
	NSString *lang = [userInfo objectForKey:@"lang"];

	AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
	AVSpeechUtterance *speechutt = [AVSpeechUtterance speechUtteranceWithString:text];
	if (lang.length) {
		speechutt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:lang];
	}
	[speechutt setRate:0.4f];
	[synthesizer speakUtterance:speechutt];
	[synthesizer release];
	return nil;
}

%end
