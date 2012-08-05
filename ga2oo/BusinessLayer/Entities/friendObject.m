//
//  friendObject.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "friendObject.h"


@implementation friendObject
@synthesize strUserID;
@synthesize strFName;
@synthesize strLName;
@synthesize strEmail;
@synthesize strUName;
@synthesize strPawd;
@synthesize strZip;
@synthesize strGender;
@synthesize strLong;
@synthesize strLat;
@synthesize strBirthDay;
@synthesize strImage;
@synthesize strAdd;
@synthesize strFullName;



-(void)dealloc
{
	[strUserID release];
	[strFName release];
	[strLName release];
	[strEmail release];
	[strUName release];
	[strPawd release];
	[strZip release];
	[strGender release];
	[strLong release];
	[strLat release];
	[strBirthDay release ];
	[strImage release];
	[strAdd release];
	[strFullName release];
	[super dealloc];
	
}

@end
