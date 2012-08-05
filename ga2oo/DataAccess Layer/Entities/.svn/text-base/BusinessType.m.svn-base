// 
//  BusinessType.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessType.h"


@implementation BusinessType 

@dynamic ModifiedOn;
@dynamic CreatedBy;
@dynamic ModifiedBy;
@dynamic CreatedOn;
@dynamic BusinessTypeId;
//@dynamic BusinessType;

+(NSString*)TableName
{
    return @"BusinessType";
}

+(NSString*)PrimarykeyColumnName
{
    return @"BusinessTypeId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	BusinessTypeBO *obj_ = (BusinessTypeBO *)object;
	[self setModifiedOn:obj_.ModifiedOn];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setBusinessTypeId:[NSNumber numberWithInt:obj_.BusinessTypeId]];
	//[self setBusinessType:obj_.BusinessType];
}

@end
