#include <AppSupport/CPDistributedMessagingCenter.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
%orig;

    CPDistributedMessagingCenter * 
    messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];
		[messagingCenter runServerOnCurrentThread];


		[messagingCenter registerForMessageName:@"whattosay" target:self selector:@selector(say:message:)];

}
%new
- (NSDictionary *)say:(NSString *)name message:(NSDictionary *)userInfo {
	NSString *text = [userInfo objectForKey:@"message"];
	
/*	UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Welcome"
	        message:[NSString stringWithFormat:@"%@", userInfo]
	        delegate:self
	        cancelButtonTitle:@"Testing"
	        otherButtonTitles:nil];
	[alert1 show];
	[alert1 release];*/

	AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
	AVSpeechUtterance *speechutt = [AVSpeechUtterance speechUtteranceWithString:text];
	[speechutt setRate:0.3f];
	speechutt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
	[synthesizer speakUtterance:speechutt];
    
	return nil;
}
%end