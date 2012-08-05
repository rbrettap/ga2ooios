//
//  EventListBO.m
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventListBO.h"


@implementation EventListBO

@synthesize user;
@synthesize status;
@synthesize price;
@synthesize name;
@synthesize likecount;
@synthesize is_featured;
@synthesize Eventid;

@synthesize event_start_time;
@synthesize event_start_date;
@synthesize event_expiration;
@synthesize event;
@synthesize date_updated;
@synthesize business;
@synthesize UserID;
@synthesize EventImage;

@synthesize isFav;
@synthesize intOrganisationID;
@synthesize isFavOrganisation;
@synthesize imageEvent;
@synthesize dataImageEvent;
@synthesize arrCategories;
@synthesize arrFriendsAttending;
@synthesize noOfFriends;
@synthesize isEventImage;
@synthesize isMain;
@synthesize geocode;
@synthesize favEventUserId;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize country;

- (id)init {
    self = [super init];
    if (self) {
        arrCategories  = [[NSMutableArray alloc]init];
		arrFriendsAttending =[[NSMutableArray alloc]init];
    }
    return self;
}

-(NSComparisonResult) compare:(EventListBO *)other
{
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"MMM dd, yyyy"];
    
    NSDate *dtOther = [format1 dateFromString:other.event_start_date];
    NSDate *dtSelf = [format1 dateFromString:self.event_start_date];    
    [format1 release];
    return [dtOther compare:dtSelf];
}

-(void)CopyData:(BaseCoreDataObject *)object
{
	EventList *obj_ = (EventList *)object;
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
    //[self setUserID:nil];

	[self setUserID:obj_.UserID];
	[self setEventImage:obj_.EventImage];
    [self setDataImageEvent:obj_.dataImageEvent];
	[self setGeocode:obj_.geocode];
	[self setAddress:obj_.address];
	[self setCity:obj_.city];
	[self setState:obj_.state];
	[self setZipcode:obj_.zipcode];
	[self setCountry:obj_.country];

	
	
	
    if (obj_.dataImageEvent) {
        [self setImageEvent:[UIImage imageWithData:obj_.dataImageEvent]];
     }
}

- (UIImage *)image
{
	return imageEvent;
}

- (void)setImage:(UIImage *)image {
	[imageEvent release];
	imageEvent = image;
}

- (void)downloadImage 
{
	[imageEvent release];
	
   
	if (!self.EventImage || [self.EventImage isEqual:[NSNull null]]) {
		
		imageEvent = [[UIImage imageNamed:@"NoImageEvent.png"] retain];
		return; // No url? Then no Image!
	}
	
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, self.EventImage];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
	
	NSLog(@"Image url%@",str);

	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error){
			imageEvent = [[UIImage alloc]initWithData:imageData];
             // self.dataImageEvent = imageData;
            EventListBL *eventbl = [[EventListBL alloc]init];
            eventbl.delegate = self;
            
            
            if (self) {
              // [eventbl Update:self withSave:YES];
             }
            [eventbl release];

        }
		else
			imageEvent = [UIImage imageNamed:@"NoImageEvent.png"];
		[imageData release];
		
	}
	else
	{
		imageEvent = [UIImage imageNamed:@"NoImageEvent.png"];
	}
  
}



-(void) dealloc
{
	[address release];
	[city release];
	[state release];
	[zipcode release];
	[country release];
	[geocode release];
	[isMain release];
	[arrFriendsAttending release];
	[arrCategories release];
	//[UserID release];
	[user release];
	[status release];
	[price release];
	[name release];
	[likecount release];
	[is_featured release];
 	[event_start_time release];
	[event_start_date release];
	[event_expiration release];
	[event release];
	[date_updated release];
	[business release];
 	[super dealloc];
}

@end
