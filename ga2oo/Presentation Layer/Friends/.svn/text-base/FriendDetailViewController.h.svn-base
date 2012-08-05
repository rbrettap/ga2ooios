//
//  FriendDetailViewController.h
//  Ga2oo
//
//  Created by winit on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsBO.h"
#import "TableViewCellForHomePage.h"
#import "EventObject.h"
#import "EventListBO.h"
#import "EventDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FavoriteBusinessBL.h"
@class EventFriendListBL;

@interface FriendDetailViewController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate> {
	
	FriendsBO *objFriend;
	IBOutlet UITableView *tableViewFriend;
	NSInteger countForArrow;
	
	IBOutlet UILabel *lblTitlee;
	IBOutlet UIImageView *imgViewImage;
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblAddress;
    IBOutlet UIButton *SendMessage;
    IBOutlet UIButton *SeePelandar;
	
	EventListBO *objEvent;
	UIView *friendsView;
	UITableView *tblFriends;
    
	NSMutableArray *arrFriendEmails;
    NSMutableArray *arrEventFriend;
        NSMutableArray *arrFriendEvents;
    NSMutableArray *arrThisFriendEvents;


	NSInteger intTagValue;
	UIActivityIndicatorView *loader;
	NSInteger intActionTag;
    NSInteger ForAllUser;
    FavoriteBusinessBL *UserFavBussLayer;
    EventFriendListBL *EventFriendLayer;
}
@property (nonatomic, retain) FriendsBO *objFriend;
@property (nonatomic, retain) NSMutableArray *arrEventFriend;
@property (nonatomic, retain)NSMutableArray *arrFriendEvents;
@property (nonatomic, retain)NSMutableArray *arrThisFriendEvents;
@property (nonatomic, assign) NSInteger ForAllUser;


-(void) addTopBar;
-(IBAction)backButtonPressed;
-(IBAction) MsgTouchUpInside:(id) sender;
-(IBAction) CalendarTouchUpInside:(id) sender;
-(void)removeFriendsView;
-(void)popUpFriendListView;
-(void)downloadFriendImage;
-(void)eventFrienDownload;
-(void)getFriendsEvents;


@end
