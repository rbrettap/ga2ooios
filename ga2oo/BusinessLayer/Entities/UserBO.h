//
//  tblUserBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "User.h"

@interface UserBO : BaseBusinessObject {

	NSString * Lastname;
	NSString * Email;
	NSString * DeviceId;
	NSString * IsCalenderShared;
	NSString *  UserId;
	NSString * Invisiblemode;
	NSString * Password;
	NSDate * Birthday;
	NSString * Zipcode;
	NSString * Username;
	NSString * IsPublic;
	NSDate * CreatedOn;
	NSString * Gender;
	NSString * Firstname;
	NSString * IsActive;
	NSString * UserImage;
	NSInteger ModifiedBy;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	
	UIImage *imgCover;
	
	NSMutableArray * arrUserAssociations;
	NSMutableArray * arrUserLocations;
};

@property (nonatomic, retain) NSString * Lastname;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * DeviceId;
@property (nonatomic, retain) NSString * IsCalenderShared;
@property (nonatomic,retain) NSString * UserId;
@property (nonatomic, retain) NSString * Invisiblemode;
@property (nonatomic, retain) NSString * Password;
@property (nonatomic, retain) NSDate * Birthday;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSString * IsPublic;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Gender;
@property (nonatomic, retain) NSString * Firstname;
@property (nonatomic, retain) NSString * IsActive;
@property (nonatomic, retain) NSString * UserImage;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) UIImage *imgCover;
@property (nonatomic, retain) NSMutableArray * arrUserAssociations;
@property (nonatomic, retain) NSMutableArray * arrUserLocations;

- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (void)downloadImage;


@end
