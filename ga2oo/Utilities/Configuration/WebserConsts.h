//
//  WebserConsts.h
//  Enki
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


#define Ga2ooSERVER @"http://5.ga2ootesting.appspot.com/rest/v1"
#define Ga2ooSERVER5 @"http://5.ga2ootesting.appspot.com/rest/v1"

#define  Ga2ooUserXML [NSString stringWithFormat:@"%@/user/id/",Ga2ooSERVER]  // get user whole data OR register 
#define  Ga2ooUserLocation @"http://5.ga2ootesting.appspot.com/rest/v1/user/savedlocations/id/"
#define  Ga2ooFriendsList [NSString stringWithFormat:@"%@/user/friends/id/",Ga2ooSERVER]
#define  Ga2ooAllUsersList [NSString stringWithFormat:@"%@/user/list",Ga2ooSERVER]

#define  Ga2ooDeleteFriend [NSString stringWithFormat:@"%@/user/friends/id/",Ga2ooSERVER] // delete the friend
#define  Ga2ooAddFriend [NSString stringWithFormat:@"%@/user/friends",Ga2ooSERVER] // delete the friend

#define  Ga2ooEventCategories @"http://5.ga2ootesting.appspot.com/rest/v1/categories/list"
#define  Ga2ooBusineList @"http://5.ga2ootesting.appspot.com/rest/v1/business/list"

#define  Ga2ooNotificationList @"http://5.ga2ootesting.appspot.com/rest/v1/user/notifications/received/id"
#define  Ga2ooEventList @"http://5.ga2ootesting.appspot.com/rest/v1/event/filter"
#define  Ga2ooUserEventList @"http://5.ga2ootesting.appspot.com/rest/v1/user/events/id/"//
#define  Ga2ooNotificationList @"http://5.ga2ootesting.appspot.com/rest/v1/user/notifications/received/id" //////
#define  Ga2ooEvent @"http://5.ga2ootesting.appspot.com/rest/v1/event/id/"
#define  Ga2ooEventLocation @"http://5.ga2ootesting.appspot.com/rest/v1/event/location/id/"
#define  Ga2ooEventFrienList @"http://5.ga2ootesting.appspot.com/rest/v1/user/list/ids/"
#define  Ga2ooFavBusiness @"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/"
#define  Ga200UpdateUSer @"http://5.ga2ootesting.appspot.com/rest/v1/user/update"
#define  Ga200AuthUser @"http://5.ga2ootesting.appspot.com/rest/v1/user/signin/" /// sign in URL
#define  Ga200RegisterUser @"http://5.ga2ootesting.appspot.com/rest/v1/user/register"
#define  Ga200SaveUserLocation @"http://5.ga2ootesting.appspot.com/rest/v1/user/savedlocations/"
#define  Ga200UpdateUserProfileImage @"http://5.ga2ootesting.appspot.com/rest/v1/user/img"

#define  Ga200UpdateUserPrimaryLocation @"http://5.ga2ootesting.appspot.com/rest/v1/user/savedlocations/updateprimary"

#define Ga2ooEventFilterBydate @"http://5.ga2ootesting.appspot.com/rest/v1/event/filter?startdate=%@"
#define Ga2ooEventFilterBycategory @"http://5.ga2ootesting.appspot.com/rest/v1/event/filter?category=%@"
#define Ga2ooEventFilterBydate_Category @"http://5.ga2ootesting.appspot.com/rest/v1/event/filter?category=%@&startdate=%@"
#define Ga2ooEventFilterBycategory_dateBysortOption @"http://5.ga2ootesting.appspot.com/rest/v1/event/filter?category=%@&startdate=%@&sortby=%@"

#define  Ga2oRecommendateList @"http://5.ga2ootesting.appspot.com/rest/v1/user/inbox/received/id"

