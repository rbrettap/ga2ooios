//
//  Events.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "EventsBO.h"

@interface Events :  BaseCoreDataObject  
{
}

 

@property (nonatomic, retain) NSString * EventId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSString * tickets;
@property (nonatomic, retain) NSString * supportemail;
@property (nonatomic, retain) NSString * supportphone;
@property (nonatomic, retain) NSString * event_start_date;
@property (nonatomic, retain) NSString * event_end_date;
@property (nonatomic, retain) NSString * event_start_time;
@property (nonatomic, retain) NSString * event_end_time;
@property (nonatomic, retain) NSString * event_expiration;
@property (nonatomic, retain) NSString * is_featured;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * likecount;
@property (nonatomic, retain) NSString * ga2oometer;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * BusinessId;


@end



