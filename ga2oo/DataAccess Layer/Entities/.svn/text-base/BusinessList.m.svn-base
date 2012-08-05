// 
//  BusinessList.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessList.h"


@implementation BusinessList 

@dynamic zipcode;
@dynamic url;
@dynamic supportemail;
@dynamic state;
@dynamic phone;
@dynamic is_active;
@dynamic bussinessId;
@dynamic geocode;
@dynamic fax;
@dynamic ein;
@dynamic country;
@dynamic contactname;
@dynamic contactemail;
@dynamic city;
@dynamic businesstype;
@dynamic bizname;
@dynamic address;

+(NSString*)TableName
{
    return @"BusinessList";
}

+(NSString*)PrimarykeyColumnName
{
    return @"bussinessId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	BusinessListBO *obj_ = (BusinessListBO *)object;
    
    [self setZipcode:obj_.zipcode];
	[self setUrl:obj_.url];
	[self setSupportemail:obj_.supportemail];
    [self setState:obj_.state];
	[self setPhone:obj_.phone];
	[self setIs_active:obj_.is_active];
    [self setBussinessId:obj_.bussinessId];
    [self setGeocode:obj_.geocode];
	[self setFax:obj_.fax];
	[self setEin:obj_.ein];
	[self setCountry:obj_.country];
	[self setContactname:obj_.contactname];
	[self setContactemail:obj_.contactemail];
    [self setCity:obj_.city];
	[self setBusinesstype:obj_.businesstype];
	[self setBizname:obj_.bizname];
    [self setAddress:obj_.address];
  
}


@end
