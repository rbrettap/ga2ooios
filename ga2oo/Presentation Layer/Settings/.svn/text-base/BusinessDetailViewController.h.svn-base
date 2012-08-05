//
//  BusinessDetailViewController.h
//  Ga2oo
//
//  Created by WINIT on 27/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellForHomePage.h"
#import "EventObject.h"
#import "EventListBO.h"
#import "EventDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Ga2ooBusinessXML.h"
#import "FavoriteBusinessBL.h"
#import "BusinessListBL.h"


@interface BusinessDetailViewController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,Ga2ooBusinessXML_Delegate> 
{
    
    
    IBOutlet UITableView *tableViewFriend;
	NSInteger countForArrow;
	 Ga2ooBusinessXML *objGa2ooBusiness;
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
    NSString *SelectedBussinesId;
    NSString *SelectedBusinessImageName; 
    NSString *BussinessContact;
	FavoriteBusinessBL *UserFavBussLayer;
	BusinessListBL *BusinessListLayer;
	NSMutableArray *TotalBusinessEvents;

    
}
@property (nonatomic, assign) NSString *SelectedBusinessImageName; 
@property (nonatomic, retain) NSMutableArray *arrEventFriend;
@property (nonatomic, retain)NSMutableArray *arrFriendEvents;
@property (nonatomic, retain)NSMutableArray *arrThisFriendEvents;
@property (nonatomic, assign) NSInteger ForAllUser;
@property (nonatomic, assign) NSString *SelectedBussinesId;
@property (nonatomic, assign) NSString *BussinessContact;
@property (nonatomic, retain) NSMutableArray *TotalBusinessEvents;


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
