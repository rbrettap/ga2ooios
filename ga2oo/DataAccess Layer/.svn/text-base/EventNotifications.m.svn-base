//
//  EventNotifications.m
//  Ga2oo
//
//  Created by Mayank on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventNotifications.h"


@implementation EventNotifications

@dynamic strNotification;
@dynamic strNotificationID;
@dynamic strNotificationTye;
@dynamic strsender;
@dynamic strsenderName;
@dynamic strfriendRequest;
@dynamic strEventId;
@dynamic strEventName;
@dynamic strText;
@dynamic stris_read;
@dynamic strdate_Created;

+(NSString*)TableName
{
    return @"Notifications";
}

+(NSString*)PrimarykeyColumnName
{
    return @"strsender";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventNotificationsBO *obj_ = (EventNotificationsBO *)object;
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

@end