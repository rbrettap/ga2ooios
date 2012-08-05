//
//  Ga2ooUserBO.m
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ga2ooUserBO.h"


@implementation Ga2ooUserBO
@synthesize ga2ooUserId;
@synthesize ga2ooUserName;
@synthesize ga2ooUserLastName;
@synthesize ga2ooUserEmail;
@synthesize ga2ooUserFirstName;
@synthesize ga2ooUserIs_active;
@synthesize ga2ooUserIs_public;

-(void)CopyData:(BaseCoreDataObject *)object
{
	Ga2ooUser *obj_ = (Ga2ooUser *)object;
	[self setGa2ooUserId:obj_.ga2ooUserId];
	[self setGa2ooUserName:obj_.ga2ooUserName];
	[self setGa2ooUserEmail:obj_.ga2ooUserEmail ];
	[self setGa2ooUserFirstName:obj_.ga2ooUserFirstName];
	[self setGa2ooUserLastName:obj_.ga2ooUserLastName];
	[self setGa2ooUserIs_active:obj_.ga2ooUserIs_active];
    [self setGa2ooUserIs_public:obj_.ga2ooUserIs_public];
    
    
}

-(void)dealloc
{
    [ga2ooUserId release];
    [ga2ooUserName release];
    [ga2ooUserLastName release];  
    [ga2ooUserEmail release];
    [ga2ooUserFirstName release];
    [ga2ooUserIs_active release];
    [ga2ooUserIs_public release];
	[super dealloc];
}


@end








