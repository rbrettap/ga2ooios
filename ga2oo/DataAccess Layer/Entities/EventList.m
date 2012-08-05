// 
//  EventList.m
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventList.h"


@implementation EventList 

@dynamic likecount;
@dynamic event_start_date;
@dynamic status;
@dynamic Eventid;
@dynamic is_featured;
@dynamic price;
@dynamic event_expiration;
@dynamic date_updated;
@dynamic event_start_time;
@dynamic name;
@dynamic business;
@dynamic UserID;
@dynamic EventImage;
@dynamic dataImageEvent;
@dynamic geocode;
@dynamic address;
@dynamic city;
@dynamic state;
@dynamic zipcode;
@dynamic country;

+(NSString*)TableName
{
    return @"EventList";
}

+(NSString*)PrimarykeyColumnName
{
    return @"Eventid";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventListBO *obj_ = (EventListBO *)object;
	[self setLikecount:obj_.likecount];
	[self setEvent_start_date:obj_.event_start_date];
	[self setStatus:obj_.status];
	[self setEventid:obj_.Eventid];
	[self setIs_featured:obj_.is_featured];
	[self setPrice:obj_.price];
	[self setEvent_expiration:obj_.event_expiration];
	[self setDate_updated:obj_.date_updated];
	[self setEvent_start_time:obj_.event_start_time];
	[self setName:obj_.name];
	[self setBusiness:obj_.business];
	[self setUserID:obj_.UserID];
	[self setEventImage:obj_.EventImage];
	[self setGeocode:obj_.geocode];
	[self setAddress:obj_.address];
	[self setCity:obj_.city];
	[self setState:obj_.state];
	[self setZipcode:obj_.zipcode];
	[self setCountry:obj_.country];

   // [self setDataImageEvent:obj_.dataImageEvent];
      [self setDataImageEvent:UIImageJPEGRepresentation(obj_.imageEvent, 1.0)];

    
    /*
     
    NSString *str = [NSString stringWithFormat:@"%@%@",Ga2ooimageURL, self.EventImage];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    
	NSURL *url = [NSURL URLWithString:str];
    NSError *error = nil;

	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
            [self setDataImageEvent:imageData];
		 
    }
 */
            
}

@end
