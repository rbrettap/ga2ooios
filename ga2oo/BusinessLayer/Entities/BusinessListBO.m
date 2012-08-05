//
//  BusinessListBO.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessListBO.h"


@implementation BusinessListBO

@synthesize zipcode;
@synthesize url;
@synthesize supportemail;
@synthesize state;
@synthesize phone;
 @synthesize is_active;
@synthesize bussinessId;
@synthesize geocode;
@synthesize fax;
@synthesize ein;
@synthesize country;
@synthesize contactname;
@synthesize contactemail;
@synthesize city;
@synthesize businesstype;
@synthesize bizname;
@synthesize address;

-(void)CopyData:(BaseCoreDataObject *)object
{
	BusinessList *obj_ = (BusinessList *)object;
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

-(void) dealloc
{
	[zipcode release];
	[url release];
	[supportemail release];
	[state release];
	[phone release];
 	[is_active release];
    [bussinessId release];
	[geocode release];
	[fax release];
	[ein release];
	[country release];
	[contactname release];
	[contactemail release];
 	[city release];
	[businesstype release];
 	[bizname release];
	[address release];
 	[super dealloc];
}
	
@end
