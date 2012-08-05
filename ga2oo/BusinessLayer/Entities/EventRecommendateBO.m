//
//  EventRecommendateBO.m
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventRecommendateBO.h"



@implementation EventRecommendateBO

@synthesize strfromid;
@synthesize strfromname;
@synthesize strthread_id;
@synthesize strsubject;
@synthesize strmessage;
@synthesize stris_read;
@synthesize strgaeventid;
@synthesize strgaeventname;
@synthesize strdate_Created;



-(void)CopyData:(BaseCoreDataObject *)object
{
	EventRecommendateBO *obj_ = (EventRecommendateBO *)object;
	[self setStrfromid:obj_.strfromid]; 
    [self setStrfromname:obj_.strfromname];
    [self setStrthread_id:obj_.strthread_id];
	[self setStrsubject:obj_.strsubject];
	[self setStrmessage:obj_.strmessage];
	[self setStris_read:obj_.stris_read];
	[self setStrgaeventid:obj_.strgaeventid];
	[self setStrgaeventname:obj_.strgaeventname];
	[self setStrdate_Created:obj_.strdate_Created];

}


-(void)dealloc
{
    [strfromid release];
	[strfromname release];
	[strthread_id release];
	[strsubject release];
	[strmessage release];
	[stris_read release];
	[strgaeventid release];
	[strgaeventname release];
	[strdate_Created release];
	[super dealloc];
}


@end
