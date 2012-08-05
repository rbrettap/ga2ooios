//
//  eventListViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "EventListBO.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "facebookConnectViewController.h"
#import "twitterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EventFriendListBL.h"
#import "FavoriteBusinessBL.h"

@interface eventListViewController : BaseViewController <MFMessageComposeViewControllerDelegate ,MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>{

	IBOutlet UITableView *tblEventList;
	NSMutableArray *arrEvents;
	NSInteger countForArrow;
	EventListBO *objEvent;

	UIView *friendsView;
	UITableView *tblFriends;
	NSMutableArray *arrFriendEmails;
	NSInteger intTagValue;
	NSMutableArray *arrEventFriend;
	NSInteger intActionTag;
	EventFriendListBL *EventFriendLayer;
    FavoriteBusinessBL *UserFavBussLayer;
}
@property (nonatomic, retain) NSMutableArray *arrEvents;
@property (nonatomic, retain) NSMutableArray *arrEventFriend;

-(NSString *)getDateValue:(NSString *)date;
-(void)rempoveFriendsView;
-(void)sendMail:(NSMutableArray *)friends;
-(void)eventFrienDownload;


@end
