//
//  UserFriendCalenderViewController.h
//  Ga2oo
//
//  Created by win it on 2/10/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalenderView.h"
#import "TableviewEvent.h"
#import "EventListBO.h"
#import "UserBO.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "facebookConnectViewController.h"
#import "twitterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EventImagesBL.h"
#import "FavoriteBusinessBL.h"


@interface UserFriendCalenderViewController : BaseViewController<MFMessageComposeViewControllerDelegate , UITextFieldDelegate ,UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate,CalenderEventsDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {
	
	CalenderView *view1,*view2;
	NSInteger currentWeekDay,currentDayRunning,todayConstant,currentFirstDay,currentMonth,currentYear,currentLastDay,currentDayConstant,currentMonthConstant,currentYearConstant;
	NSDate *currentDate;	
	IBOutlet UILabel *monthLabel2;
	IBOutlet UIView *calHeaderView2;
	NSString *BackBtnName;
	IBOutlet UITableView *tableViewEvent;
	IBOutlet UIView *viewEvent;
	NSIndexPath *selectedCellIndexPath;
	NSMutableArray *arr_TableRowHeight;
	int HREF;
	NSMutableArray *arrHREF;
	BOOL isMonthFirstTime;
	UIButton *btnFilter1;
	UIButton *btnFilter2;
	UIToolbar *toolBar;
	NSMutableArray *arr_picker;
	NSMutableArray *arr_filter1;
	NSMutableArray *arr_filter2;
	NSInteger countForArrow;
	NSIndexPath *selectedCellPrevIndexPath;
	
	IBOutlet UIScrollView *scr_Day;
	NSMutableArray *arr_Events;
	UIView *vwCalender;
	IBOutlet UIView *vwList;
	IBOutlet UIScrollView *scrl_btns;
	UITableView *tbl_Events;
	NSMutableArray *arr_Buttons;
	NSMutableArray *arr_Images;
 	UIButton *btn_scrl;
 	EventListBO *obj_Event;
	UserBO *obj_Friend;
	EventListBO *objEvent;
	NSMutableArray *arrListingEvents;
	BOOL searching;
	UIPickerView *picker_walking_hits;
	UIToolbar *keyboardToolBar;
	NSMutableArray *arr_Walk;
	NSMutableArray *arr_Hits;
	int selected_Picker;
	IBOutlet UILabel *lbl_Walk;
	IBOutlet UILabel *lbl_Hits;
	UIDatePicker *datePicker;
	NSDateFormatter *dateForm;
	UISearchBar *search;
	IBOutlet UIView *vwSearch;
	NSMutableArray *arrCalernderEvents;
	IBOutlet UILabel *lbl_Month;
	IBOutlet UILabel *lbl_Date;
	
	UITextField *searchList;
	UITextField *searchLocationList;
	UIToolbar *keyboardToolBar1;
	
	UIButton *btnCal;
	UIButton *btnList;
	
	UIView *friendsView;
	UITableView *tblFriends;

	IBOutlet UIButton *btnSearch;
	IBOutlet UIButton *btnOthers;
	NSMutableArray *arrFriendEmails;
	
	
	int firstTime;

	NSString *strSelectCalDate;
	NSString *selectedButtonValue;
	NSInteger intTagValue;
	
	IBOutlet UIView *vwTopSearch;
	IBOutlet UIScrollView *scrl_btnsTop;
	UIButton *btn_scrlTop;
	NSMutableArray *arr_ValTop;
	NSMutableArray *arrSearchCal;

	UIView *vwSearchCal;
	
	NSMutableArray *arrEventFriend;
	NSInteger intActionTag;
	
	BOOL backImageViewStatu;
	BOOL isRefreshStatu;
	BOOL isRefresh;
	UIImageView *backImageView;
	UILabel *upTimeLabel;
	UILabel *backLabel;
	UIView *refreshView;
	UIImageView *imgBGTop;
	IBOutlet UIImageView *imgBG;

	NSString *selectedView;
	BOOL CalenderSearchEnabled;
		BOOL ListingSearchEnabled;
	NSString *selectedDate;
    
    NSInteger selectedCategoryInCalender;
	
	EventImagesBL *imagBl;
    NSString *SelectedFriendId;
    FavoriteBusinessBL *UserFavBussLayer;
    NSString *ScreenTitle;
    UIView *loaderView;
}
@property(nonatomic,retain)NSString *selectedDate;
@property(nonatomic,retain)NSString *BackBtnName;
@property (nonatomic, assign) NSInteger todayConstant,currentFirstDay,currentMonth,currentYear,currentLastDay,currentDayConstant,currentMonthConstant,currentYearConstant;
@property(nonatomic,retain)NSDate *currentDate;
@property(nonatomic,retain)UIView *calHeaderView2;
@property(nonatomic,retain)UILabel *monthLabel2;
@property(nonatomic,retain)CalenderView *view1,*view2;
@property(nonatomic,retain)IBOutlet UITableView *tableViewEvent;
@property(nonatomic,retain)IBOutlet UIView *viewEvent;
@property (nonatomic, retain) NSMutableArray *arr_TableRowHeight;
@property (nonatomic, assign)BOOL isMonthFirstTime;
@property (nonatomic, retain) NSMutableArray *arr_Events;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSMutableArray *arrCalernderEvents;
@property (nonatomic, retain) NSMutableArray *arrEventFriend;
@property(nonatomic , retain) UIImageView *backImageView;
@property(nonatomic,retain)UILabel *upTimeLabel;
@property(nonatomic,retain)	UILabel *backLabel;
@property(nonatomic,assign)	NSString *SelectedFriendId;
@property(nonatomic,assign) NSString *ScreenTitle;

-(IBAction)gotohome;
-(void)LoadCalender;
-(void)setCalendar;
-(IBAction)goToNextMonth:(UIButton *)sender;
-(IBAction)goToPreviousMonth:(UIButton *)sender;
-(IBAction)goToNextMonth2:(UIButton *)sender;
-(IBAction)goToPreviousMonth2:(UIButton *)sender;
-(void)getFirstDay:(NSInteger)month dayfirst:(NSInteger)firstday ofView:(CalenderView *)aView;
-(void)todayButtonAction;
-(void)showPicker;
-(void)hidePicker;

-(IBAction)dayNavigationEvent:(id)sender;
-(void)gotoPreviousDay;
-(void)setTheDayTitle;
-(void)gotoNextDay;
-(NSInteger)getNumberofDays:(NSInteger)monthInt YearVlue:(NSInteger)yearInt;
-(NSString *)stringWeekday:(NSInteger)intweekday;
-(void)checkForEvents;
-(void)removePreviousBtns;
-(void)addEventsToDayView;

-(IBAction)btn_CalenderAction;
-(IBAction)btn_WalkingtAction;
-(IBAction)btn_TopHitsAction;
-(void)addPicker;
-(void)addDatePicker;
-(IBAction)searchBtnTouchUpInside;
-(void)pickerViewInterface;
-(NSString *)getDateValue:(NSString *)date;
-(void)removeView;
-(void)popUpFriendListView;

-(void)popUpMail;
-(void)popUpFriendListView;
-(void)sendMail:(NSMutableArray *)friends;
-(void)removeFriendsView;
-(NSString *)getDate:(NSString *)date;

-(IBAction)searchBtnCalTouchUpInside;
-(void)eventFrienDownload;

@end
