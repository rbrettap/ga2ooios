//
//  BusinessBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Business.h"


@interface BusinessBO : BaseBusinessObject {

	NSInteger CreatedBy;
	NSInteger BusinessTypeId;
	NSDate * ModifiedOn;
	NSString * FaxNumber;
	NSInteger ModifiedBy;
	NSInteger BusinessId;
	NSString * URL;
	NSString * ImageData;
	NSString * ContactEmail;
	NSString * BusinessName;
	NSDate * CreatedOn;
	NSString * SupportEmail;
	NSString * PhoneNumber;
	NSString * Image;
	NSData * IsActive;
	NSString * EIN;
	NSString * External_biz_id;
}
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic) NSInteger BusinessTypeId;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * FaxNumber;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic) NSInteger BusinessId;
@property (nonatomic, retain) NSString * URL;
@property (nonatomic, retain) NSString * ImageData;
@property (nonatomic, retain) NSString * ContactEmail;
@property (nonatomic, retain) NSString * BusinessName;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * SupportEmail;
@property (nonatomic, retain) NSString * PhoneNumber;
@property (nonatomic, retain) NSString * Image;
@property (nonatomic, retain) NSData * IsActive;
@property (nonatomic, retain) NSString * EIN;
@property (nonatomic, retain) NSString * External_biz_id;

@end
