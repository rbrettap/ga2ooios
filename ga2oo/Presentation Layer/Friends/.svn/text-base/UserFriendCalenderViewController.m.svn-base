//
//  UserFriendCalenderViewController.m
//  Ga2oo
//
//  Created by win it on 2/10/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import "UserFriendCalenderViewController.h"
#import "EventDetailViewController.h"
#import "EventsListCustomCell.h"
#import "FriendTableCell.h"
#import "EventFriendListBL.h"
#import "BusinessListBL.h"
#import "CategoryBL.h"
#import "EventCategoryBL.h"
#import "HttpRequest.h"
#import "FriendDetailViewController.h"


@implementation UserFriendCalenderViewController
@synthesize view1,view2;
@synthesize todayConstant,currentFirstDay,currentMonth,currentYear,currentLastDay,currentDayConstant,currentMonthConstant,currentYearConstant;
@synthesize currentDate;
@synthesize monthLabel2;
@synthesize calHeaderView2;
@synthesize BackBtnName;
@synthesize tableViewEvent;
@synthesize viewEvent;
@synthesize isMonthFirstTime;

@synthesize arr_Events;
@synthesize datePicker;
@synthesize arrCalernderEvents;
@synthesize arrEventFriend;
@synthesize backImageView;
@synthesize upTimeLabel;
@synthesize backLabel;
@synthesize selectedDate;
@synthesize SelectedFriendId;
@synthesize ScreenTitle;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

-(IBAction)searchBtnTouchUpInside
{
	vwSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
	vwSearch.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwSearch];
	
	keyboardToolBar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 644, 320, 44)];
	keyboardToolBar1.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(SearchEventsBtnClicked)];
	keyboardToolBar1.items=[[[NSArray alloc]initWithObjects:space1, done,nil]autorelease];
	[self.view addSubview:keyboardToolBar1];
	[keyboardToolBar1 release];
    [done release];
    [space1 release];
    
    
	UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	img1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearch addSubview:img1];
	[img1 release];
	
	UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
	img2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearch addSubview:img2];
	[img2 release];
	
	UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 88, 320, 326)];
	img3.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SearchBg" ofType:@"png"]];
	[vwSearch addSubview:img3];
	[img3 release];
	
	UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 227, 29)];
	img5.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchBookMark" ofType:@"png"]];
	[vwSearch addSubview:img5];
	[img5 release];
	
	searchList = [[UITextField alloc] initWithFrame:CGRectMake(35, 10, 160, 29)];
	searchList.delegate = self;
	[vwSearch addSubview:searchList];
	searchList.placeholder = @"Search";
	[searchList becomeFirstResponder];
	
	UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 44+7, 227, 29)];
	img4.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchLocation" ofType:@"png"]];
	[vwSearch addSubview:img4];
	[img4 release];
    
    UIButton *showCurrenLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    showCurrenLocation.frame = CGRectMake(195, 51, 35, 29);
    [showCurrenLocation addTarget:self action:@selector(showCurrenLocationClk:) forControlEvents:UIControlEventTouchUpInside];
    [vwSearch addSubview:showCurrenLocation];
	
	searchLocationList = [[UITextField alloc] initWithFrame:CGRectMake(35, 47+7, 160, 29)];
	searchLocationList.delegate = self;
	searchLocationList.placeholder = @"Default location";
	[vwSearch addSubview:searchLocationList];
	
	UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
	btnCancel.frame = CGRectMake(247, 6, 68, 31);
	[btnCancel setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelSearchBtn" ofType:@"png"]] forState:UIControlStateNormal];
	[btnCancel addTarget:self action:@selector(cancelBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
	[vwSearch addSubview:btnCancel];
	
	keyboardToolBar1.frame=CGRectMake(0, 200, 320, 44);
	[UIView commitAnimations];
}

-(void)showCurrenLocationClk:(UIButton *)sender
{
    
    if ([appDelegate.strCurrentLocation.City length]) 
    {
        if ([appDelegate.strCurrentLocation.City isEqualToString:@"None"])
        {
            searchLocationList.text= [NSString stringWithFormat:@"%@,%@", appDelegate.strCurrentLocation.State,appDelegate.strCurrentLocation.Zipcode];	
        }
        else 
        {
            searchLocationList.text= [NSString stringWithFormat:@"%@,%@", appDelegate.strCurrentLocation.City,appDelegate.strCurrentLocation.Zipcode];
        }
        
        
    }
    else if ([appDelegate.strCurrentLocation.State length])
    {
        searchLocationList.text= [NSString stringWithFormat:@"%@,%@", appDelegate.strCurrentLocation.State,appDelegate.strCurrentLocation.Zipcode];
    }
    else 
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check your device settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [myAlertView show];
        [myAlertView release];
    }
    
    [searchLocationList becomeFirstResponder];
}


-(void)SearchEventsBtnClicked
{
 
    NSMutableArray *arrSearchedEvents = [[NSMutableArray alloc]init];
	NSString *searchEventName;
	NSString *searchEventLocation;
    NSString *searchEventLocation2;
	searchEventName = searchList.text;
    
	NSArray *loactionArray = [searchLocationList.text componentsSeparatedByString:@","];
	searchEventLocation = [loactionArray objectAtIndex:0];
    
    if([loactionArray count] >= 2)
    {
        searchEventLocation2 = [loactionArray objectAtIndex:1];
    }
    else 
    {
        searchEventLocation2 = @"";
    }
	
	if(!searchEventName)
	{
		searchEventName = @"";
	}
	else if([searchEventName isEqualToString:@""])
	{
		searchEventName = @" ";
	}
	
	
	if(!searchEventLocation)
	{
		searchEventLocation = @"";
	}
	else if([searchEventLocation isEqualToString:@""])
	{
		searchEventLocation = @" ";
	}
	

	if([searchEventName length] || [searchEventLocation length])
	{
		CalenderSearchEnabled = YES;
 	}
	else  
	{
		CalenderSearchEnabled = NO;
 	}
    
    if (CalenderSearchEnabled) {
        
        
        NSMutableArray *arrNames =    [[NSMutableArray alloc]init];;
      
        
		
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"name contains[cd] %@",searchEventName];
		NSArray *arr = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred];
		
		if(arr)
		{
			
			if(![searchEventLocation isEqualToString:@""])
			{
				NSPredicate *pred = [NSPredicate predicateWithFormat:@"city contains[cd] %@",searchEventLocation];
				NSArray *arr1 = [arr filteredArrayUsingPredicate:pred];
				
                if(![searchEventLocation2 isEqualToString:@""])
                {
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"zipcode contains[cd] %@",searchEventLocation2];
                    NSArray *arr2 = [arr1 filteredArrayUsingPredicate:pred];
                    [arrNames addObjectsFromArray:arr2];
                    
                }
                else 
                {
                    [arrNames addObjectsFromArray:arr1];
                }

				
			}
			else 
			{
				[arrNames addObjectsFromArray:arr];
			}
			
		}
        
        
        for (int i=0; i<[arrNames count]; i++) {
            
            EventListBO *obj = [arrNames objectAtIndex:i];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"Eventid contains[cd] %@",obj.Eventid];
            NSArray *arr = [arrCalernderEvents filteredArrayUsingPredicate:pred];
            if ([arr count]) {
                [arrSearchedEvents addObject:obj];
            }
         }
        
        [arrNames release];
     }
    else{
    
    }

 
 
	
    if ([selectedView isEqualToString:@"Calender"])
    {
        
        /* [arrCalernderEvents removeAllObjects];
         [arr_Events removeAllObjects];
         
         [arrCalernderEvents addObjectsFromArray:arrSearchedEvents];*/
        [arr_Events removeAllObjects];
        for(int i=0;i<[arrSearchedEvents count];i++)
        {
            EventListBO *obj_=[arrSearchedEvents objectAtIndex:i];
            dateForm = [[NSDateFormatter alloc] init];
            [dateForm setDateFormat:@"yyyy-MM-dd"];
            NSDate *eventdate = [dateForm dateFromString:obj_.event_start_date];
            [dateForm setDateFormat:@"dd/M/yyyy"];
            NSLog(@"%@", [dateForm stringFromDate:[NSDate date]]);
            if([[dateForm stringFromDate:[NSDate date]] isEqualToString:[dateForm stringFromDate:eventdate]])
            {
                [arr_Events addObject:obj_];
            }
            [dateForm release];
        }
        [tableViewEvent reloadData];
        keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
        [view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrSearchedEvents];
        if(![arrSearchedEvents count])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No events found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];	
        }
        
        [vwSearchCal removeFromSuperview];
    }

    
    /*if ([selectedView isEqualToString:@"Calender"]) {
        
         [arrCalernderEvents removeAllObjects];
        [arr_Events removeAllObjects];
         
        [arrCalernderEvents addObjectsFromArray:arrSearchedEvents];
        for(int i=0;i<[arrCalernderEvents count];i++)
        {
           EventListBO *obj_=[arrCalernderEvents objectAtIndex:i];
            dateForm = [[NSDateFormatter alloc] init];
            [dateForm setDateFormat:@"yyyy-MM-dd"];
            NSDate *eventdate = [dateForm dateFromString:obj_.event_start_date];
            [dateForm setDateFormat:@"dd/M/yyyy"];
            NSLog(@"%@", [dateForm stringFromDate:[NSDate date]]);
            if([[dateForm stringFromDate:[NSDate date]] isEqualToString:[dateForm stringFromDate:eventdate]])
            {
                [arr_Events addObject:obj_];
             }
            [dateForm release];
        }
         [tableViewEvent reloadData];
        keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
        [view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];
        [vwSearchCal removeFromSuperview];
    }*/
    else{
           [arrListingEvents removeAllObjects];
         NSPredicate *pred = [NSPredicate predicateWithFormat:@"event_start_date == %@",selectedDate];
        NSArray *arr = [arrSearchedEvents filteredArrayUsingPredicate:pred];
        [arrListingEvents addObjectsFromArray:arr];
        if(![arrListingEvents count])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No events found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];	
        }
        [tbl_Events reloadData];
    
    }
    [self cancelBtnTouchUpInside];

 	[arrSearchedEvents release];

 
}


