//
//  AddFavEventBO.m
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddFavEventBO.h"
#import "AddFavEvent.h"


@implementation AddFavEventBO

@synthesize UserId;
@synthesize UserAddedEventId;
@synthesize EventId; 

-(id)init
{
	self = [super init];
	return self;
}

-(void)CopyData:(BaseCoreDataObject *)object
{
	    AddFavEvent *favEvnt = (AddFavEvent*)object;
	    [self setUserId:[favEvnt.UserId integerValue]];
		[self setUserAddedEventId:[favEvnt.UserAddedEventId integerValue]];
	    [self setEventId:[favEvnt.EventId integerValue]];

}

@end
