//
//  FavoriteBusinessBO.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FavoriteBusinessBO.h"


@implementation FavoriteBusinessBO
@synthesize id;

-(void)CopyData:(BaseCoreDataObject *)object
{
	FavoriteBusiness *obj_ = (FavoriteBusiness *)object;
	[self setId:[obj_.id integerValue]];
}

-(void)dealloc
{
	[super dealloc];
}

@end
