#include <stdlib.h>
#import <Foundation/Foundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>

void printUsage() {
	printf("\nUsage: say [message]\n");
	printf("Usage: say [-m] [message] [-l] [lang]\n");
	printf("\nExample: say Hello\n");
	printf("Example: say \"Hello World\"\n");
	printf("Example: say -m Hello -l en-us\n");
	printf("Example: say -m \"Hello World\" -l ja-jp\n");
	printf("\nOptions:\n");
	printf("\t-h    Displays this help.\n");
	printf("\t-m    The message to say, with quotes if there are multile words.\n");
	printf("\t-l    The voice language for Siri to say, as language culture name. For example, en-us or ja-jp.\n");
}

int main(int argc, char **argv, char **envp) {
	if (argc < 2) {
		printUsage();
		exit(EXIT_FAILURE);
	}
	NSString *message = nil;
	NSString *lang = nil;
	if (argc == 2) {
		if (strcmp(argv[1], "-h") == 0) {
			printUsage();
			exit(EXIT_SUCCESS);
		}
		message = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:argv[1]]];
	} else {
		int opt;
		while ((opt = getopt(argc, argv, "m:l:h")) != -1) {
			switch (opt) {
				case 'm':
					message = [NSString stringWithFormat:@"%@", [NSString stringWithUTF8String:strdup(optarg)]];
					break;
				case 'l':
					lang = [NSString stringWithFormat:@"%s", strdup(optarg)];
					break;
				case 'h':
					printUsage();
					exit(EXIT_SUCCESS);
				default:
					printUsage();
					exit(EXIT_FAILURE);
			}
		}
	}
	if (message == nil) {
		printf("Please specify the message to say in quotes.\n");
		exit(EXIT_FAILURE);
	}
	CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.jakeashacks.saycenter"];
	NSDictionary *userInfo = @{
		@"message": message,
		@"lang": lang ?: @"",
	};
	[messagingCenter sendMessageAndReceiveReplyName:@"whattosay" userInfo:userInfo];
	return 0;
}
