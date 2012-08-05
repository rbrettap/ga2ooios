//
//  EventList.h
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface EventList :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * likecount;
@property (nonatomic, retain) NSString * event_start_date;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * is_featured;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * event_expiration;
@property (nonatomic, retain) NSString * date_updated;
@property (nonatomic, retain) NSString * event_start_time;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * business;

@end



