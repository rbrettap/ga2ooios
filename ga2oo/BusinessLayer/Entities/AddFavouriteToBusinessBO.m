//
//  AddFavouriteToBusinessBO.m
//  Ga2oo
//
//  Created by Suresh on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddFavouriteToBusinessBO.h"


@implementation AddFavouriteToBusinessBO

@synthesize Result;


-(id)init
{
	self = [super init];
	return self;
}

-(void)dealloc
{
	 [Result release];
	 Result = nil;
	 [super dealloc];
}



@end
