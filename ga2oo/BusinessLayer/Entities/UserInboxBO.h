//
//  UserInboxBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "UserInbox.h"


@interface UserInboxBO : BaseBusinessObject {

	NSString * Message;
	NSInteger Sender;
	NSInteger Id;
	NSString * IsRead;
	NSInteger CreatedBy;
	NSDate * ModifiedOn;
	NSInteger ModifiedBy;
	NSInteger Threadid;
	NSInteger Receiver;
	NSDate * CreatedOn;
	NSString * Subject;
}

@property (nonatomic, retain) NSString * Message;
@property (nonatomic) NSInteger Sender;
@property (nonatomic) NSInteger Id;
@property (nonatomic, retain) NSString * IsRead;
@property (nonatomic) NSInteger CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic) NSInteger Threadid;
@property (nonatomic) NSInteger Receiver;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Subject;

@end