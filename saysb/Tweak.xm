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

	AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
	AVSpeechUtterance *speechutt = [AVSpeechUtterance speechUtteranceWithString:text];
	[speechutt setRate:0.4f];
	[synthesizer speakUtterance:speechutt];
    
	return nil;
}
%end
