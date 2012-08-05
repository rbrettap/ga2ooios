// 
//  EventLocation.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventLocation.h"


@implementation EventLocation 

@dynamic City;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic Address2;
@dynamic Id;
@dynamic Latitude;
@dynamic State;
@dynamic CreatedOn;
@dynamic Longitude;
@dynamic EventId;
@dynamic Address;
@dynamic ModifiedBy;
@dynamic GeoPoint;
@dynamic Country;
@dynamic Address1;
@dynamic Geocode;

+(NSString*)TableName
{
    return @"EventLocation";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Id";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventLocationBO *obj_ = (EventLocationBO *)object;
	[self setCity:obj_.City];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setAddress2:obj_.Address2];
	[self setId:[NSNumber numberWithInt:obj_.Id]];
	[self setLatitude:[NSNumber numberWithInt:obj_.Latitude]];
	[self setState:obj_.State];
	[self setCreatedOn:obj_.CreatedOn];
	[self setLongitude:[NSNumber numberWithInt:obj_.Longitude]];
	[self setEventId:[NSNumber numberWithInt:obj_.EventId]];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCountry:obj_.Country];
	[self setAddress1:obj_.Address1];
	[self setGeocode:obj_.Geocode];
}

@end
