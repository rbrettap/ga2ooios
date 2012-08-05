//
//  UserNotificationTypesBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "UserNotificationTypes.h"


@interface UserNotificationTypesBO : BaseBusinessObject {

	NSInteger NotificationType;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	NSDate * CreatedOn;
	NSInteger ModifiedBy;
	NSInteger Id;
}

@property (nonatomic) NSInteger NotificationType;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic) NSInteger Id;

@end
