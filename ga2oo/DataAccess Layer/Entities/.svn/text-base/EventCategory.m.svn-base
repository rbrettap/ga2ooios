// 
//  EventCategory.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventCategory.h"


@implementation EventCategory 

@dynamic maincategoryid;
@dynamic eventId;
@dynamic eventName;

+(NSString*)TableName
{
    return @"EventCategory";
}

+(NSString*)PrimarykeyColumnName
{
    return @"eventName";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventCategoryBO *obj_ = (EventCategoryBO *)object;
	[self setMaincategoryid:obj_.maincategoryid];
 	[self setEventId:obj_.eventId];
     	[self setEventName:obj_.eventName];
    
 
}


@end
