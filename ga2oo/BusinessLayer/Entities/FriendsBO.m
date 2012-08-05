//
//  tblFriendsBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "FriendsBO.h"


@implementation FriendsBO

@synthesize UserId;
 @synthesize FriendId;
@synthesize addedFriendId;
@synthesize firstName;
@synthesize lastName;
@synthesize friendImage;
@synthesize imageUrl;
@synthesize email;
@synthesize geocode;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize country;
@synthesize isSelected;
@synthesize is_calendar_shared;


-(void)CopyData:(BaseCoreDataObject *)object
{
	Friends *obj_ = (Friends *)object;
	[self setUserId:obj_.UserId];
 	[self setFriendId:obj_.FriendId];
	[self setAddedFriendId:obj_.addedFriendId];
	[self setFirstName:obj_.firstName];
	[self setLastName:obj_.lastName];
	[self setImageUrl:obj_.imageUrl];
	[self setEmail:obj_.email];
	[self setGeocode:obj_.geocode];
	[self setAddress:obj_.address];
	[self setCity:obj_.city];
	[self setState:obj_.state];	
	[self setCountry:obj_.country];
 	[self setZipcode:obj_.zipcode];
    [self setIs_calendar_shared:obj_.is_calendar_shared];
    if (obj_.dataImageFriend) {
        [self setFriendImage:[UIImage imageWithData:obj_.dataImageFriend]];
    }
}

- (UIImage *)image
{
	return friendImage;
}

- (void)setImage:(UIImage *)image {
	[friendImage release];
	friendImage = image;
}

- (void)downloadImage 
{
	[friendImage release];
	
     
	if (!self.imageUrl || [self.imageUrl isEqual:[NSNull null]]) {
		
		friendImage = [[UIImage imageNamed:@"icon.png"] retain];
		return; // No url? Then no Image!
	}
	
	NSError *error = nil;
	NSString *str = [[[NSString alloc] initWithFormat:@"%@%@", Ga2ooimageURL, self.imageUrl] autorelease];
	str = [str stringByReplacingOccurrencesOfString:@"#38;" withString:@""];
    
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	
	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error){
			friendImage = [[UIImage alloc]initWithData:imageData];
            FriendsBL *friendbl = [[FriendsBL alloc]init];
            friendbl.delegate = self;
            //[friendbl Update:self withSave:YES];
            [friendbl release];
        }
		else
			friendImage = [UIImage imageNamed:@"icon.png"];
		[imageData release];
		
	}
	else
	{
		friendImage = [UIImage imageNamed:@"icon.png"];
	}
    
        
 }

-(void)dealloc
{
    //[imageURL release];
	[super dealloc];
}

@end