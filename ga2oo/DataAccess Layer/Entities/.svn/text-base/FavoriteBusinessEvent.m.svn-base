//
//  FavoriteBusinessEvent.m
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoriteBusinessEvent.h"



@implementation FavoriteBusinessEvent

@dynamic UserId;
@dynamic BusinessId;
@dynamic AddedBusinessId;

+(NSString*)TableName
{
    return @"FavoriteBusinessEvent";
}

+(NSString*)PrimarykeyColumnName
{
	return @"BusinessId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	FavoriteBusinessEventBO *obj_ = (FavoriteBusinessEventBO *)object;
	[self setUserId:[NSNumber numberWithInteger:obj_.UserId]];
	[self setBusinessId:[NSNumber numberWithInteger:obj_.BusinessId]];
	//[self setAddedBusinessId:[NSNumber numberWithInteger:obj_.AddedBusinessId]];
}



@end
