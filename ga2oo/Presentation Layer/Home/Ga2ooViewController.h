//
//  Ga2ooViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventListViewController.h"
#import "LoginMapViewController.h"
#import "TableViewCellForHomePage.h"
#import "EventDetailViewController.h"
#import "EventsBL.h"
#import "UserBO.h"
#import "UserLocationBO.h"
#import "UserBL.h"
#import "UserLocationBL.h"
#import "FavoriteBusinessBL.h"
#import "AddFavouriteToBusinessXML.h"
#import "AddFavouriteToBusinessBO.h"
#import "EventListBL.h"
#import "NotificationsBL.h"
#import "EventRecommendateBL.h"

@class BaseViewController;
@class LoginMapViewController;

@interface Ga2ooViewController : BaseViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UserLocationXML_Delegate> {

	IBOutlet UIView *vwHome;
	UIScrollView *scrolHome;
	IBOutlet UIImageView *imgViewProfile;
	UIImagePickerController *imgPickerCon;
	IBOutlet UILabel *lblAddPhoto;
	IBOutlet UIButton *btnProfImage;
	IBOutlet UILabel *lblLocation;
	IBOutlet UIButton *btnAddLocation;
	NSMutableArray *arrFilteredEvents;
	IBOutlet UITextField *searchTextFiled;
	IBOutlet UILabel *lblStartSearching;
	IBOutlet UILabel *lblUpComingEvents;
	
	//adding table
	IBOutlet UITableView *tableViewEv;
	NSIndexPath *selectedCellIndexPath;
	NSMutableArray *arr_TableRowHeight;
	NSInteger intHeight;
	NSIndexPath *selectedCellPrevIndexPath;
	NSInteger countForArrow;
	IBOutlet UILabel *lblName;
	UIView *vwSearch;
	EventListBO *objEvent;
	IBOutlet UITextField *txtSearch;
	IBOutlet UISearchBar *SearchBar;
	UIToolbar *keyboardToolBar;
	UITextField *searchList;
	UITextField *searchLocationList;
	UIToolbar *keyboardToolBar1;
	UIView *friendsView;
	UITableView *tblFriends;
	NSMutableArray *arrFriendEmails;
	IBOutlet UIButton *btnEvents;
	LoginMapViewController *obj_LMV;
	NSInteger intTagValue;
	UIActivityIndicatorView *loader;
	UserBO *objUser;
	NSMutableArray *arrUserLocation;
	UserLocationBO *objUserLoc;
	
	UIImage *imgUser;
	UIImage *imgEvent;
	NSMutableArray *arrEventFriend;
	NSInteger intActionTag;
	UserBL *UserLayer;
	UserLocationBL *UserLocationLayer;
	FavoriteBusinessBL *UserFavBussLayer;
	BOOL backImageViewStatu;
	BOOL isRefreshStatu;
	BOOL isRefresh;
	UIImageView *backImageView;
	UILabel *upTimeLabel;
	UILabel *backLabel;
	UIView *refreshView;
	IBOutlet UIPickerView *picker;
	IBOutlet UIView *pickerView;
	UIToolbar *pickerToolbar;
	NSMutableArray *pickerArray;
	NSInteger intPickerSelected;
    EventListBL *EventsLayer;
    
	IBOutlet UILabel *lblNoOfEvents;
	NotificationsBL *notifyBl;
    EventRecommendateBL *RecomBL;
	UITextField *myTextField;
}
@property (nonatomic, retain) NSMutableArray *arrFilteredEvents;
@property (nonatomic, retain) IBOutlet UITableView *tableViewEv;
@property (nonatomic, retain) NSMutableArray *arrUserLocation;
@property (nonatomic, retain) NSMutableArray *arrEventFriend;
@property(nonatomic , retain) UIImageView *backImageView;
@property(nonatomic,retain)UILabel *upTimeLabel;
@property(nonatomic,retain)	UILabel *backLabel;
@property(nonatomic, retain) IBOutlet UIPickerView *picker;
@property(nonatomic, retain) IBOutlet UIView *pickerView;
@property(nonatomic, retain) UIToolbar *pickerToolbar;
@property(nonatomic, retain) NSMutableArray *pickerArray;
@property(nonatomic) NSInteger intPickerSelected;
@property(nonatomic, retain) UILabel *lblNoOfEvents;

- (void)scrollViewToCenterOfScreen:(UIView *)theView;
-(IBAction) btnChangeImageTouchupInside:(id) sender;
-(void)choosePhoto;
-(void)takePhoto;
-(IBAction) btnFeaturedEventsTouchupInside:(id) sender;
-(IBAction) btnSearcyNearbyTouchupInside:(id) sender;
-(IBAction) btnSearchAllTouchupInside:(id) sender;
-(IBAction) btnAddLocationTouchupInside:(id) sender;
-(void) filterEventsArray;
-(void) removeSearchBarButtons;
-(void) addSearchBarButtons;
-(void) addTableOfEventsUsingArrayofAddedEventsByChecking:(NSMutableArray *) arrAddedEvents;
-(IBAction)eventBtnClicked;
-(IBAction)searchBtnClicked;
-(IBAction)profileBtnClicked;
-(NSString *)getDateValue:(NSString *)date;
-(IBAction)searchBtnTouchUpInside;
-(void)sendMail:(NSMutableArray *)friends;
-(void)rempoveFriendsView;
-(void)popUpFriendListView;
-(void)downloadImage:(NSString *)strImagePath Tag:(NSInteger)tag;
-(void)getAllFriends;
-(void)eventFrienDownload;
-(void)FeaturedEvents;
-(void)ActiveEvents;
//-(BOOL)featuredDateIs:(NSString*)eventStartDate;
//-(void)filterUpComingEvents;
-(void)loadAddFavrXml:(EventListBO*)evnts;
-(void)setUpRefreshView;
-(void) addPickerToolbar;
-(void)loadAddFavrXml:(EventListBO*)evnts forCompany:(BOOL)isCmpnyREvnt;

-(void)showAlerts:(NSString*)strMsg;

@end
