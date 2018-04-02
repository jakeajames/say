#include <AppSupport/CPDistributedMessagingCenter.h>

int main(int argc, char **argv, char **envp) {
	if (argc < 2) {
		printf("Ayeee, we need something to say\n");
		printf("	%s somethingToSay\n", argv[0]);
		return -1;
	}
	CPDistributedMessagingCenter *messagingCenter;
	messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];

	[messagingCenter sendMessageAndReceiveReplyName:@"whattosay" userInfo:[NSDictionary dictionaryWithObject: [NSString stringWithFormat:@"%s", argv[1]] forKey:@"message"]];

	return 0;
}
