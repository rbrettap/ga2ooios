//
//  EventsBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "EventsBO.h"
#import "GlobalConstant.h"

@implementation EventsBO

@synthesize EventId;
@synthesize name;
@synthesize Description;
@synthesize tickets;
@synthesize supportemail;
@synthesize supportphone;
@synthesize event_start_date;
@synthesize event_end_date;
@synthesize event_start_time;
@synthesize event_end_time;
@synthesize event_expiration;
@synthesize is_featured;
@synthesize price;
@synthesize likecount;
@synthesize ga2oometer;
@synthesize status;
@synthesize BusinessId;
@synthesize arrEventImages;

///
@synthesize strGeocode;
@synthesize strAddress;
@synthesize strcity;
@synthesize strState;
@synthesize strZipcode;
@synthesize strCountry;


- (id)init {
    self = [super init];
    if (self) {
        arrEventImages = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)CopyData:(BaseCoreDataObject *)object
{
	Events *obj_ = (Events *)object;
	
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


- (UIImage *)image
{
	return imgCover;
}

- (void)setImage:(UIImage *)image {
	[imgCover release];
	imgCover = image;
}
/*
- (void)downloadImage 
{
	[imgCover release];
	
	if (!self.EventImage || [self.EventImage isEqual:[NSNull null]]) {
		
		imgCover = [[UIImage imageNamed:@"icon.png"] retain];
		return; // No url? Then no Image!
	}
	
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, self.EventImage];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
			imgCover = [[UIImage alloc]initWithData:imageData];
		else
			imgCover = [UIImage imageNamed:@"icon.png"];
		[imageData release];
		
	}
	else
	{
		imgCover = [UIImage imageNamed:@"icon.png"];
	}
}
*/

-(void)dealloc
{
 	[strGeocode release];
	[strAddress release];
	[strcity release];
	[strState release];
	[strZipcode release];
	[strCountry release];
	
    [arrEventImages release];
	[super dealloc];
}

@end