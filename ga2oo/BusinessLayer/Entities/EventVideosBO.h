//
//  EventVideosBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "EventVideos.h"


@interface EventVideosBO : BaseBusinessObject {

	NSDate * ModifiedOn;
	NSString * Video;
	NSInteger EventVideoId;
	NSInteger EventId;
	NSInteger ModifiedBy;
	NSDate * CreatedOn;
	NSInteger CreatedBy;
}
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * Video;
@property (nonatomic) NSInteger EventVideoId;
@property (nonatomic) NSInteger EventId;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger CreatedBy;

@end
