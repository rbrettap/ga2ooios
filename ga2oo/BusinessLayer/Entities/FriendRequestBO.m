//
//  FriendRequestBO.m
//  Ga2oo
//
//  Created by Fahad on 23/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendRequestBO.h"


@implementation FriendRequestBO

@synthesize Result;


-(id)init
{
	self = [super init];
	return self;
}

-(void)dealloc
{
	[Result release];
	Result = nil;
	[super dealloc];
}


@end
