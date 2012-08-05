//
//  GlobalizationBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Globalization.h"


@interface GlobalizationBO : BaseBusinessObject {

	NSString * Country;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	NSString * Address2;
	NSInteger Latitude;
	NSString * State;
	NSInteger BusinessId;
	NSInteger ID;
	NSDate * CreatedOn;
	NSString * Zipcode;
	NSInteger Longitude;
	NSString * Address;
	NSInteger ModifiedBy;
	NSString * GeoPoint;
	NSString * City;
	NSString * Address1;
}

@property (nonatomic, retain) NSString * Country;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * Address2;
@property (nonatomic) NSInteger Latitude;
@property (nonatomic, retain) NSString * State;
@property (nonatomic) NSInteger BusinessId;
@property (nonatomic) NSInteger ID;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic) NSInteger Longitude;
@property (nonatomic, retain) NSString * Address;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSString * GeoPoint;
@property (nonatomic, retain) NSString * City;
@property (nonatomic, retain) NSString * Address1;


@end