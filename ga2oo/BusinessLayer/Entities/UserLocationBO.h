//
//  UserLocationBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "UserLocation.h"


@interface UserLocationBO : BaseBusinessObject {

	NSString * Country;
	NSString * City;
	NSString * IsPrimary;
	NSString * State;
	NSString *UserId;
	NSDate * CreatedOn;
	NSString * Zipcode;
	NSString * Address;
	NSInteger ModifiedBy;
	NSString * GeoPoint;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	NSString * LocationId;
}

@property (nonatomic, retain) NSString * Country;
@property (nonatomic, retain) NSString * City;
@property (nonatomic, retain) NSString * IsPrimary;
@property (nonatomic, retain) NSString * State;
@property (nonatomic,retain) NSString * UserId;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSString * Address;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSString * GeoPoint;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * LocationId;

@end