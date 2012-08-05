// 
//  UpdateProfile.m
//  Ga2oo
//
//  Created by Mayank goyal on 30/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UpdateProfile.h"


@implementation UpdateProfile 

@dynamic Result;

+(NSString*)TableName
{
    return @"UpdateProfile";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Result";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UpdateProfileBO *obj_ = (UpdateProfileBO *)object;
	[self setResult:[NSNumber numberWithInt:obj_.Result]];
}

@end
