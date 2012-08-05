//
//  Ga2ooUserBO.h
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Ga2ooUser.h"

@interface Ga2ooUserBO : BaseBusinessObject
{
    NSString *ga2ooUserId;
    NSString *ga2ooUserName;
    NSString *ga2ooUserEmail;
    NSString *ga2ooUserFirstName;
    NSString *ga2ooUserLastName;
    NSString *ga2ooUserIs_active;
    NSString *ga2ooUserIs_public;
}

@property(nonatomic,retain)NSString *ga2ooUserId;
@property(nonatomic,retain)NSString *ga2ooUserName;
@property(nonatomic,retain)NSString *ga2ooUserEmail;
@property(nonatomic,retain)NSString *ga2ooUserFirstName;
@property(nonatomic,retain)NSString *ga2ooUserLastName;
@property(nonatomic,retain)NSString *ga2ooUserIs_active;
@property(nonatomic,retain)NSString *ga2ooUserIs_public;

@end
