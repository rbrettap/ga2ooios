//
//  EventImagesBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "EventImagesBO.h"


@implementation EventImagesBO

@synthesize eventId;
@synthesize isMain;
@synthesize imageUrl;
@synthesize imgEvent;
@synthesize dataImgEvent;


-(void)CopyData:(BaseCoreDataObject *)object
{
	EventImages *obj_ = (EventImages *)object;
	[self setEventId:obj_.eventId];
	[self setIsMain:obj_.isMain];
	[self setImageUrl:obj_.imageUrl];
    [self setImgEvent:[UIImage imageWithData:obj_.dataImgEvent]];
}


-(void)dealloc
{
    [dataImgEvent release];
	[eventId release];
	[isMain release];
	[imageUrl release];
    	[imgEvent release];
	[super dealloc];
}

@end