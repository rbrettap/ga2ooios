// 
//  FavoriteBusiness.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FavoriteBusiness.h"


@implementation FavoriteBusiness 

@dynamic id;

+(NSString*)TableName
{
    return @"FavoriteBusiness";
}

+(NSString*)PrimarykeyColumnName
{
    return @"id";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	FavoriteBusinessBO *obj_ = (FavoriteBusinessBO *)object;
	[self setId:[NSNumber numberWithInt:obj_.id]];
}

@end
