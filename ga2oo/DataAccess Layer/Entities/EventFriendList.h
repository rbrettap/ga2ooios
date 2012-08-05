//
//  EventFriendList.h
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "EventFriendListBO.h"

@interface EventFriendList :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * UserImage;
@property (nonatomic, retain) NSString * Lastname;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * DeviceId;
@property (nonatomic, retain) NSData * IsCalenderShared;
@property (nonatomic, retain) NSData * IsPublic;
@property (nonatomic, retain) NSData * Invisiblemode;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSDate * Birthday;
@property (nonatomic, retain) NSString * Password;
@property (nonatomic, retain) NSNumber * UserId;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSData * Gender;
@property (nonatomic, retain) NSString * Firstname;
@property (nonatomic, retain) NSData * IsActive;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSNumber * CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;

@end



