//
//  AddFavEvent.m
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddFavEvent.h"


@implementation AddFavEvent

@dynamic UserId;
@dynamic UserAddedEventId;
@dynamic EventId;


+(NSString*)TableName
{
    return @"FavoriteEvent";
}

+(NSString*)PrimarykeyColumnName
{
	return @"UserAddedEventId";
}



-(void)CopyData:(BaseBusinessObject *)object
{
	AddFavEventBO *obj_ = (AddFavEventBO *)object;
	[self setUserId:[NSNumber numberWithInt:obj_.UserId]];
	[self setUserAddedEventId:[NSNumber numberWithInt:obj_.UserAddedEventId]];
	[self setEventId:[NSNumber numberWithInt:obj_.EventId]];

}


@end
