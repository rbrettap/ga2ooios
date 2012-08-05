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
@synthesize Response;

-(void)dealloc
{
	[UserId release];
	[Response release];
	[super dealloc];
}
@end
