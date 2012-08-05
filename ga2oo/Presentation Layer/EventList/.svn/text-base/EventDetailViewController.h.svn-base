//
//  EventDetailViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsBO.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "facebookConnectViewController.h"
#import "twitterViewController.h"
#import "EventLocationBO.h"
#import "BusinessListBO.h"
#import "EventListBO.h"
#import "EventListBL.h"
#import "EventLocationBL.h"
#import "FriendsBL.h"
#import "EventsBL.h"
#import "EventLocationBL.h"
#import "EventFriendListBL.h"
#import "BusinessListBL.h"
#import "EventImagesBO.h"
#import "EventImagesBL.h"
#import "FavoriteBusinessBL.h"

typedef enum {
	ScrollViewModeNotInitialized,           // view has just been loaded
	ScrollViewModePaging,                   // fully zoomed out, swiping enabled
	ScrollViewModeZooming,                  // zoomed in, panning enabled
} ScrollViewMode;

@interface EventDetailViewController : BaseViewController< UITableViewDelegate, UITableViewDataSource ,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate, MFMessageComposeViewControllerDelegate> {

	NSInteger intEventID;
	NSMutableArray *arrEventAttendingFriends;
	EventsBO *objEvent;
	UIScrollView *scroll_LargeImage;
	UIButton *btnAttending;
	UIButton *btnTicket;
	BOOL isFirst;
	UITableView *tblFriend;
	
	UIButton *btnFavorite;
	UIView *friendsView;
	UITableView *tblFriends;

	NSMutableArray *arrFriendEmails;
	UIScrollView *scrl;
	UIImageView *imgEvent;
	UIActivityIndicatorView *loader;
	UIActivityIndicatorView *loaderBig;
	UIImageView *imgEventBig;
	NSMutableArray *arrLocation;
	
	UIView *viewLargImage;
	NSMutableArray *pageViews;
	NSMutableArray *BigImagePath;
	ScrollViewMode scrollViewMode;
	NSString *index;
	NSUInteger currentPage;
	CGFloat pendingOffsetDelta;
	NSMutableArray *arrEventLocation;
	
    BusinessListBO *selectedBussiness;
    EventImagesBO *selectedEventImageObject;
	EventLocationBO *objEventLoc;
	NSString *strUserID;
	NSMutableArray *arrEventFriend;
	
	UIView *aAnimationView;
	BusinessListBO *objBusiness;
	NSInteger intBusiessID;
	EventListBO *objEventList;
	
	EventsBL *EventLayer;
    EventImagesBL *imagBl;
	EventFriendListBL *EventFriendLayer;
	EventLocationBL *EventLocLayer;
	BusinessListBL *businessLayer;
	UIPageControl *pageControler;
    FavoriteBusinessBL *UserFavBussLayer;
	
//	NSString *strlocation;
    NSInteger IsEventToDelete;
}
@property (nonatomic) NSInteger IsEventToDelete;
@property (nonatomic, retain)NSMutableArray *arrEventAttendingFriends;

@property (nonatomic, retain) EventsBO *objEvent;
@property (nonatomic, retain) UIScrollView *scroll_LargeImage;
@property (nonatomic, retain) NSMutableArray *arrLocation;
@property (nonatomic) NSInteger intEventID;
@property (nonatomic, retain) NSString *strUserID;
@property (nonatomic, retain) NSMutableArray *arrEventFriend;
@property (nonatomic) NSInteger intBusiessID;
@property (nonatomic, retain) EventListBO *objEventList;
@property (nonatomic, retain) EventLocationBO *objEventLoc;

-(void)createInteface;
-(void)removeFriendsView;
-(void)downloadImage:(EventImagesBO *)imageObj;
-(void)getAllFriends;
-(void)DownloadAlltheImages:(NSString *)IndexPosition;
- (void)setPagingMode;
- (void)setZoomingMode;
- (CGSize)pageSize ;
-(void) showLargeImages;
-(void)PostRequest:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag;
@end
