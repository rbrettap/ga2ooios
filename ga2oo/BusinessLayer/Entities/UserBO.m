//
//  tblUserBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserBO.h"


@implementation UserBO

@synthesize Lastname;
@synthesize Email;
@synthesize DeviceId;
@synthesize IsCalenderShared;
@synthesize UserId;
@synthesize Invisiblemode;
@synthesize Password;
@synthesize Birthday;
@synthesize Zipcode;
@synthesize Username;
@synthesize IsPublic;
@synthesize CreatedOn;
@synthesize Gender;
@synthesize Firstname;
@synthesize IsActive;
@synthesize UserImage;
@synthesize ModifiedBy;
@synthesize CreatedBy;
@synthesize ModifiedOn;
@synthesize imgCover;
@synthesize arrUserAssociations;
@synthesize arrUserLocations;

- (id) init
{
	self = [super init];
	if (self != nil) {
		arrUserAssociations = [[NSMutableArray alloc]init];
		arrUserLocations = [[NSMutableArray alloc]init];
	}
	return self;
}

-(void)CopyData:(BaseCoreDataObject *)object
{
	User *obj_ = (User *)object;
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
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	
	if (obj_.userImageDate) {
        [self setImgCover:[UIImage imageWithData:obj_.userImageDate]];
	}
}


- (UIImage *)image
{
	return imgCover;
}

- (void)setImage:(UIImage *)image {
	[imgCover release];
	imgCover = image;
}

- (void)downloadImage 
{
	[imgCover release];
	
	if (!self.UserImage || [self.UserImage isEqual:[NSNull null]]) {
		
		imgCover = [[UIImage imageNamed:@"icon.png"] retain];
		return; // No url? Then no Image!
	}
	
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, self.UserImage];
	str = [str stringByReplacingOccurrencesOfString:@"#38;" withString:@""];

	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	
	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
			imgCover = [[UIImage alloc]initWithData:imageData];
		else
			imgCover = [UIImage imageNamed:@"icon.png"];
		[imageData release];
		
	}
	else
	{
		imgCover = [UIImage imageNamed:@"icon.png"];
	}
}

-(void)dealloc
{
	[UserId release];
	[Lastname release];
	[Email release];
	[DeviceId release];
	[IsCalenderShared release];
	[Invisiblemode release];
	[Password release];
	[Birthday release];
	[Zipcode release];
	[Username release];
	[IsPublic release];
	[CreatedOn release];
	[Gender release];
	[Firstname release];
	[IsActive release];
	[UserImage release];
	[ModifiedOn release];
	[imgCover release];
 	[arrUserAssociations release];
	[arrUserLocations release];
	[super dealloc];
}

@end
