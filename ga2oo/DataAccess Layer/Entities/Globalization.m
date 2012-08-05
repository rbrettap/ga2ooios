// 
//  Globalization.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Globalization.h"


@implementation Globalization 

@dynamic Country;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic Address2;
@dynamic Latitude;
@dynamic State;
@dynamic BusinessId;
@dynamic ID;
@dynamic CreatedOn;
@dynamic Zipcode;
@dynamic Longitude;
@dynamic Address;
@dynamic ModifiedBy;
@dynamic GeoPoint;
@dynamic City;
@dynamic Address1;


+(NSString*)TableName
{
    return @"Globalization";
}

+(NSString*)PrimarykeyColumnName
{
    return @"ID";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	GlobalizationBO *obj_ = (GlobalizationBO *)object;
	[self setCountry:obj_.Country];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setAddress2:obj_.Address2];
	[self setLatitude:[NSNumber numberWithInt:obj_.Latitude]];
	[self setState:obj_.State];
	[self setBusinessId:[NSNumber numberWithInt:obj_.BusinessId]];
	[self setID:[NSNumber numberWithInt:obj_.ID]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setZipcode:obj_.Zipcode];
	[self setLongitude:[NSNumber numberWithInt:obj_.Longitude]];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCity:obj_.City];
	[self setAddress1:obj_.Address1];
}

@end
