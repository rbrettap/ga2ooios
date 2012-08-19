//
//  AuthenticateUserBO.m
//  Ga2oo
//
//  Created by Fakhre Alam on 30/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthenticateUserBO.h"


@implementation AuthenticateUserBO
@synthesize UserId;

-(void)dealloc
{
	[UserId release];
	[UserMessage release];
	[Message release];
	[Code release];
	[super dealloc];
}
@end
