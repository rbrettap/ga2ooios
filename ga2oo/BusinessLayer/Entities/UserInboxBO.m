//
//  UserInboxBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserInboxBO.h"


@implementation UserInboxBO

@synthesize Message;
@synthesize Sender;
@synthesize Id;
@synthesize IsRead;
@synthesize CreatedBy;
@synthesize ModifiedOn;
@synthesize ModifiedBy;
@synthesize Threadid;
@synthesize Receiver;
@synthesize CreatedOn;
@synthesize Subject;

-(void)CopyData:(BaseCoreDataObject *)object
{
	UserInbox *obj_ = (UserInbox *)object;
	[self setMessage:obj_.Message];
	[self setSender:[obj_.Sender integerValue]];
	[self setId:[obj_.Id integerValue]];
	[self setIsRead:obj_.IsRead];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setThreadid:[obj_.Threadid integerValue]];
	[self setReceiver:[obj_.Receiver integerValue]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setSubject:obj_.Subject];
}

-(void)dealloc
{
	[Message release];
	[IsRead release];
	[ModifiedOn release];
	[CreatedOn release];
	[Subject release];
	[super dealloc];
}

@end
