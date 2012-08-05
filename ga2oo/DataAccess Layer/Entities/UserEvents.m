// 
//  UserEvents.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserEvents.h"


@implementation UserEvents 

@dynamic UserId;
@dynamic IsAttending;
@dynamic Id;
@dynamic IsPublic;
@dynamic EventId;
@dynamic IsFavorite;
@dynamic ModifiedOn;
@dynamic ModifiedBy;
@dynamic BuyTickets;
@dynamic CreatedOn;
@dynamic CreatedBy;

+(NSString*)TableName
{
    return @"UserEvents";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Id";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserEventsBO *obj_ = (UserEventsBO *)object;
	[self setUserId:[NSNumber numberWithInt:obj_.UserId]];
	[self setIsAttending:obj_.IsAttending];
	[self setId:[NSNumber numberWithInt:obj_.Id]];
	[self setIsPublic:obj_.IsPublic];
	[self setEventId:[NSNumber numberWithInt:obj_.EventId]];
	[self setIsFavorite:obj_.IsFavorite];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setBuyTickets:obj_.BuyTickets];
	[self setCreatedOn:obj_.CreatedOn];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
}

@end
