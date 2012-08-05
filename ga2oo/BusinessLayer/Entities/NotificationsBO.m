//
//  NotificationsBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "NotificationsBO.h"


@implementation NotificationsBO

@synthesize IsRead;
@synthesize NotificationId;
@synthesize NotificationFor;
@synthesize EventId;
@synthesize Notificationby;
@synthesize NotificationText;
@synthesize ModifiedOn;
@synthesize NotificationTypeId;
@synthesize ModifiedBy;
@synthesize CreatedOn;
@synthesize CreatedBy;

-(void)CopyData:(BaseCoreDataObject *)object
{
	Notifications *obj_ = (Notifications *)object;
	[self setIsRead:obj_.IsRead];
	[self setNotificationId:[obj_.NotificationId integerValue]];
	[self setNotificationFor:[obj_.NotificationFor integerValue]];
	[self setEventId:[obj_.EventId integerValue]];
	[self setNotificationby:[obj_.Notificationby integerValue]];
	[self setNotificationText:obj_.NotificationText];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setNotificationTypeId:obj_.NotificationTypeId];
	[self setModifiedBy:[obj_.ModifiedBy  integerValue]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
}

-(void)dealloc
{
	[IsRead release];
	[NotificationText release];
	[ModifiedOn release];
	[NotificationTypeId release];
	[CreatedOn release];
	[super dealloc];
}

@end