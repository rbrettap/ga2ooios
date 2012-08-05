//
//  EventList.h
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseBusinessObject.h"
#import "EventListBO.h"
#import <Foundation/Foundation.h>

@interface EventList :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * likecount;
@property (nonatomic, retain) NSString * event_start_date;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * Eventid;
@property (nonatomic, retain) NSString * is_featured;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * event_expiration;
@property (nonatomic, retain) NSString * date_updated;
@property (nonatomic, retain) NSString * event_start_time;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * business;
@property (nonatomic, retain) NSString * UserID;
@property (nonatomic, retain) NSString *EventImage;
@property (nonatomic, retain) NSData *dataImageEvent;
@property (nonatomic, retain) NSString *geocode;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, retain) NSString *country;





@end



