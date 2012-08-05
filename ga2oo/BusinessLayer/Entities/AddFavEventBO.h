//
//  AddFavEventBO.h
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"


@interface AddFavEventBO : BaseBusinessObject 
{
	NSInteger UserId;
	NSInteger UserAddedEventId;
	NSInteger EventId; 
}

@property (nonatomic) NSInteger UserId;
@property (nonatomic) NSInteger UserAddedEventId;
@property (nonatomic) NSInteger EventId;


@end
