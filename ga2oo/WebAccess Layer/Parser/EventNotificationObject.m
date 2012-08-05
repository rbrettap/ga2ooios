//
//  EventNotificationObject.m
//  Ga2oo
//
//  Created by Gopinath PUPPALA on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventNotificationObject.h"


@implementation EventNotificationObject


@synthesize arrNotifications;
@synthesize strUserId;


-(void)dealloc
{
	[arrNotifications release];
	[strUserId release];
	[super dealloc];
	
}

@end