/*
-(IBAction)searchBtnCalTouchUpInside
{
	vwSearchCal = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
	vwSearchCal.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwSearchCal];

	keyboardToolBar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 644, 320, 44)];
	keyboardToolBar1.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(CalenderViewSearchBtnClicked)];
	keyboardToolBar1.items=[[[NSArray alloc]initWithObjects:space1, done,nil]autorelease];
	[self.view addSubview:keyboardToolBar1];
    [keyboardToolBar1 release];
	
	UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	img1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearchCal addSubview:img1];
	[img1 release];
	
	UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
	img2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearchCal addSubview:img2];
	[img2 release];
	
	UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 88, 320, 326)];
	img3.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SearchBg" ofType:@"png"]];
	[vwSearchCal addSubview:img3];
	[img3 release];
	
	UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 227, 29)];
	img5.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchBookMark" ofType:@"png"]];
	[vwSearchCal addSubview:img5];
	[img5 release];

	searchList = [[UITextField alloc] initWithFrame:CGRectMake(35, 10, 227, 29)];
	searchList.delegate = self;
	searchList.placeholder = @"Search";
	[vwSearchCal addSubview:searchList];
	
	UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 44+7, 227, 29)];
	img4.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchLocation" ofType:@"png"]];
	[vwSearchCal addSubview:img4];
	[img4 release];
	
	searchLocationList = [[UITextField alloc] initWithFrame:CGRectMake(35, 47+7, 227, 29)];
	searchLocationList.delegate = self;
	searchLocationList.placeholder = @"Default location";
	[vwSearchCal addSubview:searchLocationList];
	
	UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
	btnCancel.frame = CGRectMake(247, 6, 68, 31);
	[btnCancel setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelSearchBtn" ofType:@"png"]] forState:UIControlStateNormal];
	[btnCancel addTarget:self action:@selector(cancelBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
	[vwSearchCal addSubview:btnCancel];

}
*/
-(void)setUpRefreshView
{
	UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
	UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 65-theImage.size.height, theImage.size.width, theImage.size.height)];
	theImageView.image = theImage;
	self.backImageView = theImageView;
	//self.backImageView.frame = CGRectMake(backImageView.frame.origin.x, -theImageView.frame.origin.y, theImage.size.width, theImage.size.height);
	[theImageView release];
	CGAffineTransform transform = backImageView.transform;
	transform = CGAffineTransformRotate(transform, M_PI);
	backImageView.transform = transform;
	
	UILabel *theLabel           = [[UILabel alloc] initWithFrame:CGRectMake(30, 85-50, 280, 25)];
	UILabel *theUpdateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 85-30, 280, 20)];
	self.upTimeLabel=theUpdateTimeLabel;
	self.backLabel = theLabel;
	//	tableView.backgroundColor = [UIColor colorWithRed:177 green:191 blue:200 alpha:1];
	
	[theUpdateTimeLabel release];
	[theLabel release];
	
	upTimeLabel.text            = @"";//[NSString stringWithFormat:@"Dernière mise à jour : %@",@"Ga2oo"];
	upTimeLabel.textColor       = [UIColor colorWithRed:0.50196 green:0.53725 blue:0.6 alpha:1];
	
    upTimeLabel.font            = [UIFont fontWithName:@"Knockout-HTF31-JuniorMiddlewt" size:12.0];
	upTimeLabel.backgroundColor = [UIColor clearColor];
	upTimeLabel.textAlignment   = UITextAlignmentCenter;
	
	backLabel.text            = @"Pull down to refresh";
	backLabel.textColor       = [UIColor colorWithRed:0.50196 green:0.53725 blue:0.6 alpha:1];
	backLabel.font            = [UIFont fontWithName:@"Knockout-HTF70-FullWelterwt" size:14.0];
	backLabel.backgroundColor = [UIColor clearColor];
	backLabel.textAlignment   = UITextAlignmentCenter;
	refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 65)];
	refreshView.backgroundColor = [UIColor colorWithRed:0.88627 green:0.90588 blue:0.92941 alpha:1];
	[refreshView addSubview:upTimeLabel];
	[refreshView addSubview:backLabel];
	[refreshView addSubview:backImageView];
	[vwList addSubview:refreshView];
	[vwList sendSubviewToBack:refreshView];
	
	backImageViewStatu = NO;
	isRefreshStatu     = NO;
}

#pragma mark --------- Scroll View Delegate -------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *)scrollView; 
	if(tblTemp)
	if(tblTemp.tag == 2)
	{
		UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
		
		if(scrollView.contentOffset.y<=0)
		{
			CGRect rect         = CGRectMake(0, 30, 320, 65);
			rect.origin.y       -= scrollView.contentOffset.y+5;
			refreshView.frame = rect;
			
			if(scrollView.contentOffset.y <= -95 && backImageViewStatu == NO)
			{
				backLabel.text =@"Release to refresh";
				[UIView beginAnimations:@"animationID" context:nil];
				[UIView setAnimationDuration:0.3f];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationRepeatAutoreverses:NO];
				CGAffineTransform transform = backImageView.transform;
				transform = CGAffineTransformRotate(transform, M_PI);
				backImageView.transform = transform;
				[UIView commitAnimations];
				backImageViewStatu = YES;
			}
			else if(scrollView.contentOffset.y > -95 && backImageViewStatu ==YES)
			{
				backLabel.text = @"Pull down to refresh";
				backImageView.image = theImage;
				[UIView beginAnimations:@"animationID" context:nil];
				[UIView setAnimationDuration:0.3f];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationRepeatAutoreverses:NO];
				CGAffineTransform transform = backImageView.transform;
				transform = CGAffineTransformRotate(transform, M_PI);
				backImageView.transform = transform;
				[UIView commitAnimations];
				backImageViewStatu = NO;
			}		
		}
		else 
		{
			refreshView.frame = CGRectMake(0, 30, 320, 65);
		}
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *)scrollView; 
	if(tblTemp)
		if(tblTemp.tag == 2)
		{
	if (scrollView.contentOffset.y<= -95)
		isRefresh = YES;
	else 
		isRefresh = NO;
		}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *)scrollView; 
	if(tblTemp)
		if(tblTemp.tag == 2)
		{
			if(isRefresh)
			{
				isRefresh = NO;
				[self refreshData];
			}
		}
}

-(void)refreshDataPart
{
	[tableViewEvent reloadData];
}

-(void) refreshData
{
	[self performSelector:@selector(refreshDataPart) withObject:nil afterDelay:0];
}


#pragma mark UIView delegate

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self setTopBarImageToEventDetailView:self.view];
	selectedView = @"Calender";
    CalenderSearchEnabled = NO;
    UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
	
	
	firstTime=1;
	arrEventFriend = [[NSMutableArray alloc] init];
	arrSearchCal = [[NSMutableArray alloc] init];
	arr_Events = [[NSMutableArray alloc] init];
 	arrCalernderEvents = [[NSMutableArray alloc]init];
    
    loaderView = [[UIView alloc] initWithFrame:CGRectMake(75,130+55, 170, 49)];
	loaderView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
	loaderView.layer.cornerRadius = 6.0;
	loaderView.layer.borderColor = [[UIColor grayColor] CGColor];
	loaderView.layer.borderWidth = 2.0;
 	loaderView.tag = 85;
	
	//add indicator
	UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 6, 37, 37)];
	[indView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indView startAnimating];
    [loaderView addSubview:indView];
	[indView release];
	
	UILabel *lblSyncing = [[UILabel alloc] initWithFrame:CGRectMake(135-75,14, 90, 20)];
	lblSyncing.backgroundColor = [UIColor clearColor];
	lblSyncing.text = @"Loading...";
	lblSyncing.textAlignment =UITextAlignmentCenter;
	lblSyncing.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
	lblSyncing.font = [UIFont boldSystemFontOfSize:14.0];
	lblSyncing.textColor = [UIColor whiteColor];
	lblSyncing.alpha=1.0;
	[loaderView addSubview:lblSyncing];
	[lblSyncing release];

    
    [arrCalernderEvents addObjectsFromArray:appDelegate.arrFriendEvents];
	countForArrow = 0;
 	
	vwCalender = [[UIView alloc] initWithFrame:CGRectMake(0, 45+36, 320, 416)];
	vwCalender.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwCalender];
 
	[self setUpRefreshView];
	
	vwList.frame = CGRectMake(0, 45+32, 320, 416);
	vwList.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwList];
	vwList.hidden = YES;
	

	imgBGTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 135)];
	imgBGTop.backgroundColor = [UIColor clearColor];
	imgBGTop.image = [UIImage imageNamed:@"innerbg_top.png"];
	[vwList addSubview:imgBGTop];
	
	[vwList sendSubviewToBack:imgBGTop];
	[vwList sendSubviewToBack:refreshView];
	[vwList sendSubviewToBack:imgBG];
	

 
	
	NSDate *today1 = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"d"];
	NSString *dateString11 = [dateFormat stringFromDate:today1];
	lbl_Date.text = [self getDate:dateString11];
	[dateFormat release];
	
	NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
	[dateFormat1 setDateFormat:@"MMM"];
	lbl_Month.text = [dateFormat1 stringFromDate:[NSDate date]];
	[dateFormat1 release];
	
	arrListingEvents=[[NSMutableArray alloc]init];
	
	isMonthFirstTime = TRUE;
 
    UILabel *TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 44)];
    TitleLbl.backgroundColor = [UIColor clearColor];
    TitleLbl.text = self.ScreenTitle;
    TitleLbl.textColor = [UIColor whiteColor];
    TitleLbl.font = [UIFont boldSystemFontOfSize:19];
    TitleLbl.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:TitleLbl];
    [TitleLbl release];
 
 
		
		btnCal = [[UIButton alloc] initWithFrame:CGRectMake(5, 6, 42, 32)];
		[btnCal addTarget:self action:@selector(CalBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
		btnCal.backgroundColor = [UIColor clearColor];
		btnCal.tag = 11;
		[btnCal setImage:[UIImage imageNamed:@"cal_btn_hover.png"] forState:UIControlStateNormal];
		[self.view addSubview:btnCal];
		[btnCal release];
		
		btnList = [[UIButton alloc] initWithFrame:CGRectMake(47, 6, 42, 32)];
		[btnList addTarget:self action:@selector(ListBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
		btnList.backgroundColor = [UIColor clearColor];
		btnList.tag = 12;
		[btnList setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
		[self.view addSubview:btnList];
		[btnList release];
		
		vwTopSearch.frame = CGRectMake(0, 44, 320, 35);
		[self.view addSubview:vwTopSearch];
		
		viewEvent.frame = CGRectMake(0, 45+200, 320, 78+7);

	calHeaderView2.frame = CGRectMake(0, 0, 320, 45);
	[vwCalender addSubview:calHeaderView2];
	
	[self setCalendar];
	todayConstant = self.currentFirstDay;
	//self.view1 = [[CalenderView alloc]initWithFrame:CGRectMake(-320, 45, 320, 200)];
	self.view2 = [[CalenderView alloc]initWithFrame:CGRectMake(0, 45, 320, 200)];
	
	//[(CalenderView *)self.view1 setDelegate:self];
	[(CalenderView *)self.view2 setDelegate:self];
	
	self.view2.backgroundColor = [UIColor whiteColor];
 	//[vwCalender addSubview:view1];
	[vwCalender addSubview:view2];
	
	
	[vwCalender addSubview:viewEvent];
	
	tableViewEvent.backgroundColor = [UIColor clearColor];
	tableViewEvent.tag = 1;
 	
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 650, 320, 44)];
	UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked)] autorelease];
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked)] autorelease];
	UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	toolBar.items = [[[NSArray alloc] initWithObjects:cancelButton,space,saveButton,nil] autorelease];
	[self.view addSubview:toolBar];
	
	
	//view1.hidden =YES;
	view2.hidden = YES;
	calHeaderView2.hidden = YES;
	
	if(isMonthFirstTime){
		//[self LoadCalender];
        //[NSThread detachNewThreadSelector:@selector(LoadCalender) toTarget:self withObject:Nil];
        [self.view addSubview:loaderView];
        [self performSelectorOnMainThread:@selector(LoadCalender) withObject:nil waitUntilDone:false];
		isMonthFirstTime = FALSE;
	}
	
	
	
    lbl_Walk.text = @"walking";
    lbl_Hits.text = @"tophits";
    
	arr_Walk=[[NSMutableArray alloc]init];
	[arr_Walk addObject:@"walking"];
	[arr_Walk addObject:@"driving"];
	[arr_Walk addObject:@"flying"];
	
	arr_Hits=[[NSMutableArray alloc]init];
	[arr_Hits addObject:@"tophits"];
	[arr_Hits addObject:@"hits"];
	
	
	
	tbl_Events = [[UITableView alloc] initWithFrame:CGRectMake(0,90,320,245)];// style:UITableViewStyleGrouped];
	tbl_Events.delegate=self; 
	tbl_Events.dataSource=self;
	tbl_Events.tag = 2;
	tbl_Events.scrollEnabled=YES;
	tbl_Events.scrollsToTop=YES;
	[tbl_Events setBackgroundColor:[UIColor clearColor]];
	
	
	for(UIScrollView *scrl in tbl_Events.subviews)
	{
		scrl.tag = 322;
	}
	
	//[tblView reloadData];
	[vwList  addSubview:tbl_Events]; 
	
	
	searching=YES;
	
	arr_Buttons=[[NSMutableArray alloc]init];
    
    CategoryBL *catbl = [[CategoryBL alloc]init];
    [arr_Buttons addObject:@"All"];
	
	NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"maincategoryname" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSMutableArray *TempArry = [catbl SelectAll];
	[TempArry sortUsingDescriptors:[NSArray arrayWithObjects:nameSortDescriptor,nil]];
	
	[arr_Buttons addObjectsFromArray:TempArry];
	
	[nameSortDescriptor release];
	
      [catbl release];
	
	
 	arr_ValTop = [[NSMutableArray alloc] init];

	arr_Images=[[NSMutableArray alloc]init];
	
	
 
	
	scrl_btnsTop.contentSize = CGSizeMake([arr_Buttons count]*75+40, 26);
	scrl_btnsTop.showsHorizontalScrollIndicator = FALSE;
 
	int x=5;
	for(int i=0;i<[arr_Buttons count];i++)
	{
        
        NSString *strCategoryName = nil;
        if ([[arr_Buttons objectAtIndex:i] isKindOfClass:[NSString class]]) {
            strCategoryName = [arr_Buttons objectAtIndex:i];
        }
        else{
            strCategoryName = [[arr_Buttons objectAtIndex:i] maincategoryname];
        }
        
        CGSize labelStringSizeCat = [strCategoryName sizeWithFont:[UIFont systemFontOfSize:15] 
                                                constrainedToSize:CGSizeMake(260, 100) 
                                                    lineBreakMode:UILineBreakModeWordWrap];
        
        

        btn_scrlTop =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        if (labelStringSizeCat.width+20 < 75) {
            btn_scrlTop.frame = CGRectMake(x,1,75,26);
            x=x+75;
         }
        else{
            btn_scrlTop.frame = CGRectMake(x,1,labelStringSizeCat.width+20,26);
            x=x+labelStringSizeCat.width+20;
         }
        
 		[btn_scrlTop addTarget:self action:@selector(btn_scrlActionTop:) forControlEvents:UIControlEventTouchUpInside];
		
		UILabel *lbl_scrlbtn1=[[UILabel alloc ]initWithFrame:CGRectMake(0,0,labelStringSizeCat.width+20,26)];
        if (labelStringSizeCat.width+20 < 75) {
            lbl_scrlbtn1.frame = CGRectMake(0,0,75,26);
        }
        else{
            lbl_scrlbtn1.frame = CGRectMake(0,0,labelStringSizeCat.width+20,26);
        }
        
        lbl_scrlbtn1.text = strCategoryName;
        
		lbl_scrlbtn1.textColor=[UIColor whiteColor];
		[lbl_scrlbtn1 setBackgroundColor:[UIColor clearColor]];
		lbl_scrlbtn1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
		lbl_scrlbtn1.textAlignment = UITextAlignmentCenter;
		[btn_scrlTop addSubview:lbl_scrlbtn1];		
		[lbl_scrlbtn1 release];
		
		btn_scrlTop.tag=i;
		
		if(btn_scrlTop.tag==0)
		{
			[btn_scrlTop setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
			
		}
		
		[arr_ValTop addObject:btn_scrlTop];
		[scrl_btnsTop addSubview:btn_scrlTop];
 		[btn_scrlTop release];
 	}
	
	[self pickerViewInterface];
	arrFriendEmails = [[NSMutableArray alloc] init];
	
}





