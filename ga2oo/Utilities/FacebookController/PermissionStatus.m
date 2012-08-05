//
//  PermissionStatus.m
 
//

#import "PermissionStatus.h"

@implementation PermissionStatus
@synthesize userHasPermission;
@synthesize delegate;

- (PermissionStatus *)initWithUserId:(long long int)uid { 
	self = [super init];
	
	if (self) {
		NSString* fql = [NSString stringWithFormat:
						 @"select publish_stream from permissions where uid == %lld", uid]; 
		NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"]; 
		[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params]; 
		userHasPermission = NO;
	}
	
	return self;
} 

#pragma mark FBRequestDelegate

- (void)request:(FBRequest*)request didLoad:(id)result {
	NSArray *permissions = result;
	NSDictionary *permission = [permissions objectAtIndex:0];
	userHasPermission = [[permission objectForKey:@"publish_stream"] boolValue];
	[delegate statusWasSet:userHasPermission];
}


@end
