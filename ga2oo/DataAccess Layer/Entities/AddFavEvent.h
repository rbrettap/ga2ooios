//
//  AddFavEvent.h
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import "AddFavEventBO.h"


@interface AddFavEvent : BaseCoreDataObject
{

}

@property (nonatomic, retain) NSNumber *UserId;
@property (nonatomic, retain) NSNumber *UserAddedEventId;
@property (nonatomic, retain) NSNumber *EventId;

@end
