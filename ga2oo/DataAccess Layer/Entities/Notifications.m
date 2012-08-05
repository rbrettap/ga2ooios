// 
//  Notifications.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Notifications.h"


@implementation Notifications 

@dynamic IsRead;
@dynamic NotificationId;
@dynamic NotificationFor;
@dynamic EventId;
@dynamic Notificationby;
@dynamic NotificationText;
@dynamic ModifiedOn;
@dynamic NotificationTypeId;
@dynamic ModifiedBy;
@dynamic CreatedOn;
@dynamic CreatedBy;

+(NSString*)TableName
{
    return @"Notifications";
}

+(NSString*)PrimarykeyColumnName
{
    return @"NotificationId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	NotificationsBO *obj_ = (NotificationsBO *)object;
	//[self setIsRead:obj_.IsRead];
//	[self setNotificationId:[NSNumber numberWithInt:obj_.NotificationId]];
//	[self setNotificationFor:[NSNumber numberWithInt:obj_.NotificationFor]];
//	[self setEventId:[NSNumber numberWithInt:obj_.EventId]];
//	[self setNotificationby:[NSNumber numberWithInt:obj_.Notificationby]];
//	[self setNotificationText:obj_.NotificationText];
//	[self setModifiedOn:obj_.ModifiedOn];
//	[self setNotificationTypeId:obj_.NotificationTypeId];
//	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
//	[self setCreatedOn:obj_.CreatedOn];
//	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
}

@end
