//
//  BusinessFavEventBO.h
//  Ga2oo
//
//  Created by Suresh on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"

@interface BusinessFavEventBO : BaseBusinessObject 
{
	NSString *useraddedbusinessid;
	NSString *businessid;
	NSString *businessname;
    NSString *date_updated;
}

@property (nonatomic, retain) NSString *useraddedbusinessid;
@property (nonatomic, retain) NSString *businessid;
@property (nonatomic, retain) NSString *businessname;
@property (nonatomic, retain) NSString *date_updated;

@end
