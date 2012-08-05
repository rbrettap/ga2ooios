//
//  EventCategoryBO.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "EventCategory.h"

@interface EventCategoryBO : BaseBusinessObject {

	NSString * maincategoryid;
    NSString * eventId;
        NSString * eventName;
 
 
}

@property(nonatomic,retain)NSString * maincategoryid;
@property(nonatomic,retain)NSString * eventId;
@property(nonatomic,retain)NSString * eventName;


@end
