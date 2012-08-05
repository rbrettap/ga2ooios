//
//  NotificationsBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Notifications.h"


@interface NotificationsBO : BaseBusinessObject {

	NSData * IsRead;
	NSInteger NotificationId;
	NSInteger NotificationFor;
	NSInteger EventId;
	NSInteger Notificationby;
	NSString * NotificationText;
	NSDate * ModifiedOn;
	NSData * NotificationTypeId;
	NSInteger ModifiedBy;
	NSDate * CreatedOn;
	NSInteger CreatedBy;
}

@property (nonatomic, retain) NSData * IsRead;
@property (nonatomic) NSInteger NotificationId;
@property (nonatomic) NSInteger NotificationFor;
@property (nonatomic) NSInteger EventId;
@property (nonatomic) NSInteger Notificationby;
@property (nonatomic, retain) NSString * NotificationText;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSData * NotificationTypeId;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger CreatedBy;

@end
