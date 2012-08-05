//
//  UserAssociationBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "UserAssociation.h"


@interface UserAssociationBO : BaseBusinessObject {

	NSString *UserId;
	NSString *AssociationUserId;

	NSDate * CreatedOn;	
	NSDate * ModifiedOn;	
	NSInteger ModifiedBy;	
	NSString *AssociationId;	
	NSString * AssociationType;	
	NSInteger CreatedBy;	
}
@property (nonatomic,retain)NSString *AssociationUserId;
@property (nonatomic,retain)NSString *UserId;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSString *AssociationId;
@property (nonatomic, retain) NSString * AssociationType;
@property (nonatomic) NSInteger CreatedBy;

@end
