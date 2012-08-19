//
//  WebserConsts.h
//  Richard Brett
//
//  Created by WINIT on 22/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  dateFormatXML @"d/M/yyyy"

#define  dateFormatXMLEvent @"yyyy-MM-dd"

// Image path for users http://3.ga2ootesting.appspot.com/rest/v1/user/

#define  tblEvents  @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/Events.xml"
#define  tblBusinessType @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblBusinessType.xml"
#define  tblBusiness @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblBusiness.xml"
#define  tblGlobalization @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblGlobalization.xml"
#define  tblEventCategory @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblEventCategory.xml"
#define  tblEventLocation @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblEventLocation.xml"
#define  tblCategory @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblCategory.xml"
#define  tblEventImages @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblEventImages.xml"
#define  tblEventVideos @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblEventVideos.xml"
#define  tblUser @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUser.xml"
#define  tblUserInbox @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUserInbox.xml"
#define  tblNotifications @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblNotifications.xml"
#define  tblUserNotificationTypes @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUserNotificationTypes.xml"
#define  tblFriendss @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblFriends.xml"
#define  tblUserEvents @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUserEvents.xml"      // User events
#define  tblUserLocation @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUserLocation.xml"
#define  tblUserAssociation @"http://dev.winitsoftware.com/mobile/releases/Ga2oo/tblUserAssociation.xml"

#define  Ga2ooDateFormatXML @"yyyy-MM-dd"


#define Ga2ooSERVER @"http://api.ga2oo.com/rest/v2"
#define Ga2ooSERVER5 @"http://api.ga2oo.com/rest/v2"

#define  Ga2ooUserXML [NSString stringWithFormat:@"%@/user/id/",Ga2ooSERVER]  // get user whole data OR register 
#define  Ga2ooUserLocation @"http://api.ga2oo.com/rest/v2/user/savedlocations/id/"
#define  Ga2ooFriendsList [NSString stringWithFormat:@"%@/user/friends/id/",Ga2ooSERVER]
#define  Ga2ooAllUsersList [NSString stringWithFormat:@"%@/user/list",Ga2ooSERVER]

#define  Ga2ooDeleteFriend [NSString stringWithFormat:@"%@/user/friends/id/",Ga2ooSERVER] // delete the friend
#define  Ga2ooAddFriend [NSString stringWithFormat:@"%@/user/friends",Ga2ooSERVER] // delete the friend

#define  Ga2ooEventCategories @"http://api.ga2oo.com/rest/v2/categories/list"
#define  Ga2ooBusineList @"http://api.ga2oo.com/rest/v2/business/list"

#define  Ga2ooNotificationList @"http://api.ga2oo.com/rest/v2/user/notifications/received/id"
#define  Ga2ooEventList @"http://api.ga2oo.com/rest/v2/event/filter"
#define  Ga2ooUserEventList @"http://api.ga2oo.com/rest/v2/user/events/id/"//
#define  Ga2ooNotificationList @"http://api.ga2oo.com/rest/v2/user/notifications/received/id" //////
#define  Ga2ooEvent @"http://api.ga2oo.com/rest/v2/event/id/"
#define  Ga2ooEventLocation @"http://api.ga2oo.com/rest/v2/event/location/id/"
#define  Ga2ooEventFrienList @"http://api.ga2oo.com/rest/v2/user/list/ids/"
#define  Ga2ooFavBusiness @"http://api.ga2oo.com/rest/v2/user/businesses/id/"
#define  Ga200UpdateUSer @"http://api.ga2oo.com/rest/v2/user/update"
#define  Ga200AuthUser @"http://api.ga2oo.com/rest/v2/user/signin/" /// sign in URL
#define  Ga200RegisterUser @"http://api.ga2oo.com/rest/v2/user/register"
#define  Ga200SaveUserLocation @"http://api.ga2oo.com/rest/v2/user/savedlocations/"
#define  Ga200UpdateUserProfileImage @"http://api.ga2oo.com/rest/v2/user/img"

#define  Ga200UpdateUserPrimaryLocation @"http://api.ga2oo.com/rest/v2/user/savedlocations/updateprimary"

#define Ga2ooEventFilterBydate @"http://api.ga2oo.com/rest/v2/event/filter?startdate=%@"
#define Ga2ooEventFilterBycategory @"http://api.ga2oo.com/rest/v2/event/filter?category=%@"
#define Ga2ooEventFilterBydate_Category @"http://api.ga2oo.com/rest/v2/event/filter?category=%@&startdate=%@"
#define Ga2ooEventFilterBycategory_dateBysortOption @"http://api.ga2oo.com/rest/v2/event/filter?category=%@&startdate=%@&sortby=%@"

#define  Ga2oRecommendateList @"http://api.ga2oo.com/rest/v2/inbox/received/id"

