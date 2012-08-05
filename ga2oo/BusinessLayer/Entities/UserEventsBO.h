//
//  UserEventsBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "UserEvents.h"

@interface UserEventsBO : BaseBusinessObject {

	NSInteger UserId;
	NSData * IsAttending;
	NSInteger Id;
	NSData * IsPublic;
	NSInteger EventId;
	NSData * IsFavorite;
	NSDate * ModifiedOn;
	NSInteger ModifiedBy;
	NSData * BuyTickets;
	NSDate * CreatedOn;
	NSInteger CreatedBy;
}

@property (nonatomic) NSInteger UserId;
@property (nonatomic, retain) NSData * IsAttending;
@property (nonatomic) NSInteger Id;
@property (nonatomic, retain) NSData * IsPublic;
@property (nonatomic) NSInteger EventId;
@property (nonatomic, retain) NSData * IsFavorite;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic) NSInteger ModifiedBy;
@property (nonatomic, retain) NSData * BuyTickets;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic) NSInteger CreatedBy;

@end