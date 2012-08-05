// 
//  Events.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Events.h"


@implementation Events 

@dynamic EventId;
@dynamic name;
@dynamic Description;
@dynamic tickets;
@dynamic supportemail;
@dynamic supportphone;
@dynamic event_start_date;
@dynamic event_end_date;
@dynamic event_start_time;
@dynamic event_end_time;
@dynamic event_expiration;
@dynamic is_featured;
@dynamic price;
@dynamic likecount;
@dynamic ga2oometer;
@dynamic status;
@dynamic BusinessId;

 


+(NSString*)TableName
{
    return @"Events";
}

+(NSString*)PrimarykeyColumnName
{
    return @"EventId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventsBO *obj_ = (EventsBO *)object;
	[self setBusinessId:obj_.BusinessId];
	[self setEventId:obj_.EventId];
	[self setName:obj_.name];
	[self setDescription:obj_.Description];
	[self setTickets:obj_.tickets];
	[self setSupportemail:obj_.supportemail];
	[self setSupportphone:obj_.supportphone];
	[self setEvent_start_date:obj_.event_start_date];
	[self setEvent_start_time:obj_.event_start_time];
	[self setEvent_end_date:obj_.event_end_date];
	[self setEvent_end_time:obj_.event_end_time];
	[self setEvent_expiration:obj_.event_expiration];
	[self setIs_featured:obj_.is_featured];
	[self setPrice:obj_.price];
	[self setLikecount:obj_.likecount];
	[self setPrice:obj_.price];
	[self setGa2oometer:obj_.ga2oometer];
	[self setStatus:obj_.status];
	[self setBusinessId:obj_.BusinessId];
 
}

@end