-(void)viewWillAppear:(BOOL)animated
{
	[self removeFriendsView];
	if([arrFriendEmails count])
	[arrFriendEmails removeAllObjects];
    //[arrCalernderEvents removeAllObjects];

}

-(void)viewWillDisappear:(BOOL)animated
{
	keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark POPUP Methods
-(void)addFriendToSendmail:(UIButton *)btn{
    FriendsBO *obj =  [arrEventFriend objectAtIndex:btn.tag]; 	
    
    if ([[btn currentImage] isEqual:[UIImage imageNamed:@"select_enable.png"]]) {
        [btn setImage:[UIImage imageNamed:@"rite_active.png"] forState:UIControlStateNormal];
        [arrFriendEmails addObject:obj];
    }
    else{
        [btn setImage:[UIImage imageNamed:@"select_enable.png"] forState:UIControlStateNormal];
        [arrFriendEmails removeObjectIdenticalTo:obj];
    }
    
}
-(void)sendMail:(NSMutableArray *)friends
{
	if([MFMailComposeViewController  canSendMail])
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		mail.mailComposeDelegate = self;
		[mail.navigationBar setTintColor: [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1] ];
		if ([MFMailComposeViewController canSendMail]) {
			[mail setSubject:[NSString stringWithFormat:@"%@", objEvent.name]];
			
			NSArray *arr;
			arr = [friends valueForKeyPath:@"email"];				
			[mail setToRecipients:arr];
			
			NSString *strDateStr = [NSString stringWithFormat:@"%@ %@", objEvent.event_start_date, objEvent.event_start_time];
			
			NSString *str = [NSString stringWithFormat:@"<html><body><b>%@</b> <br/>%@ <br/>%@ <br/><br/>%@</body></html>",objEvent.name,strDateStr,objEvent.price, objEvent.name];
			
			[mail setMessageBody:str isHTML:YES];	
			UIImage *img = objEvent.imageEvent;//objEvent.imgCover;
			if(img)
			{
				NSData *data = UIImagePNGRepresentation(img);
				[mail addAttachmentData:data mimeType:@"image/png" fileName:@"abc"];
				
			}
			[self presentModalViewController:mail animated:YES];
		}
		[mail release];		
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please configure Email in your device." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];	
	}
	
}

-(void)sendRecomendations:(NSMutableArray *)friends
{
    
    NSArray *arr;
    arr = [friends valueForKeyPath:@"FriendId"];
    NSString *FriendsIds = [NSString stringWithFormat:@
                            "<friend>\n"];
    
    for(int k = 0 ; [arr count]>k ; k++)
    {
        FriendsIds = [FriendsIds stringByAppendingString:[NSString stringWithFormat:@"<friendid>%i</friendid>\n",[[arr objectAtIndex:k] integerValue]]];
    }
    
    FriendsIds = [FriendsIds stringByAppendingString:@"</friend>"];
    
    UserFavBussLayer.strSopForDeleteEvnt = [NSString stringWithFormat:@
                                            "<useraccount >\n"
                                            "<id>%i</id>\n"   
                                            "<eventid>%@</eventid>\n"
                                            "<subject>%@</subject>\n"  
                                            "<message>%@,%@</message>\n"
                                            "<friendships>%@</friendships>\n"
                                            "</useraccount >\n",[appDelegate.currentUserID intValue],objEvent.Eventid,objEvent.name,objEvent.event_start_date, objEvent.event_start_time,FriendsIds];
    
    
    NSLog(@"UserFavBussLayer.strSopForDeleteEvnt %@",UserFavBussLayer.strSopForDeleteEvnt);
    
    [UserFavBussLayer deleteFavorite];
    
    
}



-(void)popUpMail{
	
	tbl_Events.userInteractionEnabled		= NO;
	tableViewEvent.userInteractionEnabled	= NO;
	btnSearch.userInteractionEnabled		= NO;
	btnOthers.userInteractionEnabled		= NO;
	
	friendsView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 335)];
	friendsView.alpha = 0.80;
	friendsView.backgroundColor = [UIColor blackColor];
	friendsView.layer.cornerRadius = 10.0;
	friendsView.layer.borderWidth = 3.0;
	friendsView.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
	[friendsView.layer setMasksToBounds:YES];
	
	
	UIButton *btnClose = [[UIButton alloc]initWithFrame:CGRectMake(209, 2, 71, 30)];
	[btnClose setImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
	btnClose.backgroundColor = [UIColor clearColor];
	[btnClose addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	[friendsView addSubview:btnClose];
	[btnClose release];
	
	UIButton *btnOK = [[UIButton alloc]initWithFrame:CGRectMake(40, 300, 200, 30)];
	//[btnOK setImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
	//[btnOK setTitle:@"OK" forState:UIControlStateNormal];
    [btnOK setImage:[UIImage imageNamed:@"DoneBtn.png"] forState:UIControlStateNormal];
	btnOK.backgroundColor = [UIColor clearColor];
	[btnOK addTarget:self action:@selector(btnOkClicked) forControlEvents:UIControlEventTouchUpInside];
	[friendsView addSubview:btnOK];
	[btnOK release];
	
	tblFriends = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 280, 260)];
	tblFriends.backgroundColor = [UIColor clearColor];
	tblFriends.tag =2222;
	tblFriends.delegate = self;
	tblFriends.dataSource = self;
	[friendsView addSubview:tblFriends];
	
	[self.view addSubview:friendsView];
	
	//transforming the view
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	[self.view addSubview:friendsView];
	
	//animation starts here
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
	
}
-(void)btnOkClicked{
	if([arrFriendEmails count]){
		tbl_Events.userInteractionEnabled		= YES;
		tableViewEvent.userInteractionEnabled	= YES;
		btnSearch.userInteractionEnabled		= YES;
		btnOthers.userInteractionEnabled		= YES;
		
		if(friendsView!=nil)
		{
			[friendsView removeFromSuperview];
			[friendsView release];
			friendsView = nil;
			tblFriends.delegate = nil;
			tblFriends.dataSource = nil;
			[tblFriends release];
		}
		
		[self sendRecomendations:arrFriendEmails];
	}
	else {
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please select at least one friend to send mail." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];			
	}
}	

-(void)popUpFriendListView
{
	tbl_Events.userInteractionEnabled		= NO;
	tableViewEvent.userInteractionEnabled	= NO;
	btnSearch.userInteractionEnabled		= NO;
	btnOthers.userInteractionEnabled		= NO;
	
	friendsView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 335)];
	friendsView.alpha = 0.80;
	friendsView.backgroundColor = [UIColor blackColor];
	friendsView.layer.cornerRadius = 10.0;
	friendsView.layer.borderWidth = 3.0;
	friendsView.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
	[friendsView.layer setMasksToBounds:YES];
	
	
	UIButton *btnClose = [[UIButton alloc]initWithFrame:CGRectMake(209, 2, 71, 30)];
	[btnClose setImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
	btnClose.backgroundColor = [UIColor clearColor];
	[btnClose addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	[friendsView addSubview:btnClose];
	[btnClose release];
	
	tblFriends = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 280, 290)];
	tblFriends.backgroundColor = [UIColor clearColor];
	tblFriends.tag =1111;
	tblFriends.delegate = self;
	tblFriends.dataSource = self;
	[friendsView addSubview:tblFriends];
	[tblFriends reloadData];
	[self.view addSubview:friendsView];
	
	//transforming the view
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	[self.view addSubview:friendsView];
	
	//animation starts here
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
}
-(void)removeFriendsView
{
	tbl_Events.userInteractionEnabled		= YES;
	tableViewEvent.userInteractionEnabled	= YES;
	btnSearch.userInteractionEnabled		= YES;
	btnOthers.userInteractionEnabled		= YES;
	
	if(friendsView!=nil)
	{
        tblFriends.delegate = nil;
        tblFriends.dataSource = nil;
        [tblFriends release];
        [friendsView removeFromSuperview];
        [friendsView release];
        friendsView = nil;
	
	}
}

-(void)closeBtnClicked:(id)sender
{
	tbl_Events.userInteractionEnabled		= YES;
	tableViewEvent.userInteractionEnabled	= YES;
	btnSearch.userInteractionEnabled		= YES;
	btnOthers.userInteractionEnabled		= YES;
	
 	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	friendsView.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(removeFriendsView) withObject:nil afterDelay:1.0];
	
}

#pragma mark Methods Used Localy

-(void)removeView
{
	[search resignFirstResponder];
	[searchList resignFirstResponder];
	[searchLocationList resignFirstResponder];
	[vwSearch removeFromSuperview];
}

-(NSString *)getDate:(NSString *)date
{
	NSArray *myArray = [date componentsSeparatedByString:@" "];
	NSInteger Date=[[myArray objectAtIndex:0] intValue];
	
	switch (Date) 
	{
		case 1:
			
			return [NSString stringWithFormat:@"%@st", [myArray objectAtIndex:0]];
			
		case 2:
			
			return [NSString stringWithFormat:@"%@nd", [myArray objectAtIndex:0]];
		case 3:
			
			return [NSString stringWithFormat:@"%@rd", [myArray objectAtIndex:0]];
		default:
			
			return [NSString stringWithFormat:@"%@th", [myArray objectAtIndex:0]];
	}
	return @"";
}

-(void)gotoPreviousDay
{	
	if((currentDayRunning - 1) >= 1)
	{
		currentDayRunning--;
	}
	else if((currentDayRunning-1) == 0 && (currentMonth-1) == 0){
		currentMonth = 12;
		currentYear--;
		currentDayRunning = [self getNumberofDays:currentMonth YearVlue:currentYear];
	}
	else{
		currentMonth--;	
		currentDayRunning = [self getNumberofDays:currentMonth YearVlue:currentYear];
	}
	
	NSDateFormatter *dfWeekDay = [[NSDateFormatter alloc] init];
	[dfWeekDay setDateFormat:@"yyyy MM d"];
	NSDate *date=[dfWeekDay dateFromString:[NSString stringWithFormat:@"%i %i %i",currentYear,currentMonth,currentDayRunning]];
	[dfWeekDay setDateFormat:@"e"];
	currentWeekDay = [[dfWeekDay stringForObjectValue:date]intValue];
	[dfWeekDay release];
	
	[self checkForEvents];
	[self setTheDayTitle];
}	

