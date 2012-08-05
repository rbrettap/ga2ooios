//
//  BusinessTypeBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "BusinessType.h"

@interface BusinessTypeBO : BaseBusinessObject {

	NSDate * ModifiedOn;
	NSInteger CreatedBy;
	NSInteger ModifiedBy;
	NSDate * CreatedOn;
	NSInteger BusinessTypeId;
	//NSString * BusinessType;
}

@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger BusinessTypeId;
//@property (nonatomic, retain) NSString * BusinessType;

@end
