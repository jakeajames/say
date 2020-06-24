#include <AppSupport/CPDistributedMessagingCenter.h>

int main(int argc, char **argv, char **envp) {
	if (argc < 2) {
		printf("Ayeee, we need something to say\n");
		printf("	%s somethingToSay\n", argv[0]);
		return -1;
	}
	CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];
    
    NSMutableArray *args = [NSMutableArray array];
    for (int i = 1; i < argc; i++) {
        [args addObject:[[NSString alloc] initWithUTF8String:argv[i]]];
    }

	[messagingCenter sendMessageAndReceiveReplyName:@"whattosay" userInfo:[NSDictionary dictionaryWithObject:[args componentsJoinedByString:@" "] forKey:@"message"]];

	return 0;
}
