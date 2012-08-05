// 
//  EventImages.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventImages.h"


@implementation EventImages 

@dynamic eventId;
@dynamic isMain;
@dynamic imageUrl;
@dynamic imgEvent;
@dynamic dataImgEvent;

+(NSString*)TableName
{
    return @"EventImages";
}

+(NSString*)PrimarykeyColumnName
{
     return @"imageUrl";
    //return @"";

}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventImagesBO *obj_ = (EventImagesBO *)object;
	[self setEventId:obj_.eventId];
	[self setIsMain:obj_.isMain];
	[self setImageUrl:obj_.imageUrl];
	//[self setImgEvent:obj_.imgEvent];
    [self setDataImgEvent:obj_.dataImgEvent];

    
 
}

@end
