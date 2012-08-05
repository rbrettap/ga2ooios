//
//  EventFriendListBO.m
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendListBO.h"


@implementation EventFriendListBO

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

-(void)CopyData:(BaseCoreDataObject *)object
{
	EventFriendList *obj_ = (EventFriendList *)object;
	[self setLastname:obj_.Lastname];
	[self setEmail:obj_.Email];
	[self setDeviceId:obj_.DeviceId];
	[self setIsCalenderShared:obj_.IsCalenderShared];
	[self setUserId:[obj_.UserId integerValue]];
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
	[super dealloc];
}

@end
