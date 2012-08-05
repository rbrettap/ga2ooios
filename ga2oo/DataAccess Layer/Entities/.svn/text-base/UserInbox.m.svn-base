// 
//  UserInbox.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserInbox.h"


@implementation UserInbox 

@dynamic Message;
@dynamic Sender;
@dynamic Id;
@dynamic IsRead;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic ModifiedBy;
@dynamic Threadid;
@dynamic Receiver;
@dynamic CreatedOn;
@dynamic Subject;

+(NSString*)TableName
{
    return @"UserInbox";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Id";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserInboxBO *obj_ = (UserInboxBO *)object;
	[self setMessage:obj_.Message];
	[self setSender:[NSNumber numberWithInt:obj_.Sender]];
	[self setId:[NSNumber numberWithInt:obj_.Id]];
	[self setIsRead:obj_.IsRead];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setThreadid:[NSNumber numberWithInt:obj_.Threadid]];
	[self setReceiver:[NSNumber numberWithInt:obj_.Receiver]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setSubject:obj_.Subject];
}

@end
