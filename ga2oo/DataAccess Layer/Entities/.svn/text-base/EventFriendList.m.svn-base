// 
//  EventFriendList.m
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendList.h"


@implementation EventFriendList 

@dynamic UserImage;
@dynamic Lastname;
@dynamic Email;
@dynamic DeviceId;
@dynamic IsCalenderShared;
@dynamic IsPublic;
@dynamic Invisiblemode;
@dynamic CreatedOn;
@dynamic Birthday;
@dynamic Password;
@dynamic UserId;
@dynamic Username;
@dynamic Zipcode;
@dynamic Gender;
@dynamic Firstname;
@dynamic IsActive;
@dynamic ModifiedBy;
@dynamic CreatedBy;
@dynamic ModifiedOn;

+(NSString*)TableName
{
    return @"EventFriendList";
}

+(NSString*)PrimarykeyColumnName
{
    return @"UserId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventFriendListBO *obj_ = (EventFriendListBO *)object;
	[self setLastname:obj_.Lastname];
	[self setEmail:obj_.Email];
	[self setDeviceId:obj_.DeviceId];
	[self setIsCalenderShared:obj_.IsCalenderShared];
	[self setUserId:[NSNumber numberWithInt:obj_.UserId]];
	[self setInvisiblemode:obj_.Invisiblemode];
	[self setPassword:obj_.Password];
	[self setBirthday:obj_.Birthday];
	[self setZipcode:obj_.Zipcode];
	[self setUsername:obj_.Username];
	[self setIsPublic:obj_.IsPublic];
	[self setCreatedOn:obj_.CreatedOn];
	[self setGender:obj_.Gender];
	[self setFirstname:obj_.Firstname];
	[self setIsActive:obj_.IsActive];
	[self setUserImage:obj_.UserImage];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
}


@end
