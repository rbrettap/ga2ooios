//
//  FavoriteBusinessEventBO.m
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoriteBusinessEventBO.h"
#import "FavoriteBusinessEvent.h"



@implementation FavoriteBusinessEventBO

@synthesize UserId;
@synthesize BusinessId;
@synthesize AddedBusinessId;

-(id)init
{
	self = [super init];
	return self;
}

-(void)CopyData:(BaseCoreDataObject *)object
{
	FavoriteBusinessEvent *favEvnt = (FavoriteBusinessEvent*)object;
	[self setUserId:[favEvnt.UserId integerValue]];
	[self setBusinessId:[favEvnt.BusinessId integerValue]];
	//[self setAddedBusinessId:[favEvnt.AddedBusinessId integerValue]];
	
}


@end
