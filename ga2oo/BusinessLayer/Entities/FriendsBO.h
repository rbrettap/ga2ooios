//
//  tblFriendsBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Friends.h"


@interface FriendsBO : BaseBusinessObject {

	NSString *UserId;
  	NSString *FriendId;  
	NSString *addedFriendId;
	NSString *firstName;
	NSString *lastName;
    NSString *imageUrl;  
	NSString *email;
	NSString *geocode;
	NSString *address;
	NSString *city;
	NSString *state;
	NSString *zipcode;
	NSString *country;
    UIImage *friendImage;
    
    BOOL isSelected;
    NSString *is_calendar_shared;
	

}
@property (nonatomic, retain)NSString *UserId;
@property (nonatomic, retain) NSString *FriendId;
@property (nonatomic, retain) NSString *addedFriendId;
@property (nonatomic, retain)NSString *firstName;
@property (nonatomic, retain)NSString *lastName;
@property (nonatomic, retain)NSString *imageUrl;
@property (nonatomic, retain)NSString *email;
@property (nonatomic, retain)NSString *geocode;
@property (nonatomic, retain)NSString *address;
@property (nonatomic, retain)NSString *city;
@property (nonatomic, retain)NSString *state;
@property (nonatomic, retain)NSString *zipcode;
@property (nonatomic, retain)NSString *country;

@property (nonatomic, retain)UIImage *friendImage;
@property (nonatomic, retain) NSString *is_calendar_shared;

@property (nonatomic) BOOL isSelected;
- (UIImage *)image;

@end
