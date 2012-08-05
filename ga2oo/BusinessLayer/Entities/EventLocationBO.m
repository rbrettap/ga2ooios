//
//  EventLocationBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "EventLocationBO.h"


@implementation EventLocationBO

@synthesize City;
@synthesize CreatedBy;
@synthesize ModifiedOn;
@synthesize Address2;
@synthesize Id;
@synthesize Latitude;
@synthesize State;
@synthesize CreatedOn;
@synthesize Longitude;
@synthesize EventId;
@synthesize Address;
@synthesize ModifiedBy;
@synthesize GeoPoint;
@synthesize Country;
@synthesize Address1;
@synthesize Geocode;

-(void)CopyData:(BaseCoreDataObject *)object
{
	EventLocation *obj_ = (EventLocation *)object;
	[self setCity:obj_.City];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setAddress2:obj_.Address2];
	[self setId:[obj_.Id integerValue]];
	[self setLatitude:[obj_.Latitude integerValue]];
	[self setState:obj_.State];
	[self setCreatedOn:obj_.CreatedOn];
	[self setLongitude:[obj_.Longitude integerValue]];
	[self setEventId:[obj_.EventId integerValue]];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCountry:obj_.Country];
	[self setAddress1:obj_.Address1];
	[self setGeocode:obj_.Geocode];
}

-(void)dealloc
{
	[Geocode release];
	[City release];
	[ModifiedOn release];
	[Address2 release];
	[State release];
	[CreatedOn release];
	[Address release];
	[GeoPoint release];
	[Country release];
	[Address1 release];
	[super dealloc];	
}
@end