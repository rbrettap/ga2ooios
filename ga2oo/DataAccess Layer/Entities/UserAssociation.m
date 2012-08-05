// 
//  UserAssociation.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserAssociation.h"


@implementation UserAssociation 
@dynamic AssociationUserId;
@dynamic UserId;
@dynamic CreatedOn;
@dynamic ModifiedOn;
@dynamic ModifiedBy;
@dynamic AssociationId;
@dynamic AssociationType;
@dynamic CreatedBy;

+(NSString*)TableName
{
    return @"UserAssociation";
}

+(NSString*)PrimarykeyColumnName
{
    return @"AssociationId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserAssociationBO *obj_ = (UserAssociationBO *)object;
	[self setUserId:obj_.UserId];
	[self setAssociationUserId:obj_.AssociationUserId];
 	[self setCreatedOn:obj_.CreatedOn];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setAssociationId:obj_.AssociationId];
	[self setAssociationType:obj_.AssociationType];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
}

@end
