//
//  UserAssociationBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserAssociationBO.h"


@implementation UserAssociationBO
@synthesize AssociationUserId;
@synthesize UserId;
@synthesize CreatedOn;
@synthesize ModifiedOn;
@synthesize ModifiedBy;
@synthesize AssociationId;
@synthesize AssociationType;
@synthesize CreatedBy;

-(void)CopyData:(BaseCoreDataObject *)object
{
	UserAssociation *obj_ = (UserAssociation *)object;
	[self setUserId:obj_.UserId];
	[self setAssociationUserId:obj_.AssociationUserId];

	[self setCreatedOn:obj_.CreatedOn];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setAssociationId:obj_.AssociationId];
	[self setAssociationType:obj_.AssociationType];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
}

-(void)dealloc
{
	[AssociationUserId release];
	[UserId release];
	[AssociationId release];
	[CreatedOn release];
	[ModifiedOn release];
	[AssociationType release];
	[super dealloc];
}

@end