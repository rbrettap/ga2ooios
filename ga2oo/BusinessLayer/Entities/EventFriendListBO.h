//
//  EventFriendListBO.h
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BaseBusinessObject.h"
#import "EventFriendList.h"

@interface EventFriendListBO : BaseBusinessObject {

	NSString * Lastname;
	NSString * Email;
	NSString * DeviceId;
	NSData * IsCalenderShared;
	NSInteger UserId;
	NSData * Invisiblemode;
	NSString * Password;
	NSDate * Birthday;
	NSString * Zipcode;
	NSString * Username;
	NSData * IsPublic;
	NSDate * CreatedOn;
	NSData * Gender;
	NSString * Firstname;
	NSData * IsActive;
	NSString * UserImage;
	NSInteger ModifiedBy;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	
	UIImage *imgCover;
}

@property (nonatomic, retain) NSString * Lastname;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * DeviceId;
@property (nonatomic, retain) NSData * IsCalenderShared;
@property (nonatomic) NSInteger UserId;
@property (nonatomic, retain) NSData * Invisiblemode;
@property (nonatomic, retain) NSString * Password;
@property (nonatomic, retain) NSDate * Birthday;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSData * IsPublic;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSData * Gender;
@property (nonatomic, retain) NSString * Firstname;
@property (nonatomic, retain) NSData * IsActive;
@property (nonatomic, retain) NSString * UserImage;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) UIImage *imgCover;

- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (void)downloadImage;

@end
