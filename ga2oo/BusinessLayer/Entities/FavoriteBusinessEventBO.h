//
//  FavoriteBusinessEventBO.h
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"


@interface FavoriteBusinessEventBO : BaseBusinessObject
{
	NSInteger UserId;
	NSInteger BusinessId;
	NSInteger AddedBusinessId;
}

@property (nonatomic, assign) 	NSInteger UserId;
@property (nonatomic, assign) 	NSInteger BusinessId;
@property (nonatomic, assign) 	NSInteger AddedBusinessId;

@end
