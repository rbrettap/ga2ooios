//
//  UserInbox.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "UserInboxBO.h"


@interface UserInbox :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * Message;
@property (nonatomic, retain) NSNumber * Sender;
@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSString * IsRead;
@property (nonatomic, retain) NSNumber * CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSNumber * Threadid;
@property (nonatomic, retain) NSNumber * Receiver;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Subject;

@end



