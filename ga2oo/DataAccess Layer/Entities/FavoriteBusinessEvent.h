//
//  FavoriteBusinessEvent.h
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "FavoriteBusinessEventBO.h"
 

@interface FavoriteBusinessEvent : BaseCoreDataObject 
{

}

@property (nonatomic, retain) 	NSNumber *UserId;
@property (nonatomic, retain) 	NSNumber *BusinessId;
@property (nonatomic, retain) 	NSNumber *AddedBusinessId;

@end
