//
//  FriendsViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "CalenderViewController.h"
#import "UserBO.h"
#import "FriendDetailViewController.h"
#import "FriendsBL.h"

@class BaseViewController;
@interface FriendsViewController : BaseViewController<MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UISearchBarDelegate> {
	
   Ga2ooAppDelegate *appDelegate1;
	IBOutlet UITableView *tblMyFriends;
	
	NSMutableArray *arrMyFriends;
 	BOOL backImageViewStatu;
	BOOL isRefreshStatu;
	BOOL isRefresh;
	UIImageView *backImageView;
	UILabel *upTimeLabel;
	UILabel *backLabel;
	UIView *refreshView;
	FriendsBL *objFrndBL;
	
	
}
@property (nonatomic, retain) NSMutableArray *arrMyFriends;
 @property (nonatomic) BOOL isSetting;
@property(nonatomic , retain) UIImageView *backImageView;
@property(nonatomic,retain)UILabel *upTimeLabel;
@property(nonatomic,retain)	UILabel *backLabel;


-(void) refreshData;
-(void)getAllFriends;
@end
