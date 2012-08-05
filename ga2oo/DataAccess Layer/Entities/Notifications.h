//
//  Notifications.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "NotificationsBO.h"

@interface Notifications :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSData * IsRead;
@property (nonatomic, retain) NSNumber * NotificationId;
@property (nonatomic, retain) NSNumber * NotificationFor;
@property (nonatomic, retain) NSNumber * EventId;
@property (nonatomic, retain) NSNumber * Notificationby;
@property (nonatomic, retain) NSString * NotificationText;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSData * NotificationTypeId;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSNumber * CreatedBy;

@end