-(NSInteger)getNumberofDays:(NSInteger)monthInt YearVlue:(NSInteger)yearInt{
	BOOL isLeap = NO;
	if(((yearInt % 400) == 0) || (((yearInt % 4) == 0) && ((yearInt % 100 != 0))))
		isLeap = YES;
	
	switch (monthInt){
		case 1:			
			return 31;
		case 2:
			if(isLeap==YES)
				return 29;			
			return 28;
		case 3:			
			return 31;
		case 4:			
			return 30;
		case 5:			
			return 31;
		case 6:			
			return 30;
		case 7:			
			return 31;
		case 8:			
			return 31;
		case 9:			
			return 30;
		case 10:			
			return 31;
		case 11:			
			return 30;
		case 12:			
			return 31;
	}
	return 0;
}

-(NSString *)stringWeekday:(NSInteger)intweekday
{
	NSString *str=nil;
	switch (intweekday) {
			
		case 1:
			str=@"Sunday";
			break;
		case 2:
			str=@"Monday";
			break;
		case 3:
			str=@"Tuesday";
			break;
		case 4:
			str=@"Wednesday";
			break;
		case 5:
			str=@"Thursday";
			break;
		case 6:
			str=@"Friday";
			break;
		case 7:
			str=@"Saturday";
			break;
		default:
			break;
	}
	return str;
}

-(void)checkForEvents
{
	[self.arr_Events removeAllObjects];
	
	NSString *str_Date = [NSString stringWithFormat:@"%i/%i/%i",currentDayRunning,currentMonth,currentYear];
	
	NSPredicate *pred_Date = [NSPredicate predicateWithFormat:@"strDate == %@ ",str_Date];
	NSArray *arr_Eve = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred_Date];
	
	[self.arr_Events addObjectsFromArray:arr_Eve];
	[self addEventsToDayView];
}

-(void)addEventsToDayView
{
	[self removePreviousBtns];
	
	for (int i = 0 ; i < [self.arr_Events count] ; i++) 
	{
		EventsBO *temp_Event = [self.arr_Events objectAtIndex:i];
		
		NSString *str_Time = temp_Event.event_start_time;
		NSString *str_TimeWithOutAMPM = nil;
		
		NSRange rangeIs = [str_Time rangeOfString:@"AM" options:NSCaseInsensitiveSearch];
		str_TimeWithOutAMPM = [str_Time substringToIndex:[str_Time length]-2];
		
		NSArray *arr_TimeCom = [str_TimeWithOutAMPM componentsSeparatedByString:@":"];
		
		CGFloat offSetY;
		if(rangeIs.length > 0)
		{
			offSetY = [[arr_TimeCom objectAtIndex:0] intValue] * 45 + ([[arr_TimeCom objectAtIndex:1] floatValue]/60) * 45;
		}
		else
		{
			offSetY =  ([[arr_TimeCom objectAtIndex:0] intValue] + 12) * 45 + ([[arr_TimeCom objectAtIndex:1] floatValue]/60) * 45;
		}
		
		offSetY += 12;
		
		UIButton *btn_Event = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Event setBackgroundColor:[UIColor colorWithRed:80/255.0 green:117/255.0 blue:171/255.0 alpha:1.0]];
		
		UILabel *lbl_Temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 250, 30)];
		lbl_Temp.shadowOffset=CGSizeMake (1.0, -1.0);
		lbl_Temp.backgroundColor = [UIColor clearColor];
		lbl_Temp.text = temp_Event.name;
		lbl_Temp.numberOfLines = 2;
		lbl_Temp.alpha = 0.75;
		lbl_Temp.shadowColor=[UIColor whiteColor];
		lbl_Temp.font=[UIFont fontWithName:@"Arial-BoldMT" size:13.0];
		btn_Event.layer.cornerRadius=5.0;
		btn_Event.layer.borderWidth=1.0f;
		btn_Event.layer.borderColor=[[UIColor grayColor] CGColor];
		[btn_Event setContentEdgeInsets:UIEdgeInsetsMake(2, 5, 0, 0)];
		btn_Event.tag = i;
		btn_Event.alpha=0.75f;
		btn_Event.frame=CGRectMake(55, offSetY, 260,42);
		[btn_Event addSubview:lbl_Temp];
		[lbl_Temp release];
		[btn_Event addTarget:self action:@selector(dayeventbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
		[scr_Day addSubview:btn_Event];
		btn_Event= nil;
	}
}

-(void) pushViewEventDetail:(NSString *)selectedDay
{
	NSLog(@"[selectedDay integerValue]%i", [selectedDay integerValue]);
	if(![selectedDay integerValue]==0)
	{
        
        if(appDelegate.heightOfCalendarIncreased == 1)
        {
            viewEvent.frame = CGRectMake(0, 45+240, 320, 38+7);
            self.view2.frame = CGRectMake(0, 45, 320, 240); 
        }
        else
        {
            viewEvent.frame = CGRectMake(0, 45+200, 320, 78+7);
            self.view2.frame = CGRectMake(0, 45, 320, 200);
        }
        
		
		[arr_Events removeAllObjects];
		selectedDay = [NSString stringWithFormat:@"%i/%i/%i",[selectedDay integerValue],currentMonth,currentYear];
 		NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
		[dtFormatter setDateFormat:@"dd/M/yyyy"];
		NSDate *date = [dtFormatter dateFromString:selectedDay];
		
		[dtFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *strDate123 = [dtFormatter stringFromDate:date];
		selectedDate = [[NSString alloc]initWithFormat:@"%@",strDate123];

		[dtFormatter release];
		NSPredicate *pred_Date = [NSPredicate predicateWithFormat:@"event_start_date == %@ ",strDate123];

		NSArray *arr_Eve=[arrCalernderEvents filteredArrayUsingPredicate:pred_Date];
    
   
		[self.arr_Events addObjectsFromArray:arr_Eve];
 		[tableViewEvent reloadData];
	 

 		
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/M/yyyy"];
		datePicker.date= [df dateFromString:selectedDay];
		NSLog(@"%@", selectedDay);
        [df release];
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"d"];
		NSString *dateString11 = [dateFormat stringFromDate:datePicker.date];
		lbl_Date.text = [self getDate:dateString11];
		[dateFormat release];
		
		NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
		[dateFormat1 setDateFormat:@"MMM"];
		lbl_Month.text = [dateFormat1 stringFromDate:datePicker.date];
		[dateFormat1 release];
	 
		
		NSLog(@"final selectedDay %@", selectedDay);
	}
    
    if(loaderView)
    {
        [loaderView removeFromSuperview];
        [loaderView release];
        loaderView= nil;
    }
}

-(void)gotoNextDay{	
	if((currentDayRunning+1) <= [self getNumberofDays:currentMonth YearVlue:currentYear]){
		currentDayRunning++;
	}
	else if((currentMonth+1) == 13){
		currentDayRunning = 1;
		currentMonth = 1;
		currentYear++;
	}
	else{
		currentDayRunning = 1;
		currentMonth++;
	}
	NSDateFormatter *dfWeekDay = [[NSDateFormatter alloc] init];
	[dfWeekDay setDateFormat:@"yyyy MM d"];
	NSDate *date=[dfWeekDay dateFromString:[NSString stringWithFormat:@"%i %i %i",currentYear,currentMonth,currentDayRunning]];
	[dfWeekDay setDateFormat:@"e"];
	currentWeekDay = [[dfWeekDay stringForObjectValue:date]intValue];
	[dfWeekDay release];
	
	[self checkForEvents];
	[self setTheDayTitle];
}

-(void)setTheDayTitle
{
	if(currentMonth == currentMonthConstant && currentDayRunning == currentDayConstant && currentYear == currentYearConstant)
	{
		NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
		[formatter setDateFormat:@"yyyy MM dd"];
		//NSDate *tempdate=[formatter dateFromString:[NSString stringWithFormat:@"%i %i %i",currentYear,currentMonth,currentDayRunning]];
		[formatter release];
	}
	else
	{
		NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
		[formatter setDateFormat:@"yyyy MM dd"];
		//NSDate *tempdate=[formatter dateFromString:[NSString stringWithFormat:@"%i %i %i",currentYear,currentMonth,currentDayRunning]];
		[formatter release];
	}
}



-(void)removePreviousBtns
{
	for(UIView *v in scr_Day.subviews)
	{
		if(v.tag != 1000)
		{
			[v removeFromSuperview];
		}
	}
}

-(NSString *)getDateValue:(NSString *)date
{
	NSArray *myArray = [date componentsSeparatedByString:@"/"];
	NSInteger month=[[myArray objectAtIndex:1] intValue];
	
	switch (month) 
	{
		case 1:
			
			return [@"Jan " stringByAppendingString:[myArray objectAtIndex:0]];
		case 2:
			
			return [@"Feb " stringByAppendingString:[myArray objectAtIndex:0]];
		case 3:
			
			return [@"Mar " stringByAppendingString:[myArray objectAtIndex:0]];
		case 4:
			
			return [@"Apr " stringByAppendingString:[myArray objectAtIndex:0]];
		case 5:
			
			return [@"May " stringByAppendingString:[myArray objectAtIndex:0]];
		case 6:
			
			return [@"Jun " stringByAppendingString:[myArray objectAtIndex:0]];
		case 7:
			
			return [@"Jul " stringByAppendingString:[myArray objectAtIndex:0]];
		case 8:
			
			return [@"Aug " stringByAppendingString:[myArray objectAtIndex:0]];
		case 9:
			
			return [@"Sep " stringByAppendingString:[myArray objectAtIndex:0]];
		case 10:
			
			return [@"Oct " stringByAppendingString:[myArray objectAtIndex:0]];
		case 11:
			
			return [@"Nov " stringByAppendingString:[myArray objectAtIndex:0]];
		case 12:
			
			return [@"Dec " stringByAppendingString:[myArray objectAtIndex:0]];
	}
	return @"";
	
}


#pragma mark Local Button Action Methods

-(void)btn_starAction:(id)sender
{
	intTagValue = 0;
	intTagValue = [sender tag];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Choose a category to make a favorite?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Company", @"Event", nil];
	alert.tag = 1234;
	[alert show];
	[alert release];	
}

-(void)btn_FavDelete:(id)sender
{
    intTagValue = 0;
	intTagValue = [sender tag];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to remove this event form favorite events?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
	alert.tag = 1235;
	[alert show];
	[alert release];
}

-(void)btn_shareAction:(id)sender
{
	objEvent=[arrListingEvents objectAtIndex:[sender tag]];
	
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 400;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
	
}

