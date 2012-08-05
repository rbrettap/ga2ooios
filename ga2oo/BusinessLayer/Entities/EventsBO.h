//
//  EventsBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Events.h"


@interface EventsBO : BaseBusinessObject {

    NSString * EventId;
    NSString *name;
    NSString *Description;
    NSString *tickets;
    NSString *supportemail;
    NSString *supportphone;
    NSString *event_start_date;
    NSString *event_end_date;
    NSString *event_start_time;
    NSString *event_end_time;
    NSString * event_expiration;
    NSString *is_featured;
    NSString *price;
    NSString *likecount;
    NSString *ga2oometer;
    NSString *status;
    NSString *BusinessId;
    
    NSMutableArray *arrEventImages;

    	
	BOOL isFav;
	NSInteger intOrganisationID;
	BOOL isFavOrganisation;
	
	UIImage *imgCover;
 	NSString *strGeocode;
	NSString *strAddress;
	NSString *strcity;
	NSString *strState;
	NSString *strZipcode;
	NSString *strCountry;
	
}

 
@property (nonatomic, retain)NSString * EventId;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *Description;
@property (nonatomic, retain)NSString *tickets;
@property (nonatomic, retain)NSString *supportemail;
@property (nonatomic, retain)NSString *supportphone;
@property (nonatomic, retain)NSString *event_start_date;
@property (nonatomic, retain)NSString *event_end_date;
@property (nonatomic, retain)NSString *event_start_time;
@property (nonatomic, retain)NSString *event_end_time;
@property (nonatomic, retain)NSString * event_expiration;
@property (nonatomic, retain)NSString *is_featured;
@property (nonatomic, retain)NSString *price;
@property (nonatomic, retain)NSString *likecount;
@property (nonatomic, retain)NSString *ga2oometer;
@property (nonatomic, retain)NSString *status;
@property (nonatomic, retain)NSString *BusinessId;
@property (nonatomic, retain)NSMutableArray *arrEventImages;

@property (nonatomic) BOOL isFav;
@property (nonatomic) NSInteger intOrganisationID;
@property (nonatomic) BOOL isFavOrganisation;

@property(nonatomic,retain) NSString *strGeocode;
@property(nonatomic,retain) NSString *strAddress;
@property(nonatomic,retain) NSString *strcity;
@property(nonatomic,retain) NSString *strState;
@property(nonatomic,retain) NSString *strZipcode;
@property(nonatomic,retain) NSString *strCountry;

 
- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (void)downloadImage;

@end