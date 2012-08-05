//
//  RegisterObject.m
//  Ga2oo
//
//  Created by Mayank Goyal on 16/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "RegisterObject.h"


@implementation RegisterObject
@synthesize strFirstName;
@synthesize strLastName;
@synthesize strEmail;
@synthesize strUserName;
@synthesize strPaswd;
@synthesize strZip;
@synthesize strGender;
@synthesize strBirthDay;
@synthesize imgImage;
@synthesize strBio;
@synthesize strCate;
@synthesize strLocation;

@synthesize geocode;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize country;

-(void)dealloc
{
    [geocode release];
    [address release];
    [city release];
    [state release];
    [zipcode release];
    [country release];
	[strFirstName release];
	[strLastName release];
	[strEmail release];
	[strUserName release];
	[strPaswd release];
	[strZip release];
	[strGender release];
	[strBirthDay release];
	[imgImage release];
	[strBio release];
	[strCate release];
	[strLocation release];
	[super dealloc];
}

@end
