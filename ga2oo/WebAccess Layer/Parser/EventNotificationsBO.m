//
//  EventNotificationsBO.m
//  Ga2oo
//
//  Created by Gopinath PUPPALA on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventNotificationsBO.h"


@implementation EventNotificationsBO



@synthesize strNotification;
@synthesize strNotificationID;
@synthesize strNotificationTye;
@synthesize strsender;
@synthesize strsenderName;
@synthesize strfriendRequest;
@synthesize strEventId;
@synthesize strEventName;
@synthesize strText;
@synthesize stris_read;
@synthesize strdate_Created;






-(void)CopyData:(BaseCoreDataObject *)object
{
	EventNotifications *obj_ = (EventNotifications *)object;
	[self setStrNotification:obj_.strNotification]; 
    [self setStrNotificationID:obj_.strNotificationID];
	[self setStrNotificationTye:obj_.strNotificationTye];
	[self setStrsender:obj_.strsender];
	[self setStrsenderName:obj_.strsenderName];
	[self setStrfriendRequest:obj_.strfriendRequest];
	[self setStrEventId:obj_.strEventId];
	[self setStrEventName:obj_.strEventName];
	[self setStrText:obj_.strText];
	[self setStris_read:obj_.stris_read];
	[self setStrdate_Created:obj_.strdate_Created];
}

-(void)dealloc
{
	[strNotification release];
	[strNotificationID release];
	[strNotificationTye release];
	[strsender release];
	[strsenderName release];
	[strfriendRequest release];
	[strEventId release];
	[strEventName release];
	[strText release];
	[stris_read release];
	[strdate_Created release];
	
	
	
	
	
	
	
	
	[super dealloc];
	
}

@end