-(void)ListBtn_Clicked:(UIButton *)btn
{
	
    if (![selectedView isEqualToString:@"List"]) {
        [arrListingEvents removeAllObjects];
        
       
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        if (![selectedDate length]) {
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *today1 = [NSDate date];
           // selectedDate = [dateFormat stringFromDate:today1];
            selectedDate = [[NSString alloc]initWithFormat:@"%@",[dateFormat stringFromDate:today1]];

        }
        else 
        {
            NSDate *today1 = datePicker.date;
            [dateFormat setDateFormat:@"d"];
            NSString *dateString11 = [dateFormat stringFromDate:today1];
            NSLog(@"selected data fro picker %@",dateString11);
            NSString *selectedDay = [NSString stringWithFormat:@"%i/%i/%i",[dateString11 integerValue],currentMonth,currentYear];
            NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
            [dtFormatter setDateFormat:@"dd/M/yyyy"];
            NSDate *date = [dtFormatter dateFromString:selectedDay];
            
            [dtFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate123 = [dtFormatter stringFromDate:date];
            selectedDate = [[NSString alloc]initWithFormat:@"%@",strDate123];
            
            [dtFormatter release];
        }

        NSPredicate *pred_Date = [NSPredicate predicateWithFormat:@"event_start_date == %@ ",selectedDate];
        NSArray *arr = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred_Date];
        [arrListingEvents  addObjectsFromArray:arr];
		
       
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *today1 = [dateFormat dateFromString:selectedDate];
        [dateFormat setDateFormat:@"d"];
        NSString *dateString11 = [dateFormat stringFromDate:today1];
        lbl_Date.text = [self getDate:dateString11];
        [dateFormat release];
        
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"MMM"];
        lbl_Month.text = [dateFormat1 stringFromDate:today1];
        [dateFormat1 release];
        
		
        selectedView = @"List";
        keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
        [vwSearchCal removeFromSuperview];
        searching=YES;
        
        
        [btnList setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list_btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
        [btnCal setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cal_btn_" ofType:@"png"]] forState:UIControlStateNormal];
        
        vwCalender.hidden = YES;
        vwList.hidden = NO;
        [vwSearch removeFromSuperview];
        [searchList resignFirstResponder];
        [searchLocationList resignFirstResponder];
        //[search resignFirstResponder];
        
        ////  hilight selected button ////
        for(int i=0;i<[arr_ValTop count];i++)
        {
            
            [(UIButton *)[arr_ValTop objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover1" ofType:@"png"]] forState:UIControlStateNormal];
        }
        [(UIButton *)[arr_ValTop objectAtIndex:0] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
        ////  hilight selected button ////
        
        [tbl_Events reloadData];

    }
 	
}

-(void)CalBtn_Clicked:(UIButton *)btn
{
    
    if (![selectedView isEqualToString:@"Calender"])
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.29];
        [UIView setAnimationDelegate:self];
        picker_walking_hits.frame=CGRectMake(0, 600, 320, 216);
        datePicker.frame=CGRectMake(0, 600, 320, 216);
        keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
        [UIView commitAnimations];
        
        // [self LoadSelectedDateCalender];
        [self performSelectorOnMainThread:@selector(LoadSelectedDateCalender) withObject:nil waitUntilDone:false];
        
        for(int i=0;i<[arr_ValTop count];i++)
        {
            
            [(UIButton *)[arr_ValTop objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover1" ofType:@"png"]] forState:UIControlStateNormal];
        }
        [(UIButton *)[arr_ValTop objectAtIndex:selectedCategoryInCalender] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
        ////  hilight selected button ////
        
        selectedView = @"Calender";
        keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
        
        [arrListingEvents removeAllObjects];
        vwCalender.hidden = NO;
        vwList.hidden = YES;
        [btnCal setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cal_btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
        [btnList setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list_btn" ofType:@"png"]] forState:UIControlStateNormal];
        [vwSearch removeFromSuperview];
        [searchList resignFirstResponder];
        [searchLocationList resignFirstResponder];
        //[search resignFirstResponder];

    }
   }

-(void)cancelBtnTouchUpInside
{
	
	CalenderSearchEnabled = NO;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
	searchList.text = @"";
	searchLocationList.text = @"";
	[search resignFirstResponder];
	[searchList resignFirstResponder];
	[vwSearchCal removeFromSuperview];
	[searchLocationList resignFirstResponder];
	[vwSearch removeFromSuperview];
	[UIView commitAnimations];
}
 -(void)btnFriendclicked:(id)sender
{
 
    
    
    objEvent=[arrListingEvents objectAtIndex:[sender tag]];
    [arrEventFriend removeAllObjects];
    
    NSString *strUsers = objEvent.UserID;
    NSArray *arr = [strUsers componentsSeparatedByString:@","];		
    FriendsBL *friendbl = [[FriendsBL alloc]init];
    for (int i=0; i<[arr count]; i++) {
        NSString *fUser = [arr objectAtIndex:i];
        
        
        if ([fUser length] && ![fUser isEqualToString:appDelegate.currentUserID]) {
            
            
            FriendsBO *oneFriend = (FriendsBO *)[friendbl SelectByKey:fUser withMode:YES];
            
            if (oneFriend!=nil) {
                [arrEventFriend addObject:oneFriend];
            }
        
            oneFriend=nil;
        }
    }
    [friendbl release];
    
    
    
    
	if ([arrEventFriend count]) {
  		[self popUpFriendListView];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No friend is attending this event." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
 		[alert show];
		[alert release];	
	}

}

-(void)backButtonPressed{
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) logoutBtn_Clicked:(id) sender
{

	for(UIViewController *viewCont in appDelegate.navigationController.viewControllers)
	{
		if([viewCont isKindOfClass:[HomeViewController class]])
		{
			[appDelegate.navigationController popToViewController:viewCont animated:NO];
			break;
		}
	}
	[appDelegate removeTabBar];
}

-(void)dayeventbtnClicked:(id)sender
{
	EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
	eventVC.objEvent = [self.arr_Events objectAtIndex:[sender tag]];
	[self.navigationController pushViewController:eventVC animated:YES];
	[eventVC release];
}

#pragma mark IBAction Methods

-(IBAction)goToNextMonth:(UIButton *)sender
{
	self.currentMonth++;
	if(self.currentMonth==13)
	{	self.currentYear++;
		self.currentMonth=1;
	}
	if(self.currentLastDay==7)
		self.currentLastDay=0;
	self.currentFirstDay=self.currentLastDay+1;	
	
 	//self.currentLastDay = view1.currentLastDay;
	
 	[UIView beginAnimations: nil context: nil]; 
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(nextDone)];
	[UIView commitAnimations];
	
}
-(IBAction)goToPreviousMonth2:(UIButton *)sender
{
	appDelegate.window.userInteractionEnabled = YES;
    [self loadAnimation];
    //[NSThread detachNewThreadSelector:@selector(PreviousMonth) toTarget:self withObject:Nil];
    [self performSelectorOnMainThread:@selector(PreviousMonth) withObject:nil waitUntilDone:false];
}

-(void)PreviousMonth
{
    currentMonth = view2.currentMonth;
	currentYear = view2.currentYear;
	currentLastDay = view2.currentLastDay;
	currentFirstDay = view2.currentFirstDay;
	self.currentMonth--;
	if(self.currentMonth==0)
	{
		self.currentMonth=12;
		self.currentYear--;
	}
	[self getFirstDay:self.currentMonth dayfirst:self.currentFirstDay ofView:view2];
	
	
	NSString *aStr =[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];
    
	self.currentLastDay = view2.currentLastDay;
	monthLabel2.text = aStr;
	
	
	[UIView beginAnimations: nil context: nil]; 
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(prevDone)];	
	
	[UIView commitAnimations];
    [self removeSyncLoader];
    
    
    
}

-(void)prevDone
{
	
	appDelegate.window.userInteractionEnabled = YES;
}

-(IBAction)goToNextMonth2:(UIButton *)sender
{
	appDelegate.window.userInteractionEnabled = YES;
    [self loadAnimation];
    //[NSThread detachNewThreadSelector:@selector(NextMonth) toTarget:self withObject:Nil];
    [self performSelectorOnMainThread:@selector(NextMonth) withObject:nil waitUntilDone:false];
    
}


-(void)NextMonth
{
    
    currentMonth = view2.currentMonth;
	currentYear = view2.currentYear;
	currentLastDay = view2.currentLastDay;
	currentFirstDay = view2.currentFirstDay;
	self.currentMonth++;
	if(self.currentMonth==13)
	{	self.currentYear++;
		self.currentMonth=1;
	}
	if(self.currentLastDay==7)
		self.currentLastDay=0;
	self.currentFirstDay=self.currentLastDay+1;	
	
	
	NSString *aStr =[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];
    
	self.currentLastDay = view2.currentLastDay;
	monthLabel2.text = aStr;
	
	//self.view1.hidden = NO;
	[UIView beginAnimations: nil context: nil]; 
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(nextDone)];
	[UIView commitAnimations];
    
    [self removeSyncLoader];
    
}

-(void)nextDone
{
	appDelegate.window.userInteractionEnabled = YES;
}


-(IBAction) eventButton_onTouchUpInside:(id)sender{
	UIButton *btn = (UIButton *)sender;
	EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
	eventVC.objEvent = [appDelegate.arrFriendEvents objectAtIndex:btn.tag];
	[self.navigationController pushViewController:eventVC animated:YES];
	[eventVC release];
}

-(IBAction)gotohome{
	
	//HomeViewController *cal = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
	//	[self.navigationController pushViewController:cal animated:YES];
	//	[cal release];
}


-(void)pickerViewInterface
{
	picker_walking_hits=[[UIPickerView alloc] init];
	picker_walking_hits.frame=CGRectMake(0, 600, 320, 216);
	picker_walking_hits.backgroundColor = [UIColor clearColor];
	picker_walking_hits.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	picker_walking_hits.showsSelectionIndicator = YES;	
	[self.view addSubview:picker_walking_hits];

	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 600, 320, 216)];
	self.datePicker.datePickerMode = UIDatePickerModeDate;
	self.datePicker.date = [NSDate date];
	[self.datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:self.datePicker];
	
	keyboardToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 644, 320, 44)];
	keyboardToolBar.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
	keyboardToolBar.items=[[[NSArray alloc]initWithObjects:space,done,nil]autorelease];
	[self.view addSubview:keyboardToolBar];
    [space release];
    [done release];
}
-(IBAction)btn_CalenderAction
{
	[self addDatePicker];
}

-(IBAction)btn_scrlActionTop:(UIButton *)sender
{
 
    
    NSMutableArray *arrSelectedEvents = [[NSMutableArray  alloc]init];
		////  hilight selected button ////
	for(int i=0;i<[arr_ValTop count];i++)
	{
		[(UIButton *)[arr_ValTop objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover1" ofType:@"png"]] forState:UIControlStateNormal];
	}
	[sender setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
    ////  hilight selected button ////
    
    
    
    NSString *categoryId = nil;
    if (sender.tag !=0) {
        categoryId = [[arr_Buttons objectAtIndex:sender.tag] maincategoryid];
    }
    else{
        categoryId = @"All";
    }

    EventCategoryBL *catbl = [[EventCategoryBL alloc]init];
    NSMutableArray *arrCatEvents = [[NSMutableArray alloc]init];
    [arrCatEvents addObjectsFromArray:[catbl SelectAll]];
    [catbl release];
    
    if ([categoryId isEqualToString:@"All"]) {
        for (int i = 0; i<[arrCatEvents count]; i++) {
            
            EventCategoryBO *eventCat = [arrCatEvents objectAtIndex:i];
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"Eventid == %@",eventCat.eventId];
            NSArray *arr1 = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred1];
            if ([arr1 count]) {
                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"Eventid == %@",[[arr1 objectAtIndex:0] Eventid]];
                NSArray *arr2 = [arrSelectedEvents filteredArrayUsingPredicate:pred2];

                if (![arr2 count]) {
                    [arrSelectedEvents addObjectsFromArray:arr1];

                }
            }
            
        }
    }
    else{
         NSPredicate *pred = [NSPredicate predicateWithFormat:@"maincategoryid == %@",categoryId];
        NSArray *arr = [arrCatEvents filteredArrayUsingPredicate:pred];
        
        for (int i = 0; i<[arr count]; i++) {
            
            EventCategoryBO *eventCat = [arr objectAtIndex:i];
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"Eventid == %@",eventCat.eventId];
            NSArray *arr1 = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred1];
            
            if ([arr1 count]) {
                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"Eventid == %@",[[arr1 objectAtIndex:0] Eventid]];
                NSArray *arr2 = [arrSelectedEvents filteredArrayUsingPredicate:pred2];
                
                if (![arr2 count]) {
                    [arrSelectedEvents addObjectsFromArray:arr1];
                    
                }
            }
            
        }
     }
    
    [arrCatEvents release];

    if ([selectedView isEqualToString:@"Calender"]) {
        
        [arrCalernderEvents removeAllObjects];
        [arr_Events removeAllObjects];
        
        [arrCalernderEvents addObjectsFromArray:arrSelectedEvents];
        //[arr_Events addObjectsFromArray:arrSelectedEvents];
        [tableViewEvent reloadData];

        selectedCategoryInCalender = sender.tag;
         NSString *aStr =[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];
        NSLog(@"%@",aStr);
        //[self pushViewEventDetail:@"1"];
    
    }
    else{
        [arrListingEvents removeAllObjects];
         
         NSPredicate *pred_Date = [NSPredicate predicateWithFormat:@"event_start_date == %@ ",selectedDate];
        NSArray *arr = [arrSelectedEvents filteredArrayUsingPredicate:pred_Date];
        [arrListingEvents  addObjectsFromArray:arr];

        [tbl_Events reloadData];
        
        
        
    }
    
    [arrSelectedEvents release];
}

 

        -(IBAction)btn_WalkingtAction
        {
            selected_Picker=1;
            [self addPicker];
            
        }
        -(IBAction)btn_TopHitsAction
        {
            selected_Picker=2;
            [self addPicker];
        }
        
        
        -(IBAction)goToPreviousMonth:(UIButton *)sender
        {
            self.currentMonth--;
            if(self.currentMonth==0)
            {
                self.currentMonth=12;
                self.currentYear--;
            }
            //[self getFirstDay:self.currentMonth dayfirst:self.currentFirstDay ofView:view1];
            
            
            //NSString *aStr = [view1 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear];
           // self.currentLastDay = view1.currentLastDay;
            
            
            [UIView beginAnimations: nil context: nil]; 
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(prevDone)];	
            
            [UIView commitAnimations];
            //[self.tblEvent reloadData];
        }

