//
//  EventCategoryBO.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventCategoryBO.h"


@implementation EventCategoryBO
 

@synthesize maincategoryid;
@synthesize eventId;
@synthesize eventName;





-(void)CopyData:(BaseCoreDataObject *)object
{
	EventCategory *obj_ = (EventCategory *)object;
 	[self setMaincategoryid:obj_.maincategoryid];
	[self setEventId:obj_.eventId];
    	[self setEventName:obj_.eventName];
     
 }

-(void)dealloc
{
	[maincategoryid release];
	[eventId release];
    [eventName release];
	[super dealloc];
}

@end
