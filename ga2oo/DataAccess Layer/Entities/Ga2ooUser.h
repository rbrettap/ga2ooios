//
//  Ga2ooUser.h
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import "Ga2ooUserBO.h"

@interface Ga2ooUser : BaseCoreDataObject {
    
}
@property(nonatomic,retain)NSString *ga2ooUserId;
@property(nonatomic,retain)NSString *ga2ooUserName;
@property(nonatomic,retain)NSString *ga2ooUserEmail;
@property(nonatomic,retain)NSString *ga2ooUserFirstName;
@property(nonatomic,retain)NSString *ga2ooUserLastName;
@property(nonatomic,retain)NSString *ga2ooUserIs_active;
@property(nonatomic,retain)NSString *ga2ooUserIs_public;
@end
