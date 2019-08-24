#include <AppSupport/CPDistributedMessagingCenter.h>

int main(int argc, char **argv, char **envp) {
	if (argc < 2)
		return -1;
	CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];
	NSDictionary *userInfo = @{
		@"message": [NSString stringWithFormat:@"%s", argv[1]],
		@"lang": argc == 3 ? [NSString stringWithFormat:@"%s", argv[2]] : @"",
	};
	[messagingCenter sendMessageAndReceiveReplyName:@"whattosay" userInfo:userInfo];
	return 0;
}
