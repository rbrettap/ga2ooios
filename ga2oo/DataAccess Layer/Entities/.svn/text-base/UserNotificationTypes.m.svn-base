// 
//  UserNotificationTypes.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserNotificationTypes.h"


@implementation UserNotificationTypes 

@dynamic NotificationType;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic CreatedOn;
@dynamic ModifiedBy;
@dynamic Id;

+(NSString*)TableName
{
    return @"UserNotificationTypes";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Id";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserNotificationTypesBO *obj_ = (UserNotificationTypesBO *)object;
	[self setNotificationType:[NSNumber numberWithInt:obj_.NotificationType]];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setCreatedOn:obj_.CreatedOn];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setId:[NSNumber numberWithInt:obj_.Id]];
}

@end
