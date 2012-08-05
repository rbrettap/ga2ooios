//
//  EventVideosBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "EventVideosBO.h"


@implementation EventVideosBO

@synthesize ModifiedOn;
@synthesize Video;
@synthesize EventVideoId;
@synthesize EventId;
@synthesize ModifiedBy;
@synthesize CreatedOn;
@synthesize CreatedBy;

-(void)CopyData:(BaseCoreDataObject *)object
{
	EventVideos *obj_ = (EventVideos *)object;
	[self setModifiedOn:obj_.ModifiedOn];
	[self setVideo:obj_.Video];
	[self setEventVideoId:[obj_.EventVideoId integerValue]];
	[self setEventId:[obj_.EventId integerValue]];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
}

-(void)dealloc
{
	[ModifiedOn release];
	[Video release];
	[CreatedOn release];
	[super dealloc];
}

@end

