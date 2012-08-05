// 
//  tblUser.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "User.h"


@implementation User 
 
@dynamic Lastname;
@dynamic Email;
@dynamic DeviceId;
@dynamic IsCalenderShared;
@dynamic UserId;
@dynamic Invisiblemode;
@dynamic Password;
@dynamic Birthday;
@dynamic Zipcode;
@dynamic Username;
@dynamic IsPublic;
@dynamic CreatedOn;
@dynamic Gender;
@dynamic Firstname;
@dynamic IsActive;
@dynamic UserImage;
@dynamic ModifiedBy;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic userImageDate;

+(NSString*)TableName
{
    return @"User";
}

+(NSString*)PrimarykeyColumnName
{
    return @"UserId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserBO *obj_ = (UserBO *)object;
	[self setLastname:obj_.Lastname];
	[self setEmail:obj_.Email];
	[self setDeviceId:obj_.DeviceId];
	[self setIsCalenderShared:obj_.IsCalenderShared];
	[self setUserId:obj_.UserId];
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
	[self setUserImageDate:UIImageJPEGRepresentation(obj_.imgCover, 1.0)];
	
	
}

@end
