//
//  EventLocationBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "EventLocation.h"

@interface EventLocationBO : BaseBusinessObject {

	NSString * City;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	NSString * Address2;
	NSInteger Id;
	NSInteger Latitude;
	NSString * State;
	NSDate * CreatedOn;
	NSInteger Longitude;
	NSInteger EventId;
	NSString * Address;
	NSInteger ModifiedBy;
	NSString * GeoPoint;
	NSString * Country;
	NSString * Address1;
	NSString * Geocode;
     
}

@property (nonatomic, retain) NSString * City;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * Address2;
@property (nonatomic) NSInteger Id;
@property (nonatomic) NSInteger Latitude;
@property (nonatomic, retain) NSString * State;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger Longitude;
@property (nonatomic) NSInteger EventId;
@property (nonatomic, retain) NSString * Address;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSString * GeoPoint;
@property (nonatomic, retain) NSString * Country;
@property (nonatomic, retain) NSString * Address1;
@property (nonatomic, retain) NSString * Geocode;


@end