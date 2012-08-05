//
//  UserEventsBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserEventsBO.h"


@implementation UserEventsBO

@synthesize UserId;
@synthesize IsAttending;
@synthesize Id;
@synthesize IsPublic;
@synthesize EventId;
@synthesize IsFavorite;
@synthesize ModifiedOn;
@synthesize ModifiedBy;
@synthesize BuyTickets;
@synthesize CreatedOn;
@synthesize CreatedBy;

-(void)CopyData:(BaseCoreDataObject *)object
{
	UserEvents *obj_ = (UserEvents *)object;
	[self setUserId:[obj_.UserId integerValue]];
	[self setIsAttending:obj_.IsAttending];
	[self setId:[obj_.Id integerValue]];
	[self setIsPublic:obj_.IsPublic];
	[self setEventId:[obj_.EventId integerValue]];
	[self setIsFavorite:obj_.IsFavorite];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setBuyTickets:obj_.BuyTickets];
	[self setCreatedOn:obj_.CreatedOn];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
}

-(void)dealloc
{
	[IsAttending release];
	[IsPublic release];
	[IsFavorite release];
	[ModifiedOn release];
	[BuyTickets release];
	[CreatedOn release];
	[super dealloc];
}

@end