//
//  Ga2ooUser.m
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ga2ooUser.h"


@implementation Ga2ooUser


@dynamic ga2ooUserId;
@dynamic ga2ooUserName;
 
@dynamic ga2ooUserEmail;
@dynamic ga2ooUserFirstName;
@dynamic ga2ooUserLastName;
@dynamic ga2ooUserIs_active;
@dynamic ga2ooUserIs_public;

+(NSString*)TableName
{
    return @"Ga2ooUsers";
}

+(NSString*)PrimarykeyColumnName
{
    return @"ga2ooUserId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	Ga2ooUserBO *obj_ = (Ga2ooUserBO *)object;
	[self setGa2ooUserId:obj_.ga2ooUserId];
	[self setGa2ooUserName:obj_.ga2ooUserName];
	[self setGa2ooUserEmail:obj_.ga2ooUserEmail ];
	[self setGa2ooUserFirstName:obj_.ga2ooUserFirstName];
	[self setGa2ooUserLastName:obj_.ga2ooUserLastName];
	[self setGa2ooUserIs_active:obj_.ga2ooUserIs_active];
    [self setGa2ooUserIs_public:obj_.ga2ooUserIs_public];
    
    
}

@end








