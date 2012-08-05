//
//  UserNotificationTypesBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserNotificationTypesBO.h"


@implementation UserNotificationTypesBO

@synthesize  NotificationType;
@synthesize  CreatedBy;
@synthesize  ModifiedOn;
@synthesize  CreatedOn;
@synthesize  ModifiedBy;
@synthesize  Id;

-(void)CopyData:(BaseCoreDataObject *)object
{
	UserNotificationTypes *obj_ = (UserNotificationTypes *)object;
	[self setNotificationType:[obj_.NotificationType integerValue]];
	[self setCreatedBy:[obj_.CreatedBy  integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setCreatedOn:obj_.CreatedOn];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setId:[obj_.Id integerValue]];
}

-(void)dealloc
{
	[ModifiedOn release];
	[CreatedOn release];
	[super dealloc];
}

@end