//
//  EventObject.m
//  Ga2oo
//
//  Created by win it on 2/10/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import "EventObject.h"


@implementation EventObject
@synthesize intID;
@synthesize strTitle;
@synthesize strDetail;
@synthesize strImage;;
@synthesize strDate;
@synthesize strDate1;
@synthesize strTime;
@synthesize strAddress;
@synthesize strDuration;
@synthesize strRating;
@synthesize strCategory;
@synthesize strZip;
@synthesize strCity;
@synthesize strState;
@synthesize strLongitude;
@synthesize strLatitude;
@synthesize strBuyTickets;
@synthesize intRate;
@synthesize isFav;
@synthesize strOrganization;
@synthesize intOrganisationID;
@synthesize isFavOrganisation;

- (void) dealloc
{
	[strTitle release];
	[strDetail release];
	[strImage release];
	[strDate release];
	[strDate1 release];
	[strTime release];
	[strAddress release];
	[strDuration release];
	[strRating release];
	[strCategory release];
	[strZip release];
	[strCity release];
	[strState release];
	[strLongitude release];
	[strLatitude release];
	[strBuyTickets release];
	[strOrganization release];
	[super dealloc];
}

@end