-(IBAction)dayNavigationEvent:(id)sender
{
	if([sender tag] == 1)
	{
		[self gotoPreviousDay];
	}
	else if ([sender tag] == 2)
	{
		[self gotoNextDay];
	}
}


#pragma mark UITableView delegate and dataSource methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag == 1111 || tableView.tag == 2222){
		return 60;
	}
	else{
		if(tableView.tag == 1)
			return 46;
		else {
			return 80;
		}
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView.tag!=1111 && tableView.tag!=2222){
		if(tableView.tag == 1)
		{
			if([arr_Events count])
				return [arr_Events count];
			else 
				return 1;
		}
		else if(tableView.tag == 2){
			if(searching)
			{
				if([arrListingEvents count])
					return [arrListingEvents count];
				else 
					return 1;
			}
			else
			{
				return [arrEventFriend count];
				
			}
		}
	}
	else{
		return [arrEventFriend count];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(tableView.tag!=1111 && tableView.tag!=2222)
	{
		
		if(tableView.tag == 1)
		{
			if([arr_Events count])
			{
				static NSString *CalenderCell1 = @"CalenderCell1";
				
				TableviewEvent *cell = (TableviewEvent *)[tableView dequeueReusableCellWithIdentifier:CalenderCell1];
				if (cell == nil) {
					cell = [[[TableviewEvent alloc] initWithFrame:CGRectZero reuseIdentifier:CalenderCell1] autorelease];
				}
				
				for(UIView *vw in cell.contentView.subviews)
				{
					if(vw.tag == 9870)
					{
						[vw removeFromSuperview];
					}
				}
				EventListBO *obj = (EventListBO *)[arr_Events objectAtIndex:indexPath.row]; 	
				[cell setTips:obj];
				
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
				UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 2)];
				imgSep.tag = 9870;
				imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"event_seperater" ofType:@"png"]];
				[cell.contentView addSubview:imgSep];
				[imgSep release];
				
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				//[cell showEventsImage];
				return cell;
			}
			else {
				
				static NSString *CalenderCell2 = @"CalenderCell2";
				UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CalenderCell2];
				if(cell == nil)
				{
					cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CalenderCell2] autorelease];
				}
				
				cell.textLabel.text = @"No Events";
				cell.textLabel.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
				cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				return cell;
			}
		}
		else {
			
			if(searching)
			{
				tableView.separatorColor = [UIColor clearColor];
				
				if([arrListingEvents count])
				{
					
					static NSString *CalenderCell3 = @"CalenderCell3";
					EventsListCustomCell *cell = (EventsListCustomCell *)[tableView dequeueReusableCellWithIdentifier:CalenderCell3];
					if(cell == nil)
					{
						cell = [[[EventsListCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CalenderCell3] autorelease];
					}
					EventListBO *obj_ = [arrListingEvents objectAtIndex:indexPath.row];
					
                    [cell setTheEventInTheCell:obj_];
                    
                  /*  NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
                    BOOL isEventExists = NO;
                    if([arrEvents count] && !isEventExists)
                    {
                        NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[obj_.Eventid integerValue]];
                        [arrEvents filterUsingPredicate:predic];
                        if([arrEvents count])
                        {
                            isEventExists = YES;
                        }
                        
                    }
                    
                    NSMutableArray *arrFavBusObjects = [UserFavBussLayer SelectAllBusinessEventsByKey:[appDelegate.currentUserID integerValue]];
                    BOOL isFavBusExists = NO;
                    if([arrFavBusObjects count] && !isFavBusExists)
                    {
                        NSPredicate *predic = [NSPredicate predicateWithFormat:@"BusinessId ==%i",[obj_.business integerValue]];
                        [arrFavBusObjects filterUsingPredicate:predic];
                        if([arrFavBusObjects count])
                        {
                            isFavBusExists = YES;
                        }
                        
                    }

                    
                    
                    
                    
                    if(isEventExists && isFavBusExists)
                    {
                        [playbtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
                        
                        [playbtn addTarget:self action:@selector(btn_FavDelete:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    else
                    {*/
                        
                        cell.btn_star.hidden = YES;
                        
                        
                        UIButton *playbtn = [[UIButton alloc]initWithFrame:CGRectMake(205,45,41,26)];
                        playbtn.tag=indexPath.row + 100;
                        
                        [playbtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
                        
                        [playbtn addTarget:self action:@selector(btn_starAction:) forControlEvents:UIControlEventTouchUpInside];
                        
                   // }
                    
                    [cell.contentView addSubview:playbtn];
                    [playbtn release];
                    
                    cell.btn_favourite.tag = indexPath.row;
                    [cell.btn_favourite addTarget:self action:@selector(btn_shareAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.btnFriend.tag = indexPath.row;
                    [cell.btnFriend addTarget:self action:@selector(btnFriendclicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    cell.backgroundColor = [UIColor clearColor];
                    [cell setArticle:obj_];         
					return cell;
				}
				else {
					static NSString *CalenderCell4 = @"CalenderCell4";
					UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CalenderCell4];
					if(cell == nil)
					{
						cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
													 reuseIdentifier:CalenderCell4] autorelease];
					}
					
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.textLabel.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
					cell.textLabel.textAlignment = UITextAlignmentCenter;
					cell.textLabel.text = @"No Event";
					return cell;
				}
			}
			else
			{
				static NSString *CalenderCell5 = @"CalenderCell5";
				EventsListCustomCell *cell = (EventsListCustomCell *)[tableView dequeueReusableCellWithIdentifier:CalenderCell5];
				
				if(cell == nil)
				{
					cell = [[[EventsListCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CalenderCell5] autorelease];
				}
				obj_Event=[appDelegate.arrFriendEvents objectAtIndex:indexPath.row];
				cell.lbl_Title.text=obj_Event.name; //@"Bodies The Exhibition";
				cell.lbl_Date.text= obj_Event.event_start_date; 

				if([obj_Event.UserID length])
				{
					NSArray *arr = [obj_Event.UserID componentsSeparatedByString:@" "];					
					cell.lbl_fnds.text=[NSString stringWithFormat:@"%i friends", [arr count]-1];
				}	
				else {
					cell.lbl_fnds.text=[NSString stringWithFormat:@"No friend"];
				}
				
                
               /* NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
                BOOL isEventExists = NO;
                if([arrEvents count] && !isEventExists)
                {
                    NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[obj_Event.Eventid integerValue]];
                    [arrEvents filterUsingPredicate:predic];
                    if([arrEvents count])
                    {
                        isEventExists = YES;
                    }
                    
                }
                
                NSMutableArray *arrFavBusObjects = [UserFavBussLayer SelectAllBusinessEventsByKey:[appDelegate.currentUserID integerValue]];
                BOOL isFavBusExists = NO;
                if([arrFavBusObjects count] && !isFavBusExists)
                {
                    NSPredicate *predic = [NSPredicate predicateWithFormat:@"BusinessId ==%i",[obj_Event.business integerValue]];
                    [arrFavBusObjects filterUsingPredicate:predic];
                    if([arrFavBusObjects count])
                    {
                        isFavBusExists = YES;
                    }
                    
                }

                
                UIButton *playbtn = [[UIButton alloc]initWithFrame:CGRectMake(205,45,41,26)];
                playbtn.tag=indexPath.row + 100;
                
                if(isEventExists && isFavBusExists)
				{
					[playbtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
                    
                    [playbtn addTarget:self action:@selector(btn_FavDelete:) forControlEvents:UIControlEventTouchUpInside];
                    
				}
				else
				{*/
                
                UIButton *playbtn = [[UIButton alloc]initWithFrame:CGRectMake(205,45,41,26)];
                playbtn.tag=indexPath.row + 100;
                
					[playbtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
                    
                    [playbtn addTarget:self action:@selector(btn_starAction:) forControlEvents:UIControlEventTouchUpInside];
					
				//}
                
                [cell.contentView addSubview:playbtn];
                [playbtn release];
				
                
                
                cell.btn_star.hidden = YES;

                
				
				
				[cell.btn_favourite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"share" ofType:@"png"]] forState:UIControlStateNormal];
				[cell.btn_favourite addTarget:self action:@selector(btn_shareAction:) forControlEvents:UIControlEventTouchUpInside];
				cell.btn_favourite.tag = indexPath.row;
				cell.scrl_Images.contentSize=CGSizeMake([appDelegate.arr_AllFriend count]*30,25);
				cell.btnFriend.tag = indexPath.row;
				[cell.btnFriend addTarget:self action:@selector(btnFriendclicked:) forControlEvents:UIControlEventTouchUpInside];
				
				cell.scrl_Images.scrollEnabled = FALSE;
	 

				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				
				[cell setArticle:obj_Event];
				//[cell showEventsImage];
				
				return cell;
			}
		}
	}
	else {
		
		if([arrEventFriend count])
		{
			static NSString *CalenderCell6 = @"CalenderCell6";
			FriendsBO *obj =  [arrEventFriend objectAtIndex:indexPath.row]; 	
			
			FriendTableCell *cell = (FriendTableCell *)[tableView dequeueReusableCellWithIdentifier:CalenderCell6];
			if (cell == nil) {
				cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CalenderCell6] autorelease];
 			}
           // cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.imgViewDarkBG.image = nil;
			cell.imgViewDarkBG.frame = CGRectMake(0, 0, 320, 60);
			cell.imgViewDarkBGSel.frame = CGRectMake(0, 0, 320, 60);
            cell.imgViewEvent.frame = CGRectMake(10, 5, 50, 50);
            
            cell.lblTitle.frame = CGRectMake(70, 12, 170, 30);
            cell.lblTitle.textColor = [UIColor whiteColor];
            cell.lblTitle.backgroundColor = [UIColor clearColor];
            
            if(tableView.tag == 2222){
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.imgViewDarkBG.image = nil;
                cell.btnAdd.hidden=NO;
                cell.btnAdd.tag = indexPath.row;
                cell.btnAdd.frame = CGRectMake(240, 12, 30, 30);
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"FriendId == %@",obj.FriendId];
                NSArray *arr = [arrFriendEmails filteredArrayUsingPredicate:pred];
                
                if ([arr count]) {
                    [cell.btnAdd setImage:[UIImage imageNamed:@"rite_active.png"] forState:UIControlStateNormal];
                }
                else{
                    [cell.btnAdd setImage:[UIImage imageNamed:@"select_enable.png"] forState:UIControlStateNormal];
                }
                [cell.btnAdd addTarget:self action:@selector(addFriendToSendmail:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else{
                cell.btnAdd.hidden=YES;
                
                
            }
            
            
			[cell setTips:obj];
			[cell showUserImage];
			return cell;
		}
		else
		{
			static NSString *CalenderCell7 = @"CalenderCell7";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CalenderCell7];
			if(cell == nil)
			{
				cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CalenderCell7] autorelease];
			}
			
			cell.textLabel.text = @"No Event Friend";
			[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.textLabel.textColor = [UIColor whiteColor];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.backgroundColor = [UIColor clearColor];
			return cell;
		}
	}

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(tableView.tag!=1111 && tableView.tag!=2222)
    {
		if(tableView.tag == 1)
		{
			if([arr_Events count])
                [(TableviewEvent *)cell showEventsImage];
			
		}
		else if(tableView.tag == 2)
        {
			if(searching)
			{
				if([arrListingEvents count])
					[(EventsListCustomCell *)cell showEventsImage];
			}
			else
			{
                if([appDelegate.arrFriendEvents count])
                    [(EventsListCustomCell *)cell showEventsImage];
				
			}
		}
	}
    else 
    {
        if([arrEventFriend count])
            [(FriendTableCell *)cell showUserImage];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(tableView.tag!=1111 && tableView.tag!=2222)
	{
		
		if(tableView.tag == 1)
		{
			if([arr_Events count])
			{
				EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 				eventVC.objEventList = [arr_Events objectAtIndex:indexPath.row];
 				[self.navigationController pushViewController:eventVC animated:YES];
				[eventVC release];
			}
		}
		else {
			
			if(searching)
			{
				if([arrListingEvents count])
				{
					EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 					eventVC.objEventList = [arrListingEvents objectAtIndex:indexPath.row];
 					[self.navigationController pushViewController:eventVC animated:YES];
					[eventVC release];
				}
			}
			else {
				
				EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 				eventVC.objEventList = [appDelegate.arrFriendEvents objectAtIndex:indexPath.row];
 				[self.navigationController pushViewController:eventVC animated:YES];
				[eventVC release];
			}
			
		}
	}
	else if(tableView.tag==2222){
	
        }
	else 
	{
		FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
		objFriendDet.objFriend = [arrEventFriend objectAtIndex:indexPath.row];
		[self.navigationController pushViewController:objFriendDet animated:YES];
		[objFriendDet release];
	}
	
	
}


