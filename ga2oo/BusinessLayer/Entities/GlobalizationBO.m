//
//  GlobalizationBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "GlobalizationBO.h"


@implementation GlobalizationBO

@synthesize Country;
@synthesize CreatedBy;
@synthesize ModifiedOn;
@synthesize Address2;
@synthesize Latitude;
@synthesize State;
@synthesize BusinessId;
@synthesize ID;
@synthesize CreatedOn;
@synthesize Zipcode;
@synthesize Longitude;
@synthesize Address;
@synthesize ModifiedBy;
@synthesize GeoPoint;
@synthesize City;
@synthesize Address1;

-(void)CopyData:(BaseCoreDataObject *)object
{
	Globalization *obj_ = (Globalization *)object;
	[self setCountry:obj_.Country];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setAddress2:obj_.Address2];
	[self setLatitude:[obj_.Latitude integerValue]];
	[self setState:obj_.State];
	[self setBusinessId:[obj_.BusinessId integerValue]];
	[self setID:[obj_.ID integerValue]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setZipcode:obj_.Zipcode];
	[self setLongitude:[obj_.Longitude integerValue]];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCity:obj_.City];
	[self setAddress1:obj_.Address1];
}

-(void)dealloc
{
	[Country release];
	[ModifiedOn release];
	[Address2 release];
	[State release];
	[CreatedOn release];
	[Zipcode release];
	[Address release];
	[GeoPoint release];
	[City release];
	[Address1 release];
	[super dealloc];
}

@end