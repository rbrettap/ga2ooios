// 
//  tblFriends.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Friends.h"


@implementation Friends 

@dynamic UserId;
 @dynamic FriendId;
@dynamic addedFriendId;
@dynamic firstName;
@dynamic lastName;
 @dynamic imageUrl;
@dynamic email;
@dynamic geocode;
@dynamic address;
@dynamic city;
@dynamic state;
@dynamic zipcode;
@dynamic country;
@dynamic dataImageFriend;
@dynamic is_calendar_shared;



+(NSString*)TableName
{
    return @"Friends";
}

+(NSString*)PrimarykeyColumnName
{
    return @"FriendId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	FriendsBO *obj_ = (FriendsBO *)object;
	[self setUserId:obj_.UserId];
 	[self setFirstName:obj_.firstName];
 	[self setLastName:obj_.lastName];
	[self setFriendId:obj_.FriendId];
	[self setAddedFriendId:obj_.addedFriendId];
	[self setImageUrl:obj_.imageUrl];
	[self setEmail:obj_.email];
	[self setGeocode:obj_.geocode];
	[self setAddress:obj_.address];
	[self setCity:obj_.city];
	[self setState:obj_.state];	
	[self setCountry:obj_.country];
 	[self setZipcode:obj_.zipcode];
    [self setIs_calendar_shared:obj_.is_calendar_shared];
    [self setDataImageFriend:UIImageJPEGRepresentation(obj_.friendImage, 1.0)];

	

}

@end