#pragma mark UITextField delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	keyboardToolBar1.frame=CGRectMake(0, 200, 320, 44);
	[UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29f];	
	keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
	[UIView commitAnimations];	
	
	return [textField resignFirstResponder];
}

#pragma mark UISearchBar delegate



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	[search setShowsCancelButton:YES animated:YES];
	return YES;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	if(searchBar.tag == 3) 
	{
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"name contains[cd] %@",searchBar.text];
		NSArray *arr = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred];
		if([arrCalernderEvents count])
			[arrCalernderEvents removeAllObjects];
		if([arr count])
			[arrCalernderEvents addObjectsFromArray:arr];
		
		//NSLog(@"arrCalernderEvents count %i",[arrCalernderEvents count]);
		
		[arr_Events removeAllObjects];
		[tableViewEvent reloadData];
		//[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear];
		
		[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];
		[searchBar resignFirstResponder];
		[vwSearchCal removeFromSuperview];
	}
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	if(searchBar.tag == 3)
	{
		if([arrCalernderEvents count])
			[arrCalernderEvents removeAllObjects];
		[arrCalernderEvents addObjectsFromArray:appDelegate.arrFriendEvents];
		[arr_Events removeAllObjects];
		[tableViewEvent reloadData];
		//[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear];
		[view2 fillCalender:self.currentMonth weekStarts:self.currentFirstDay year:self.currentYear withEvents:arrCalernderEvents];

		[searchBar resignFirstResponder];
		searchBar.text = @"";
		[vwSearchCal removeFromSuperview];
	}
	
}



#pragma mark UIActionSheet and MFMailComposeViewController



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1234)
	{
        if (searching)
        {
            objEvent=[arrListingEvents objectAtIndex:intTagValue-100];
        }
        else 
        {
            objEvent=[appDelegate.arrFriendEvents objectAtIndex:intTagValue-100];
        }
        
        if(buttonIndex==0)
        {
            [self loadAddFavrXml:objEvent forCompany:YES];
        }
        else if(buttonIndex==1)
        {
            [self loadAddFavrXml:objEvent forCompany:NO];
        }
        
    }
    else if(alertView.tag == 1235)
    {
        if (searching)
        {
            objEvent=[arrListingEvents objectAtIndex:intTagValue-100];
        }
        else 
        {
            objEvent=[appDelegate.arrFriendEvents objectAtIndex:intTagValue-100];
        }
        
        NSMutableArray *arrEvents = [UserFavBussLayer SelectfavEventsByKey:[objEvent.Eventid integerValue]];
        
        if(buttonIndex==0)
        {
            [self deletefavevent:[arrEvents objectAtIndex:0]];
            
        }
    }
}


-(void)loadAddFavrXml:(EventListBO*)evnts forCompany:(BOOL)isCmpnyREvnt
{
	//fetching all favouties of the company for the user id
	if(isCmpnyREvnt)
	{
		NSMutableArray *arrFavBusObjects = [UserFavBussLayer SelectAllBusinessEventsByKey:[appDelegate.currentUserID integerValue]];
		BOOL isEventExists = NO;
		if([arrFavBusObjects count] && !isEventExists)
		{
			NSPredicate *predic = [NSPredicate predicateWithFormat:@"BusinessId ==%i",[evnts.business integerValue]];
			[arrFavBusObjects filterUsingPredicate:predic];
			if([arrFavBusObjects count])
			{
				isEventExists = YES;
			}
			
		}
		if(isEventExists)
		{
			[self showAlerts:@"Selected business is already added as favorites."];
		}
		else
		{
			UserFavBussLayer.objFavBusEvtBO = nil;
			FavoriteBusinessEventBO *objAddFav = [[FavoriteBusinessEventBO alloc]init];
			objAddFav.UserId     = [appDelegate.currentUserID integerValue];
			objAddFav.BusinessId = [evnts.business integerValue];
			UserFavBussLayer.objFavBusEvtBO = objAddFav;
			[objAddFav release];
			UserFavBussLayer.strSopForAddBussinessEvnt = [NSString stringWithFormat:@
														  "<useraccount >\n"
														  "<id>%i</id>\n"   
														  "<fav_businesses>\n"
														  "<business>\n"
														  "<businessid>%i</businessid>\n"  
														  "</business>\n"
														  "</fav_businesses>\n"
														  "</useraccount >\n",[appDelegate.currentUserID intValue],[evnts.business intValue]];
			[UserFavBussLayer addFavoriteBusiness];
			
		}
	}
	else
	{
		NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
		BOOL isEventExists = NO;
		if([arrEvents count] && !isEventExists)
		{
			NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[evnts.Eventid integerValue]];
			[arrEvents filterUsingPredicate:predic];
			if([arrEvents count])
			{
				isEventExists = YES;
			}
			
		}
		if(isEventExists)
		{
			[self showAlerts:@"Event selected is already added to Palendar."];
		}
		else
		{
			UserFavBussLayer.addFavEvnt = nil;
			AddFavEventBO *objAddFav = [[AddFavEventBO alloc]init];
			objAddFav.UserId = [appDelegate.currentUserID integerValue];
			objAddFav.EventId = [evnts.Eventid integerValue];
			UserFavBussLayer.addFavEvnt = objAddFav;
			[objAddFav release];
			UserFavBussLayer.strSopForAddEvent = [NSString stringWithFormat:@
												  "<useraccount >\n"
												  "<id>%i</id>\n"   
												  "<events>\n"
												  "<event>\n"
												  "<eventid>%i</eventid>\n"  
												  "</event>\n"
												  "</events>\n"
												  "</useraccount >\n",[appDelegate.currentUserID intValue],[evnts.Eventid intValue]];
			[UserFavBussLayer loadFavoriteEvent];
			
		}
	}
}

-(void)deletefavevent:(AddFavEventBO*)evnts
{
    
/*    
    UserFavBussLayer.strSopForDeleteEvnt = [NSString stringWithFormat:@
                                            "<useraccount >\n"
                                            "<id>%i</id>\n"   
                                            "<events>\n"
                                            "<event>\n"
                                            "<addedeventid>%i</addedeventid>\n"  
                                            "</event>\n"
                                            "</events>\n"
                                            "</useraccount >\n",[appDelegate.currentUserID intValue],evnts.UserAddedEventId];
    
    
    [UserFavBussLayer deleteFavorite];
    */
    
    if(appDelegate.isNetAvail)
	{
		HttpRequest *request = [[HttpRequest alloc] init];
 		[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/events/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],evnts.UserAddedEventId] Delegate:self Tag:10];
  		[request release];		
		
	}
}

-(void)httpResponseReceived:(WebResponse *)response
{
	
	
	NSString *strMsg = @"";
	
    if (response.tag == 10)
	{
		if (!response.isError)
		{
            NSString *responseString = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
            NSLog(@"responseStringdelet  %@",responseString);
			responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding='utf-8'?><useraccount><results><result>" withString:@""];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"</result><results></useraccount>" withString:@""];
			
			NSInteger isFaventdeleted = 0;
			
			if(![responseString isEqualToString:@"0"] && ![responseString isEqualToString:@"1"] && ![responseString isEqualToString:@"-2"] &&  [responseString length])
			{
				strMsg = @"Selected event is successfully removed from favorite events.";
			}
			if([responseString isEqualToString:@"0"])
			{
				strMsg = @"Selected event is already removed from favorite events.";
			}
			if([responseString isEqualToString:@"1"] || [responseString isEqualToString:@"-2"])
			{
				strMsg = @"Error while removing selected event from favorite events.";
			}
		}
		else 
		{
            strMsg = @"Error while removing selected event from favorite events.";
		}
		
		[self FavoriteEventDeletCompleted:strMsg];
    }
    
}

#pragma mark -
#pragma mark  FavoriteEventUpload to sever delegate FUNCTIONs
#pragma mark -

-(void)FavoriteBusinessLoadingCompleted:(NSMutableArray *)arrFriends
{
}

-(void)addingFavDidComplete:(NSString*)strMsgs
{
    NSRange rangeIs = [strMsgs rangeOfString:@"successfully" options:NSCaseInsensitiveSearch];
    if(rangeIs.length > 11)
    {
        NSMutableArray *arrEvents = [UserFavBussLayer SelectfavEventsByKey:[objEvent.Eventid integerValue]];
        
        UserFavEvents *addFav   = [[UserFavEvents alloc]init];
        AddFavEventBO *objAddFav = [arrEvents objectAtIndex:0];
        addFav.strEventId = [NSString stringWithFormat:@"%i",objAddFav.EventId];
        addFav.strUserAddedEventId = [NSString stringWithFormat:@"%i",objAddFav.UserAddedEventId];
        [appDelegate.arr_FavoritesID addObject:addFav];
        [addFav release];
    }
	[self showAlerts:strMsgs];
}

-(void)FavoriteBusinessEventsLoadingCompleted:(NSString*)strMsgs
{
	[self showAlerts:strMsgs];
}

-(void)FavoriteEventDeletCompleted:(NSString*)strMsgs
{
    NSRange rangeIs = [strMsgs rangeOfString:@"successfully" options:NSCaseInsensitiveSearch];
    if(rangeIs.length > 11)
    {
        for(int k = 0 ; [appDelegate.arr_FavoritesID count] > k ; k++)
        {
            NSString *tempid = [[appDelegate.arr_FavoritesID objectAtIndex:k] strEventId];
            if([tempid isEqualToString:objEvent.Eventid])
            {
                [UserFavBussLayer DeletefavEventsByKey:[tempid integerValue]];
                [appDelegate.arr_FavoritesID removeObjectAtIndex:k];
                break;
            }
            
        }
    }
    
	[self showAlerts:strMsgs];
}

-(void)showAlerts:(NSString*)strMsg
{
    [tbl_Events reloadData];
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
}
	

-(void)eventFrienDownload
{
	EventFriendListBL *EventFriendLayer = [[EventFriendListBL alloc]init];
	EventFriendLayer.delegate = self;
	[EventFriendLayer deleteAll];
	[EventFriendLayer LoadUser:objEvent.UserID];
    [EventFriendLayer release];
}

