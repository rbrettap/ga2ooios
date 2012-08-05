//
//  EventNotifications.h
//  Ga2oo
//
//  Created by Mayank on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import "EventNotificationsBO.h"

@interface EventNotifications : BaseCoreDataObject {

}

@property(nonatomic,retain) NSString *strNotification;
@property(nonatomic,retain) NSString *strNotificationID;
@property(nonatomic,retain) NSString *strNotificationTye;
@property(nonatomic,retain) NSString *strsender;
@property(nonatomic,retain) NSString *strsenderName;
@property(nonatomic,retain) NSString *strfriendRequest;
@property(nonatomic,retain) NSString *strEventId;
@property(nonatomic,retain) NSString *strEventName;
@property(nonatomic,retain) NSString *strText;
@property(nonatomic,retain) NSString *stris_read;
@property(nonatomic,retain) NSString *strdate_Created;

@end
