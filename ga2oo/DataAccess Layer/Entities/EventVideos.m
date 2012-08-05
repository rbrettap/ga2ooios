// 
//  EventVideos.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventVideos.h"


@implementation EventVideos 

@dynamic ModifiedOn;
@dynamic Video;
@dynamic EventVideoId;
@dynamic EventId;
@dynamic ModifiedBy;
@dynamic CreatedOn;
@dynamic CreatedBy;

+(NSString*)TableName
{
    return @"EventVideos";
}

+(NSString*)PrimarykeyColumnName
{
    return @"EventVideoId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventVideosBO *obj_ = (EventVideosBO *)object;
	[self setModifiedOn:obj_.ModifiedOn];
	[self setVideo:obj_.Video];
	[self setEventVideoId:[NSNumber numberWithInt:obj_.EventVideoId]];
	[self setEventId:[NSNumber numberWithInt:obj_.EventId]];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setCreatedOn:obj_.CreatedOn];
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
}

@end
