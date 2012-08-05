//
//  tblFriends.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "FriendsBO.h"


@interface Friends :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * UserId;
@property (nonatomic, retain) NSNumber * Status;
@property (nonatomic, retain) NSString * FriendId;
@property (nonatomic, retain) NSString * addedFriendId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain)NSString *email;
@property (nonatomic, retain)NSString *geocode;
@property (nonatomic, retain)NSString *address;
@property (nonatomic, retain)NSString *city;
@property (nonatomic, retain)NSString *state;
@property (nonatomic, retain)NSString *zipcode;
@property (nonatomic, retain)NSString *country;
@property (nonatomic, retain)NSString *is_calendar_shared;
@property (nonatomic, retain)NSData *dataImageFriend;
@end



