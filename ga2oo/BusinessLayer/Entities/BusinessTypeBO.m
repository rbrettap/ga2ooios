//
//  BusinessTypeBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "BusinessTypeBO.h"


@implementation BusinessTypeBO
@synthesize ModifiedOn;
@synthesize CreatedBy;
@synthesize ModifiedBy;
@synthesize CreatedOn;
@synthesize BusinessTypeId;
//@synthesize BusinessType;

-(void)CopyData:(BaseCoreDataObject *)object
{
	BusinessType *obj_ = (BusinessType *)object;
	[self setModifiedOn:obj_.ModifiedOn];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setBusinessTypeId:[obj_.BusinessTypeId integerValue]];
	//[self setBusinessType:obj_.BusinessType];
}

-(void)dealloc
{
	[ModifiedOn release];
	[CreatedOn release];
	//[BusinessType release];
	[super dealloc];
}

@end
