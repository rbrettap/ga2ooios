//
//  UserLocationBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "UserLocationBO.h"


@implementation UserLocationBO

@synthesize Country;
@synthesize City;
@synthesize IsPrimary;
@synthesize State;
@synthesize UserId;
@synthesize CreatedOn;
@synthesize Zipcode;
@synthesize Address;
@synthesize ModifiedBy;
@synthesize GeoPoint;
@synthesize CreatedBy;
@synthesize ModifiedOn;
@synthesize LocationId;

-(void)CopyData:(BaseCoreDataObject *)object
{
	UserLocation *obj_ = (UserLocation *)object;
	[self setCountry:obj_.Country];
	[self setCity:obj_.City];
	[self setIsPrimary:obj_.IsPrimary];
	[self setState:obj_.State];
	[self setUserId:obj_.UserId];
	[self setCreatedOn:obj_.CreatedOn];
	[self setZipcode:obj_.Zipcode];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setLocationId:obj_.LocationId];
}

-(void)dealloc
{
	[LocationId release];
	[UserId release];
	[Country release];
	[City release];
	[IsPrimary release];
	[State release];
	[CreatedOn release];
	[Zipcode release];
	[Address release];
	[GeoPoint release];
	[ModifiedOn release];
	[super dealloc];
}

@end