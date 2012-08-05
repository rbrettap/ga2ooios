//
//  EventCategory.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "EventCategoryBO.h"

@interface EventCategory :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * maincategoryid;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * eventId;
 

 
 @end