-(void)LoadEventFriendLoadingCompleted
{
	EventFriendListBL *EventFrLayer = [[EventFriendListBL alloc]init];
	EventFrLayer.delegate = self;
	[self.arrEventFriend removeAllObjects];
	self.arrEventFriend = [EventFrLayer SelectAll];
	
	if(intActionTag == 100)
	{
		if([arrEventFriend count])
			[self popUpMail];
		else {
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Event Friend." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
	else if(intActionTag == 101)
	{
		if([arrEventFriend count])
			[self sendRecomendations:arrEventFriend];
		else {
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Event Friend." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
	}
	else if(intActionTag == 1000)
	{
		if([arrEventFriend count])
			[self popUpFriendListView];
		else {
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No Event Friend." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
	}
    [EventFrLayer release];
	[self removeSyncLoader];
}
 
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if(actionSheet.tag == 400 || actionSheet.tag == 401)
	{
		if(buttonIndex == 0){
            [arrEventFriend removeAllObjects];
			FriendsBL *friendbl = [[FriendsBL alloc]init];
			[arrEventFriend addObjectsFromArray:[friendbl SelectAll]];
			[friendbl release];
			if ([arrEventFriend count]) {
                [self popUpMail];
			}
            
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have no friends." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];	
            }
		}
		
		if (buttonIndex == 1) {
            
			intActionTag = buttonIndex+100;
			
			FriendsBL *friendbl = [[FriendsBL alloc]init];
			[arrEventFriend addObjectsFromArray:[friendbl SelectAll]];
			[friendbl release];
			if ([arrEventFriend count]) {
				[self sendRecomendations:arrEventFriend];
			}
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have no friends." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            
			
 			//[self eventFrienDownload];
		}
		else if (buttonIndex == 2) 
		{
			
			if([arrFriendEmails count])
				[arrFriendEmails removeAllObjects];
			
			[self sendMail:arrFriendEmails];
			
		}
		else if (buttonIndex == 3) {
            
#if !TARGET_IPHONE_SIMULATOR
			MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            
            picker.recipients = [NSArray arrayWithObject:@"23234567"];  
            picker.body = @"iPhone OS4";
            
            [self presentModalViewController:picker animated:YES];
            [picker release];
#endif
            
		}
        else if (buttonIndex == 4) {
			
		}
		
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	
	switch (result)
	{
		case MessageComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			NSLog(@"Result: sent");
			break;
		case MessageComposeResultFailed:
			NSLog(@"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
	
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	if([arrFriendEmails count])
	[arrFriendEmails removeAllObjects];

	if(result == MFMailComposeResultCancelled)
		NSLog(@"Mail Cancelled");
	if(result == MFMailComposeResultSaved)
		NSLog(@"Mail Saved");
	if(result == MFMailComposeResultSent)
	{
		UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:nil message:@"Your mail has been sent successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
		NSLog(@"Mail Sent");
	}
	if(result == MFMailComposeResultFailed)
	{
		NSLog(@"failed sending mail");	
	};
	[self dismissModalViewControllerAnimated:YES];
}




#pragma mark UIPickerView Methods

-(void)addDatePicker
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	datePicker.frame = CGRectMake(0, 204, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 160, 320, 44);
	[UIView commitAnimations];
}

-(void)datePickerAction:(id)sender
{
	selected_Picker=3;
	
	dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"dd/M/yyyy"];
	NSLog(@"selected Date:%@",[dateForm stringFromDate:datePicker.date]);
	//[dateForm release];
}


-(void)filterBtnClicked:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	[arr_picker removeAllObjects];
	if(btn.tag == 100)
		[arr_picker addObjectsFromArray:arr_filter1];
	else if(btn.tag == 101)
		[arr_picker addObjectsFromArray:arr_filter2];
	//[self showPicker];
}

-(void)showPicker
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	toolBar.frame = CGRectMake(0, 156, 320, 44);
	[UIView commitAnimations];
	
}

-(void)hidePicker
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	toolBar.center = CGPointMake(160,600);
	[UIView commitAnimations];
}

-(void)cancelClicked
{
	[self hidePicker];
}

-(void)doneClicked
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	picker_walking_hits.frame=CGRectMake(0, 600, 320, 216);
	datePicker.frame=CGRectMake(0, 600, 320, 216);
	
	if(	selected_Picker==3)
	{
        NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
        [dtFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *strDate123 = [dtFormatter stringFromDate:datePicker.date];
 		selectedDate = [[NSString alloc]initWithFormat:@"%@",strDate123];
 		searching=YES;
   		
        [arrListingEvents removeAllObjects];
        
        NSPredicate *pred_Date = [NSPredicate predicateWithFormat:@"event_start_date == %@ ",selectedDate];
        NSArray *arr = [appDelegate.arrFriendEvents filteredArrayUsingPredicate:pred_Date];
        [arrListingEvents  addObjectsFromArray:arr];
          
        
		NSDate *today1 = datePicker.date;
 		[dtFormatter setDateFormat:@"d"];
		NSString *dateString11 = [dtFormatter stringFromDate:today1];
		lbl_Date.text = [self getDate:dateString11];
 		
 		[dtFormatter setDateFormat:@"MMM"];
		lbl_Month.text = [dtFormatter stringFromDate:today1];
		[dtFormatter release];
		[tbl_Events reloadData];
        
        
        ////  hilight selected button ////
        for(int i=0;i<[arr_ValTop count];i++)
        {
       
            [(UIButton *)[arr_ValTop objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover1" ofType:@"png"]] forState:UIControlStateNormal];
        }
        [(UIButton *)[arr_ValTop objectAtIndex:0] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
        ////  hilight selected button ////
        

        
        
	}
	else if(selected_Picker==2)
	{
        
    }
    else if(selected_Picker==2)
	{
        
    }
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	[UIView commitAnimations];
    
    
    if(selected_Picker == 3)
    {
        if(![arrListingEvents count])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No events found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
    }
}

-(void)todayButtonAction
{
	//self.currentLastDay = view1.currentLastDay;
	self.currentMonth = self.currentMonthConstant;
	self.currentYear = self.currentYearConstant;
	self.currentFirstDay = todayConstant;
}

-(void)LoadCalender
{
    
   
    
 	NSString *aVal =[view2 fillCalender:self.currentMonthConstant weekStarts:self.todayConstant year:self.currentYearConstant withEvents:arrCalernderEvents];

	self.currentLastDay = view2.currentLastDay;
	monthLabel2.text = aVal;
    
    //view1.hidden = YES;
	view2.hidden = NO;
	calHeaderView2.hidden = NO;
    
   
}

-(void)LoadSelectedDateCalender
{
    [self loadAnimation];
    
    
    NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
	[dtFormatter setDateFormat:@"yyyy-MM-dd"];
    [dtFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
	
	NSDate	*selectedToDate=[dtFormatter dateFromString:selectedDate];
    [dtFormatter release];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:( NSWeekdayCalendarUnit | 
												   NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:selectedToDate];
	NSInteger weekdayInteger=[comps weekday];
	NSInteger currentMonth1=[comps month];	
	NSInteger currentYear1=[comps year];	
	NSString *dateString=[[NSString stringWithFormat:@"%@",selectedToDate] substringToIndex:10];
    NSArray *array= [dateString componentsSeparatedByString:@"-"];
	NSInteger currentDay1=[[array objectAtIndex:2] intValue];
	NSInteger  currentMonth2=currentMonth1;
	NSInteger currentYear2=currentYear1;
    NSInteger currentFirstDay1=((8+weekdayInteger-(currentDay1%7))%7);
	if(currentFirstDay1==0)
		currentFirstDay1=7;
	[gregorian release];
    
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
	[dfDate setDateFormat:@"dd"];
	NSInteger selectedcurrentDayRunning = [[dfDate stringForObjectValue:selectedToDate]intValue];
	[dfDate release];
    
    
 	NSString *aVal =[view2 fillCalendertoDate:currentMonth2 weekStarts:currentFirstDay1 year:currentYear2 SelectedDate:selectedcurrentDayRunning withEvents:arrCalernderEvents];
    
	self.currentLastDay = view2.currentLastDay;
	monthLabel2.text = aVal;
    
   // view1.hidden = YES;
	view2.hidden = NO;
	calHeaderView2.hidden = NO;
    
    currentMonth = currentMonth2;
    currentYear = currentYear2;
    
   /* NSDateFormatter *dtFormatter2 = [[NSDateFormatter alloc] init];
    [dtFormatter2 setDateFormat:@"dd/M/yyyy"];
    NSString *TempDate = [dtFormatter2 stringFromDate:selectedToDate];
    [dtFormatter2 release];
    
    [self pushViewEventDetail:TempDate];*/
    
    [self removeSyncLoader];
}

-(void)setCalendar
{
	self.currentDate=[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:( NSWeekdayCalendarUnit | 
												   NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:currentDate];
	NSInteger weekdayInteger=[comps weekday];
	currentMonth=[comps month];	
	currentYear=[comps year];	
	NSString *dateString=[[NSString stringWithFormat:@"%@",currentDate] substringToIndex:10];
    NSArray *array= [dateString componentsSeparatedByString:@"-"];
	NSInteger currentDay=[[array objectAtIndex:2] intValue];
	currentMonthConstant=currentMonth;
	currentYearConstant=currentYear;
	currentDayConstant=currentDay;
    currentFirstDay=((8+weekdayInteger-(currentDay%7))%7);
	if(currentFirstDay==0)
		currentFirstDay=7;
	[gregorian release];
	
	NSDateFormatter *dfWeekDay = [[NSDateFormatter alloc] init];
	[dfWeekDay setDateFormat:@"e"];
	currentWeekDay = [[dfWeekDay stringForObjectValue:[NSDate date]]intValue];
	[dfWeekDay release];
	
	NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
	[dfDate setDateFormat:@"d"];
	currentDayRunning = [[dfDate stringForObjectValue:[NSDate date]]intValue];
	[dfDate release];
}
-(void)getFirstDay:(NSInteger)month dayfirst:(NSInteger)firstday ofView:(CalenderView *)aView
{	
	NSInteger daysinMonth=[aView getNumberofDays:month YearVlue:self.currentYear];
	firstday=firstday-1;
	self.currentFirstDay=(8+firstday-(daysinMonth%7))%7;
	if(self.currentFirstDay==0)
		self.currentFirstDay=7;
}

-(void)addPicker
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	picker_walking_hits.frame = CGRectMake(0, 204, 320, 216);
	picker_walking_hits.delegate = self;
	picker_walking_hits.dataSource = self;
	keyboardToolBar.frame=CGRectMake(0, 160, 320, 44);
	[UIView commitAnimations];
}



#pragma mark UIPickerView delegate and dataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	if(selected_Picker==1)
	{
		return [arr_Walk count];
	}
	else if(selected_Picker==2)
	{
		return [arr_Hits count];
	}
	else {
		return 1;
	}

}


//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if(selected_Picker==1)
	{
		return [arr_Walk objectAtIndex:row];
		
	}
	else if(selected_Picker==2)
	{
		return [arr_Hits objectAtIndex:row];
	}
	else {
		return @"";
	}
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	if(selected_Picker==1)
	{
		lbl_Walk.text=[arr_Walk objectAtIndex:row];
		NSLog(@"Selected Color: %@. Index of selected color: %i", [arr_Walk objectAtIndex:row], row);
	}
	if(selected_Picker==2)
	{
		lbl_Hits.text=[arr_Hits objectAtIndex:row];
		NSLog(@"Selected Color: %@. Index of selected color: %i", [arr_Hits objectAtIndex:row], row);
	}
	else
	{
		
	}
}




- (void)dealloc {
	
    UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
    
	[btnSearch release];
	[btnOthers release];
	[monthLabel2 release];
	[arrCalernderEvents release];
	[search release];
	[searchList release];
	[searchLocationList release];
	[arr_Walk release];
	[arr_Hits release];
 	[arr_Images release];
	[arr_Buttons release];
	tbl_Events.delegate = nil;
	tbl_Events.dataSource = nil;
	[tbl_Events release];
	[scrl_btns release];
	[arr_Events release];
	[scr_Day release];
	[calHeaderView2 release];
	[vwCalender release];
	[vwList release];
	[arr_picker release];
	[arr_filter1 release];
	[arr_filter2 release];
 	tableViewEvent.delegate = nil;
	tableViewEvent.dataSource = nil;
    [tableViewEvent release];
	[viewEvent release];
 	picker_walking_hits.delegate = nil;
	picker_walking_hits.dataSource = nil;
	[picker_walking_hits release];
	[datePicker release];
 	[keyboardToolBar release];
	[toolBar release];
	[arrEventFriend release];
	[imgBGTop release];
	[super dealloc];
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */



@end
