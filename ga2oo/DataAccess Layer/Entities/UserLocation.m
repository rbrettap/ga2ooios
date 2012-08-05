// 
//  UserLocation.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserLocation.h"


@implementation UserLocation 

@dynamic Country;
@dynamic City;
@dynamic IsPrimary;
@dynamic State;
@dynamic UserId;
@dynamic CreatedOn;
@dynamic Zipcode;
@dynamic Address;
@dynamic ModifiedBy;
@dynamic GeoPoint;
@dynamic CreatedBy;
@dynamic ModifiedOn;
@dynamic LocationId;
+(NSString*)TableName
{
    return @"UserLocation";
}

+(NSString*)PrimarykeyColumnName
{
    return @"LocationId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	UserLocationBO *obj_ = (UserLocationBO *)object;
	[self setCountry:obj_.Country];
	[self setCity:obj_.City];
	[self setIsPrimary:obj_.IsPrimary];
	[self setState:obj_.State];
	[self setUserId:obj_.UserId];
	[self setCreatedOn:obj_.CreatedOn];
	[self setZipcode:obj_.Zipcode];
	[self setAddress:obj_.Address];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setGeoPoint:obj_.GeoPoint];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setLocationId:obj_.LocationId];
}


@end
