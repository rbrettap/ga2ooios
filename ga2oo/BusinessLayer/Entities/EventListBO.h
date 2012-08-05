//
//  EventListBO.h
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "EventList.h"

@interface EventListBO : BaseBusinessObject {

	NSString *user;
	NSString *status;
	NSString *price;
	NSString *name;
	NSString *likecount;
	NSString *is_featured;
	NSString *Eventid;
 	NSString *event_start_time;
	NSString *event_start_date;
	NSString *event_expiration;
	NSString *event;
	NSString *date_updated;
	NSString *business;
 	NSString *UserID;
	NSString *EventImage;
    UIImage *imageEvent;
    NSData *dataImageEvent;
 
    
    NSInteger noOfFriends;
	BOOL isFav;
	NSInteger intOrganisationID;
	BOOL isFavOrganisation;
	NSData *imgData;
    
    NSMutableArray *arrCategories;
	    NSMutableArray *arrFriendsAttending;
	BOOL isEventImage;
	NSString *isMain;
	NSString *favEventUserId;
	NSString *geocode;
    NSString *address;
    NSString *city;
	NSString *state;
	NSString *zipcode;
	NSString *country;
	
}
@property(nonatomic,retain)	NSString *isMain;
@property(nonatomic,readwrite)   NSInteger noOfFriends;
@property(nonatomic,retain) NSString *user;
@property(nonatomic,retain) NSString *status;
@property(nonatomic,retain) NSString *price;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *likecount;
@property(nonatomic,retain) NSString *is_featured;
@property(nonatomic,retain) NSString * Eventid;
//@property(nonatomic,retain) NSString *events;
@property(nonatomic,retain) NSString *event_start_time;
@property(nonatomic,retain) NSString *event_start_date;
@property(nonatomic,retain) NSString *event_expiration;
@property(nonatomic,retain) NSString *event;
@property(nonatomic,retain) NSString *date_updated;
@property(nonatomic,retain) NSString *business;
@property(nonatomic,retain) NSString *UserID;
@property(nonatomic,retain) NSString *EventImage;
@property (nonatomic, retain) UIImage *imageEvent;
@property (nonatomic, retain)NSData *dataImageEvent;

@property (nonatomic, retain)  NSMutableArray *arrCategories;
@property (nonatomic, retain)NSMutableArray *arrFriendsAttending;


@property (nonatomic) BOOL isFav;
@property (nonatomic) NSInteger intOrganisationID;
@property (nonatomic) BOOL isFavOrganisation;
@property (nonatomic)BOOL isEventImage;

@property (nonatomic, retain) NSString *favEventUserId;
@property (nonatomic, retain)	NSString *geocode;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, retain) NSString *country;
- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (void)downloadImage;
-(NSComparisonResult) compare:(EventListBO *)other;

@end
