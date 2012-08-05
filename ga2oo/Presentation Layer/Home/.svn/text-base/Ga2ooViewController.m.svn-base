//
//  Ga2ooViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Ga2ooViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterObject.h"
#import "eventListViewController.h"
#import "TableViewCellForHomePage.h"
#import "NotificationViewController.h"
#import "ProfileViewController.h"
#import "EventsListCustomCell.h"
#import "TableViewCellForHomePage.h"
#import "UserBO.h"
#import "FriendTableCell.h"
#import "EventListBL.h"
#import "UserBL.h"
#import "UserBO.h"
#import "HttpRequest.h"
#import "GlobalConstant.h"
#import "UserLocationBL.h"
#import "FriendsBL.h"
#import "EventsBL.h"
#import "EventFriendListBL.h"
#import "BusinessListBL.h"
#import "FriendDetailViewController.h"
#import "XMLLatLang.h"

@implementation Ga2ooViewController
@synthesize arrFilteredEvents;
@synthesize tableViewEv;
@synthesize arrUserLocation;
@synthesize arrEventFriend;
@synthesize backImageView;
@synthesize upTimeLabel;
@synthesize backLabel;
@synthesize pickerView;
@synthesize picker;
@synthesize pickerToolbar;
@synthesize pickerArray;
@synthesize intPickerSelected;
@synthesize lblNoOfEvents;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

#pragma mark UIView delegate

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setUpRefreshView];
	[self addPickerToolbar];
    
	
	[self setTopBarImageToViewWithHome:self.view];
	arrFilteredEvents = [[NSMutableArray alloc] init];
	arrEventFriend = [[NSMutableArray alloc] init];
	
	lblUpComingEvents.hidden = YES;
	countForArrow = 0;
	//self.arrUserLocation = [[NSMutableArray alloc] init];
	[imgViewProfile.layer setMasksToBounds:YES];
	[imgViewProfile.layer setBorderColor:[[UIColor whiteColor] CGColor]];
	[imgViewProfile.layer setBorderWidth:1.0];
	[imgViewProfile.layer setCornerRadius:5.0];
	
	
	//[self getAllFriends];
	vwHome.frame = CGRectMake(0, 00, 320, 365);
	//add the homeview view with scroll
	scrolHome = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 368)];
	scrolHome.delegate = self;
	scrolHome.showsHorizontalScrollIndicator = FALSE;
	scrolHome.contentSize = CGSizeMake(320, 339);
	
	
	UIImageView *imgBGTop = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 135)] autorelease];
	imgBGTop.backgroundColor = [UIColor clearColor];
	imgBGTop.image = [UIImage imageNamed:@"innerbg_top.png"];
	[scrolHome addSubview:imgBGTop];
	
	[scrolHome addSubview:vwHome];
	[self.view addSubview:scrolHome];
	[scrolHome release];
	
	
	//adding table of events
	arr_TableRowHeight = [[NSMutableArray alloc]init];
	for(int index=0; index<12; index++){
		[arr_TableRowHeight addObject:@"70"];
	}
	tableViewEv.backgroundColor = [UIColor clearColor];
	tableViewEv.tag = 912;
	
	for(UIScrollView *scrl in tableViewEv.subviews)
	{
		scrl.tag = 5454;
	}
	
	
	vwHome.backgroundColor = [UIColor clearColor];
	
	keyboardToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 644, 320, 44)];
	keyboardToolBar.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked)];
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
	keyboardToolBar.items=[[[NSArray alloc]initWithObjects:cancel,space, done,nil]autorelease];
	[self.view addSubview:keyboardToolBar];
	
	SearchBar.backgroundColor = [UIColor clearColor];
	
	arrFriendEmails = [[NSMutableArray alloc] init];
	
	
	//lblLocation.text=@"";
	
	obj_LMV=[[LoginMapViewController alloc]init];
	
    EventsLayer = [[EventListBL alloc]init];
	EventsLayer.delegate = self;
	 //[appDelegate.arrTotalEvents addObjectsFromArray:[EventsLayer SelectAllEventsAddingFriends]];
    
    //[appDelegate.arrTotalEvents addObjectsFromArray:[EventsLayer SelectAllEventsAddingNoOfFriends]];
    //[self filterUpComingEvents];
    
  //[appDelegate.arrTotalEvents addObjectsFromArray:[EventsLayer SelectAll]];

	
	
	
	UserLocationLayer = [[UserLocationBL alloc]init];
	UserLocationLayer.delegate = self;
	
	UserLayer = [[UserBL alloc]init];
	UserLayer.delegate = self;
	
	UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
    

	

	
	loader=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	loader.center =CGPointMake(35, 80);
	[self.view addSubview:loader];
	[loader startAnimating];
	
	
	

}

-(void)ActiveEvents
{
	[appDelegate.arr_AllEvents removeAllObjects];
	
	for(int i = 0; i<[appDelegate.arrTotalEvents count]; i++)
	{
		EventListBO *objEvent1 = [appDelegate.arrTotalEvents objectAtIndex:i];
		if([objEvent1.status isEqualToString:@"1"])
		{
			[appDelegate.arr_AllEvents addObject:objEvent1];
		}
	}
}

-(void)FeaturedEvents
{
	[appDelegate.arrFeatured removeAllObjects];
	
	for(int i = 0; i<[appDelegate.arr_AllEvents count]; i++)
	{
		EventListBO *objEvent1 = [appDelegate.arr_AllEvents objectAtIndex:i];
		
		if([objEvent1.is_featured isEqualToString:@"True"])
		{
			[appDelegate.arrFeatured addObject:objEvent1];
		}
	}
	
	NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
  	[appDelegate.arrFeatured sortUsingDescriptors:[NSArray arrayWithObjects:nameSortDescriptor,nil]];
    [nameSortDescriptor release]; 
}
/*
-(void)filterUpComingEvents
{
	NSMutableArray *arrEvents = [NSMutableArray arrayWithArray:appDelegate.arrUpcomingEvents];
	[appDelegate.arrUpcomingEvents removeAllObjects];
	for(int i = 0; i<[arrEvents count]; i++)
	{
		EventListBO *objEvent1 = [arrEvents objectAtIndex:i];
	    BOOL isEvtDtFeatured = [self featuredDateIs:objEvent1.event_start_date];
	    if(isEvtDtFeatured)
		 {
			[appDelegate.arrUpcomingEvents addObject:objEvent1];
		 }
	}
}


-(BOOL)featuredDateIs:(NSString*)eventStartDate
{
	BOOL isFeaturedDate = NO;
	NSDateFormatter *dtform = [[NSDateFormatter alloc]init];
	[dtform setDateFormat:@"yyyy-MM-dd"];
	NSDate *eventDt = [dtform dateFromString:eventStartDate];
	eventDt = (NSDate*)[eventDt dateByAddingTimeInterval:(5*60*60+30*60)];
	NSDate *currDt = [NSDate date];
	if(eventDt!=nil)
	{
		if([currDt compare:eventDt]<0)
		{
			NSLog(@"event date is more than today's date\n");
			isFeaturedDate = YES;
		}
	}
	[dtform release];
	return isFeaturedDate;
}
*/
-(void)viewWillDisappear:(BOOL)animated
{
	[vwSearch removeFromSuperview];
	keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
}

-(void) viewWillAppear:(BOOL)animated
{
	//self.arrUserLocation = [UserLocationLayer SelectAll];
    
    NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
    NSMutableArray *arrTemp1 = [[NSMutableArray alloc] init];
	notifyBl = [[NotificationsBL alloc] init];
    RecomBL = [[EventRecommendateBL alloc] init];
	[arrTemp addObjectsFromArray:[notifyBl SelectAll]];
    [arrTemp1 addObjectsFromArray:[RecomBL SelectAll]];
    [arrTemp addObjectsFromArray:arrTemp1];
    
	if([arrTemp count] <= 1)
	    lblNoOfEvents.text = [NSString stringWithFormat:@"%i Event", [arrTemp count]];
	else
		lblNoOfEvents.text = [NSString stringWithFormat:@"%i Events", [arrTemp count]];
    
    
	if(self.pickerArray==nil)
        self.pickerArray = [[NSMutableArray alloc] init];
	else
		[self.pickerArray removeAllObjects];	
	
 	NSMutableArray *arrSavedLocations = [[NSMutableArray alloc] init];
	[arrSavedLocations addObjectsFromArray: [UserLocationLayer SelectAll] ];
	[self.pickerArray addObjectsFromArray:arrSavedLocations];
    
	if(picker!=nil)
        [picker reloadAllComponents];
	
	[self setPrimaryLocationLabel];
    
	
	[self rempoveFriendsView];
	[arrFriendEmails removeAllObjects];
	
	objUser = (UserBO*) [UserLayer SelectByKey:appDelegate.currentUserID withMode:YES];
	
	
	if (objUser.imgCover)
	{
		
		imgUser = objUser.imgCover;
		imgViewProfile.image = objUser.imgCover;
		
		
		lblAddPhoto.hidden = YES;
		btnProfImage.hidden = YES;
		
		[loader stopAnimating]; 
	}
	
    else if ([objUser.UserImage length]> 5)
    {
      //[self downloadImage:objUser.UserImage Tag:12];
		
		imgViewProfile.image = [UIImage imageNamed:@"NoImageEvent.png"];
		
		[NSThread detachNewThreadSelector:@selector(displayUserImage:) toTarget:self withObject:objUser.UserImage];
		
    }
    else 
    {
        lblAddPhoto.hidden = NO;
		btnProfImage.hidden = NO;
    }
	
	
	
    //	if([self.arrUserLocation count])
    //	{
    //		for(int i=0; i<[self.arrUserLocation count];i++)
    //		{
    //			objUserLoc = [self.arrUserLocation objectAtIndex:i];
    //			if([objUserLoc.IsPrimary isEqualToString:@"True"])
    //				lblLocation.text = [NSString stringWithFormat:@"%@, %@", objUserLoc.City, objUserLoc.Zipcode];	
    //		}
    //	}
    
	//lblLocation.text = appDelegate.strSelectedLocation;
	
	lblName.text =[NSString stringWithFormat:@"%@",objUser.Username];
	
	[self ActiveEvents];
	[self FeaturedEvents];
	[appDelegate upcomingEvents];
	
	[searchTextFiled resignFirstResponder];
	//[self addTableOfEventsUsingArrayofAddedEventsByChecking:appDelegate.arr_AddedEvents];
	[tableViewEv reloadData];
    [arrTemp release];
    [arrTemp1 release];
    [arrSavedLocations release];
}

-(void)getAllFriends
{
	if([appDelegate.arr_AllFriend count])
		[appDelegate.arr_AllFriend removeAllObjects];
	
	FriendsBL *objFrndBL = [[FriendsBL alloc]init];
	[appDelegate.arr_AllFriend addObjectsFromArray:[objFrndBL SelectAll]];
	[objFrndBL release];
}


-(void)cancelBtnTouchUpInside
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
	searchList.text = @"";
	searchLocationList.text = @"";
	[searchList resignFirstResponder];
	[searchLocationList resignFirstResponder];
	[vwSearch removeFromSuperview];
	[UIView commitAnimations];
}

-(void)SearchBtnClickedClicked
{
	[self removeSearchBarButtons];
    
	//[self addTableOfEventsUsingArrayofAddedEventsByChecking:appDelegate.arr_AddedEvents];
    
	if([arrFilteredEvents count])
		[arrFilteredEvents removeAllObjects];
	
	NSString *searchText;
	NSString *searchText1;
    NSString *searchText2;
	searchText = searchList.text;

	if(!searchText)
	{
		searchText = @"";
	}
	else if([searchText isEqualToString:@""])
	{
		searchText = @" ";
	}
	
    NSArray *loactionArray = [searchLocationList.text componentsSeparatedByString:@","];
	searchText1 = [loactionArray objectAtIndex:0];
	if(!searchText1)
	{
		searchText1 = @"";
	}
	else if([searchText1 isEqualToString:@""])
	{
		searchText1 = @" ";
	}
    
    if([loactionArray count] >= 2)
    {
      searchText2 = [loactionArray objectAtIndex:1];
    }
    else 
    {
      searchText2 = @"";
    }
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"name contains[cd] %@",searchText];
	NSArray *arr = [appDelegate.arr_AllEvents filteredArrayUsingPredicate:pred];
	if(arr)
	{
		if(![searchText1 isEqualToString:@""])
		{
			NSPredicate *pred = [NSPredicate predicateWithFormat:@"city contains[cd] %@",searchText1];
			NSArray *arr1 = [arr filteredArrayUsingPredicate:pred];
			
            
            if(![searchText2 isEqualToString:@""])
            {
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"zipcode contains[cd] %@",searchText2];
                NSArray *arr2 = [arr1 filteredArrayUsingPredicate:pred];
                [arrFilteredEvents addObjectsFromArray:arr2];

            }
            else 
            {
               [arrFilteredEvents addObjectsFromArray:arr1];
            }
			
		}
		else 
		{
		   [arrFilteredEvents addObjectsFromArray:arr];
		}
	}	
	//keyboardToolBar1.frame = CGRectMake(0, 600, 320, 44);
	eventListViewController *objEventView = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	if(objEventView.arrEvents)
		[objEventView.arrEvents removeAllObjects];
	objEventView.arrEvents = [[NSMutableArray alloc] init];
	[objEventView.arrEvents addObjectsFromArray:arrFilteredEvents];	
	[self.navigationController pushViewController:objEventView animated:YES];
	[objEventView release];
}

-(void)hidePicker
{
	btnAddLocation.enabled = YES;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	pickerToolbar.center = CGPointMake(160,550);
	pickerView.center = CGPointMake(160,600);
	[UIView commitAnimations];
}


-(void) addPickerToolbar
{
	pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 556, 320, 44)];
	UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(status_doneClicked)];
	UIBarButtonItem *Cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(hidePicker)];
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	[pickerToolbar setTintColor:[UIColor blackColor]];
	pickerToolbar.items = [[[NSArray alloc] initWithObjects:Cancel,space, done, nil] autorelease];
	pickerToolbar.center = CGPointMake(160, 550);
	[vwHome addSubview:pickerToolbar];
	[done release];
    [Cancel release];
	[space release];
}

-(void)status_doneClicked
{
	[self updatePrimaryLocation:intPickerSelected];
	
	btnAddLocation.enabled = YES;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	pickerToolbar.center = CGPointMake(160,550);
	pickerView.center = CGPointMake(160,600);
	[UIView commitAnimations];
}
-(void) pickerShow
{
	btnAddLocation.enabled = NO;
	pickerView.frame = CGRectMake(0, 600, 320, 230);
	pickerView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:pickerView];

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	pickerView.center = CGPointMake(160, 261+49);
	pickerToolbar.center = CGPointMake(160, 80+49);
	[UIView commitAnimations];
	//[pickerView bringSubviewToFront:self.view];


}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	return [pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	NSString *strAddress = @"";
	UserLocationBO *locObj = [self.pickerArray objectAtIndex:row];
	strAddress = [NSString stringWithFormat:@"%@ %@",[locObj.City  isEqualToString:@"Null"]?@"":[locObj.City  isEqualToString:@"None"]?[locObj.State  isEqualToString:@"Null"]?@"":locObj.State:locObj.City, [locObj.Zipcode  isEqualToString:@"None"]?@"":locObj.Zipcode];	

	return strAddress;
}

- (void)pickerView:(UIPickerView *)pickView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
	intPickerSelected = row;
}

-(void) updatePrimaryLocation:(NSInteger) row
{
	UserLocationBO *locObj = [self.pickerArray objectAtIndex:row];
	
	UserLocationBL *UserLocLayer = [[UserLocationBL alloc]init];
	UserLocLayer.delegate = self;
	
	for(int i = 0; i<[self.pickerArray count]; i++)
	{
		UserLocationBO *obj = [self.pickerArray objectAtIndex:i];
		obj.IsPrimary = @"None";
		[UserLocLayer Update:obj withSave:YES];			
	}
	locObj.IsPrimary = @"True";
	[UserLocLayer Update:locObj withSave:YES];
	[UserLocLayer release];
	
	[self setPrimaryLocationLabel];
}
/*

-(void)setPrimaryLocationLabel
{
	if([self.pickerArray count])
	{
		NSString *strzip;
		NSString *strstate;
		NSString *strcity;
		
		
		for(int i=0;i<[self.pickerArray count];i++)
		{
			objUserLoc=[self.pickerArray objectAtIndex:i];
			if([objUserLoc.IsPrimary isEqualToString:@"True"])
			{
				if([objUserLoc.City length])
				{
					if ([objUserLoc.City isEqualToString:@"None"]) {
						strzip=[NSString stringWithFormat:@""];
					}
					else {
						strzip=objUserLoc.City;
					}

				}
				else {
					strzip=[NSString stringWithFormat:@""];
				}
				if([objUserLoc.State length])
				{
					if ([objUserLoc.State isEqualToString:@"None"]) {
						strstate=[NSString stringWithFormat:@""];
					}
					else {
						strstate=objUserLoc.State;
					}
					
				}
				else {
					strstate=[NSString stringWithFormat:@""];
				}
				if([objUserLoc.City length])
				{
					if ([objUserLoc.City isEqualToString:@"None"]) {
						strcity=[NSString stringWithFormat:@""];
					}
					else {
						strcity=objUserLoc.City;
					}
					
				}
				else {
					strcity=[NSString stringWithFormat:@""];
				}
				
				
				
				
			}
			
			
		}
		
		lblLocation.text = [NSString stringWithFormat:@"%@,%@,%@", objUserLoc.State,objUserLoc.City, objUserLoc.Zipcode];
		
	}
	
	
}
*/

-(void) setPrimaryLocationLabel
{
 	if([self.pickerArray count])
	{
        lblLocation.text = @"";
		for(int i=0; i<[self.pickerArray count];i++)
		{
			objUserLoc = [self.pickerArray objectAtIndex:i];
			if([objUserLoc.IsPrimary isEqualToString:@"True"]){
			//	NSString *loc=nil;

				if ([objUserLoc.City length]) 
				{
					if ([objUserLoc.City isEqualToString:@"None"])
					{
					  lblLocation.text = [NSString stringWithFormat:@"%@", objUserLoc.State];	
					}
					else 
					{
						lblLocation.text = [NSString stringWithFormat:@"%@", objUserLoc.City];
					}
				}
				if ([objUserLoc.City length] && [objUserLoc.Zipcode length] ) 
				{
					NSLog(@"objUserLoc.Zipcode %@",objUserLoc.Zipcode);
					if([objUserLoc.Zipcode isEqualToString:@"None"])
					{
						if ([objUserLoc.City isEqualToString:@"None"])
						{
							lblLocation.text = [NSString stringWithFormat:@"%@", objUserLoc.State];	
						}
						else 
						{
							lblLocation.text = [NSString stringWithFormat:@"%@", objUserLoc.City];
						}
					}
					else 
					{
						
						if ([objUserLoc.City isEqualToString:@"None"])
						{
							lblLocation.text = [NSString stringWithFormat:@"%@, %@", objUserLoc.State, objUserLoc.Zipcode];
						}
						else 
						{
							lblLocation.text = [NSString stringWithFormat:@"%@, %@", objUserLoc.City, objUserLoc.Zipcode];
						}
					  
					}
				}
			
			}
		}
	}
	else {
		lblLocation.text = @"";	

	}

}
#pragma mark refreshtable

-(void)setUpRefreshView
{
	
	UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
	UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 137-theImage.size.height-5, theImage.size.width, theImage.size.height)];
	theImageView.image = theImage;
	self.backImageView = theImageView;
	//self.backImageView.frame = CGRectMake(backImageView.frame.origin.x, -theImageView.frame.origin.y, theImage.size.width, theImage.size.height);
	[theImageView release];
	CGAffineTransform transform = backImageView.transform;
	transform = CGAffineTransformRotate(transform, M_PI);
	backImageView.transform = transform;
	
	UILabel *theLabel           = [[UILabel alloc] initWithFrame:CGRectMake(30, 152-50, 280, 25)];
	UILabel *theUpdateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 152-30, 280, 20)];
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
	refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 100)];
	refreshView.backgroundColor = [UIColor colorWithRed:0.88627 green:0.90588 blue:0.92941 alpha:1];
	[refreshView addSubview:upTimeLabel];
	[refreshView addSubview:backLabel];
	[refreshView addSubview:backImageView];
	[self.view addSubview:refreshView];
	//[self.view sendSubviewToBack:refreshView];

	backImageViewStatu = NO;
	isRefreshStatu     = NO;
}

#pragma mark --------- Scroll View Delegate -------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *) scrollView;
	if(tblTemp)
		if(tblTemp.tag == 912)
		{
			UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
			
			if(scrollView.contentOffset.y<=0)
			{
				CGRect rect         = CGRectMake(0, 40, 320, 135);
				rect.origin.y       -= scrollView.contentOffset.y-5;
				refreshView.frame = rect;
				
				if(scrollView.contentOffset.y <= -60 && backImageViewStatu == NO)
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
				else if(scrollView.contentOffset.y > -60 && backImageViewStatu ==YES)
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
				refreshView.frame = CGRectMake(0, 45, 320, 35);
			}
		}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *) scrollView;
	if(tblTemp)
		if(tblTemp.tag == 912)
		{
			if (scrollView.contentOffset.y<= -60)
				isRefresh = YES;
			else 
				isRefresh = NO;
		}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	UITableView *tblTemp = (UITableView *) scrollView;
	if(tblTemp)
		if(tblTemp.tag == 912)
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
    /*
//	[self loadAnimation];
//	//write code here  to refresh data
//	[self addTableOfEventsUsingArrayofAddedEventsByChecking:appDelegate.arr_AddedEvents];
	[tableViewEv reloadData];
//	[self removeSyncLoader];*/
    [self loadAnimation];
    [EventsLayer deleteAll];
    [appDelegate.arrTotalEvents removeAllObjects];
    
    EventsLayer.ModeType = GetEventList;
    EventsLayer.str_type = [NSString stringWithFormat:@""];
    EventsLayer.str_date = [NSString stringWithFormat:@""];
    EventsLayer.str_category = [NSString stringWithFormat:@""];
    
    [EventsLayer LoadEventList];


}

-(void)EventsListLoadingCompleted:(NSMutableArray*)arrdata
{
    NSMutableArray *FavEvents = [[NSMutableArray alloc]init];
    
    for(int i = 0 ; [appDelegate.arr_FavoritesID count]>i ; i++)
    {
        NSString *FavId = [[appDelegate.arr_FavoritesID objectAtIndex:i] strEventId];
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"Eventid == %@",FavId];
        NSArray *arr1 = [appDelegate.arr_AllEvents filteredArrayUsingPredicate:pred1];
        
        if ([arr1 count]) {
            [FavEvents addObjectsFromArray:arr1];
            
        }
    }
	
    [self InsertFavEvents:FavEvents];
    [FavEvents release];
    
    [self removeSyncLoader];
    [appDelegate.arrTotalEvents addObjectsFromArray:[EventsLayer SelectAllEventsAddingNoOfFriends]];
    [self ActiveEvents];
	[self FeaturedEvents];
	[appDelegate upcomingEvents];
    [tableViewEv reloadData];
	
}

-(void)InsertFavEvents:(NSMutableArray*)arrFavsEvents
{
	NSMutableArray *arrFavrateEvents = [[NSMutableArray alloc]init];
	NSInteger favid = 1;

	for(EventListBO *evbo in arrFavsEvents)
	{
		
        AddFavEventBO *addFavBo   = [[AddFavEventBO alloc]init];
        addFavBo.UserId           = [appDelegate.currentUserID integerValue];
        addFavBo.EventId          = [evbo.Eventid integerValue];
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"strEventId == %@",evbo.Eventid];
        NSArray *arr1 = [appDelegate.arr_FavoritesID filteredArrayUsingPredicate:pred1];
        
        addFavBo.UserAddedEventId = [[[arr1 objectAtIndex:0] strUserAddedEventId] integerValue];
        [arrFavrateEvents addObject:addFavBo];
        [addFavBo release];
        
		
	}
	if([arrFavrateEvents count])
	{
    	[self InsertFavBOEvents:arrFavrateEvents];
	}
	[arrFavrateEvents release];
}

-(void)InsertFavBOEvents:(NSMutableArray*)arrfavBos
{
	FavoriteBusinessBL *favBL = [[FavoriteBusinessBL alloc]init];
	favBL.delegate = self;
	[favBL InsertArrayFavEvents:arrfavBos];
	[favBL release];
}

-(void)FavoriteEventsLoadingCompleted
{
}


-(void) refreshData
{
	[self performSelector:@selector(refreshDataPart) withObject:nil afterDelay:0];
}


#pragma mark Methods for POPUP 
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
-(void)closeBtnClicked:(id)sender
{
 	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	friendsView.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(rempoveFriendsView) withObject:nil afterDelay:1.0];
	
}

-(void)btnOkClicked{
    
       
	if([arrFriendEmails count]){
		btnEvents.userInteractionEnabled	= YES;
		btnProfImage.userInteractionEnabled = YES;
		tableViewEv.userInteractionEnabled	= YES;
		
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
			UIImage *img = objEvent.imageEvent;//;objEvent.imgCover;
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
                            "\n<friend>\n"];
    
    for(int k = 0 ; [arr count]>k ; k++)
    {
        FriendsIds = [FriendsIds stringByAppendingString:[NSString stringWithFormat:@"<friendid>%i</friendid>\n",[[arr objectAtIndex:k] integerValue]]];
    }
    
    FriendsIds = [FriendsIds stringByAppendingString:@"</friend>\n"];
    
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
	
	tableViewEv.userInteractionEnabled	= NO;
	btnEvents.userInteractionEnabled	= NO;
	btnProfImage.userInteractionEnabled = NO;
	
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
	[UIView setAnimationDuration:0.29f];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
	
}

-(void)popUpFriendListView
{
	tableViewEv.userInteractionEnabled	= NO;
	btnEvents.userInteractionEnabled	= NO;
	btnProfImage.userInteractionEnabled = NO;
	
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
	
	[self.view addSubview:friendsView];
	
	//transforming the view
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	[self.view addSubview:friendsView];
	
	//animation starts here
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29f];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
}

-(void)rempoveFriendsView
{
	btnEvents.userInteractionEnabled	= YES;
	btnProfImage.userInteractionEnabled = YES;
	tableViewEv.userInteractionEnabled = YES;
	
	if(friendsView!=nil)
	{
		[friendsView removeFromSuperview];
		[friendsView release];
		friendsView = nil;
		tblFriends.delegate = nil;
		tblFriends.dataSource = nil;
		[tblFriends release];
	}
	
}


#pragma mark IBAction Methods

-(IBAction)searchBtnClicked
{
	vwSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
	vwSearch.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwSearch];
	//vwSearch.alpha = 0.70;
	
	UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	img1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearch addSubview:img1];
	[img1 release];
	
	UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
	img2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwSearch addSubview:img2];
	[img2 release];
	
	
}

-(IBAction)searchBtnTouchUpInside
{
	vwSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
	vwSearch.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vwSearch];
	
	keyboardToolBar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 644, 320, 44)];
	keyboardToolBar1.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(SearchBtnClickedClicked)];
	keyboardToolBar1.items=[[[NSArray alloc]initWithObjects:space1, done,nil]autorelease];
	[self.view addSubview:keyboardToolBar1];
    [space1 release];
    [done release];
	
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
	
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
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

-(IBAction) btnChangeImageTouchupInside:(id) sender
{
	UIDevice *device = [UIDevice currentDevice];
	NSString *currDevice = [device model];
	if([currDevice isEqualToString:@"iPhone"]){
		
		UIActionSheet *styleAlert =	[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
													   otherButtonTitles:@"Take Photo", @"Choose From Gallery",nil];
		styleAlert.tag = 98;
		//styleAlert.center = CGPointMake(160,200);
		styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
		[styleAlert showInView:self.view];
		[styleAlert release];
		
	}
	else {
		UIActionSheet *styleAlert =	[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
													   otherButtonTitles:@"Choose From Gallery",nil];
		styleAlert.tag = 88;
		//styleAlert.center = CGPointMake(160,200);
		styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
		[styleAlert showInView:self.tabBarController.view];
		[styleAlert release];
	}
	
}

-(IBAction)profileBtnClicked
{
	ProfileViewController *objProfile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
	objProfile.imgUser = imgUser;
	objProfile.strlocation=lblLocation.text;
	[self.navigationController pushViewController:objProfile animated:YES];
	[objProfile release];
}

-(IBAction)eventBtnClicked
{
	NotificationViewController *objNot = [[NotificationViewController alloc] initWithNibName:@"NotificationViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:objNot animated:YES];
	[objNot release];
}

-(IBAction) btnFeaturedEventsTouchupInside:(id) sender
{
	eventListViewController *objEventView = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	[objEventView.arrEvents removeAllObjects];
	objEventView.arrEvents  = appDelegate.arr_AllEvents;
	[self.navigationController pushViewController:objEventView animated:YES];
	[objEventView release];
}

-(IBAction) btnSearcyNearbyTouchupInside:(id) sender
{
	[self removeSearchBarButtons];
	//[self addTableOfEventsUsingArrayofAddedEventsByChecking:appDelegate.arr_AddedEvents];
	
	[self performSelectorOnMainThread:@selector(filterEventsArray) withObject:nil waitUntilDone:YES];
	
	eventListViewController *objEventView = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	if(objEventView.arrEvents)
		[objEventView.arrEvents removeAllObjects];
	objEventView.arrEvents = [[NSMutableArray alloc] init];
	[objEventView.arrEvents addObjectsFromArray:arrFilteredEvents];	
	[self.navigationController pushViewController:objEventView animated:YES];
	[objEventView release];
	
}
-(IBAction) btnSearchAllTouchupInside:(id) sender
{
	[self performSelectorOnMainThread:@selector(filterEventsArray) withObject:nil waitUntilDone:YES];
	
	eventListViewController *objEventView = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	if(objEventView.arrEvents)
		[objEventView.arrEvents removeAllObjects];
	objEventView.arrEvents = [[NSMutableArray alloc] init];
	[objEventView.arrEvents addObjectsFromArray:arrFilteredEvents];
	[self.navigationController pushViewController:objEventView animated:YES];
	[objEventView release];
	
}
-(IBAction) btnAddLocationTouchupInside:(id) sender
{
 
	if ([self.pickerArray count]) {
		UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use existing location",@"Add new location",nil];
		styleAlert.tag = 120;
		styleAlert.center = CGPointMake(160,200);
		styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
		[styleAlert showInView:appDelegate.window];
		[styleAlert release];
		
	}
	else {
		UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add new location",nil];
		styleAlert.tag = 121;
		styleAlert.center = CGPointMake(160,200);
		styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
		[styleAlert showInView:appDelegate.window];
 		[styleAlert release];
 	}
}


-(IBAction) eventButton_onTouchUpInside:(id)sender{
	UIButton *btn = (UIButton *)sender;
	EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
	eventVC.objEvent = [appDelegate.arr_AddedEvents objectAtIndex:btn.tag];
	[self.navigationController pushViewController:eventVC animated:YES];
	[eventVC release];
}

-(void)btnFriendclicked:(id)sender
{
	objEvent=[appDelegate.arrUpcomingEvents objectAtIndex:[sender tag]];
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

#pragma mark Action Methods 


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
	objEvent=[appDelegate.arr_AllEvents objectAtIndex:[sender tag]];
	
#if !TARGET_IPHONE_SIMULATOR
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 400;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
	
#endif
#if TARGET_IPHONE_SIMULATOR
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 401;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
#endif
}


-(void) logoutBtn_Clicked:(id) sender
{
	[appDelegate removeTabBar];

	if(friendsView)
	[self rempoveFriendsView];
	for(UIViewController *viewCont in appDelegate.navigationController.viewControllers)
	{
		if([viewCont isKindOfClass:[HomeViewController class]])
		{
			[appDelegate.navigationController popToViewController:viewCont animated:NO];
			break;
		}
	}
}



#pragma mark Local Methods to use


-(void) filterEventsArray
{
	
	if([arrFilteredEvents count])
		[arrFilteredEvents removeAllObjects];
	NSString *searchText = searchTextFiled.text;
	if(!searchText)
	{
		searchText = @"";
	}
	else if([searchText isEqualToString:@""])
	{
		searchText = @" ";
	}
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"strTitle contains[cd] %@",searchText];
	NSArray *arr = [appDelegate.arr_AllEvents filteredArrayUsingPredicate:pred];
	if(arr)
	{
		[arrFilteredEvents addObjectsFromArray:arr];
	}
	
}

-(void) removeSearchBarButtons
{
	lblUpComingEvents.hidden = NO;
	lblStartSearching.hidden = YES;
	for(UIView *vw in vwHome.subviews)
	{
		for(int i = 2;i<=5; i++)
		{
			if(vw.tag == i)
			{
				vw.hidden = YES;
			}
		}
	}
}

-(void) addSearchBarButtons
{
	lblUpComingEvents.hidden = YES;
	lblStartSearching.hidden = NO;
	
	for(UIView *vw in vwHome.subviews)
	{
		for(int i = 2;i<=5; i++)
		{
			if(vw.tag == i)
			{
				vw.hidden = NO;
			}
		}
		
		if(vw.tag == 912)
		{
			if([vw isKindOfClass:[UITableView class]])
			{
				//vw.hidden = YES;
			}
		}
	}
}




- (void)scrollViewToCenterOfScreen:(UIView *)theView {
	CGFloat viewCenterY = theView.center.y ;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	scrolHome.contentSize = CGSizeMake(scrolHome.contentSize.width,260+100);
	if(viewCenterY < 240-74-47)
		[scrolHome setContentOffset:CGPointMake(0, 0) animated:YES];
	else
		[scrolHome setContentOffset:CGPointMake(0, viewCenterY - 100) animated:YES];
	[UIView commitAnimations];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


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

-(void)choosePhoto{
	
	UIImagePickerController	*piccontroller = [[UIImagePickerController alloc] init];
	piccontroller.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
	piccontroller.allowsEditing = NO;
	piccontroller.delegate = self;
	[self presentModalViewController:piccontroller animated:YES];
	[piccontroller release];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1{
	[picker1 dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker2 didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo	
{
	
	if(myimage)
	{
		imgViewProfile.image = nil;
		imgViewProfile.image = myimage;//[self getScaledImageFrom:myimage toSize:CGRectMake(0, 0, 320, 460)];
		RegisterObject *obj = [appDelegate.arrRegister objectAtIndex:0];
		obj.imgImage = myimage;
	}
	
	
  	[picker2 dismissModalViewControllerAnimated:YES];
}

-(void)takePhoto{
	UIDevice *device = [UIDevice currentDevice];
	NSString *currDevice = [device model];
	if([currDevice isEqualToString:@"iPhone"]){
		[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
		imgPickerCon = [[UIImagePickerController alloc] init];
		imgPickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
		imgPickerCon.delegate = self;
		[self presentModalViewController:imgPickerCon animated:YES];
		[imgPickerCon release];
		imgPickerCon = nil;
	}
	else if([currDevice isEqualToString:@"iPad"])
	{
	}
	else if([currDevice isEqualToString:@"iPod"])
	{
	}
	else{
		UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Not Valid" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alrt show];
		[alrt release];
	}
}

-(void) addTableOfEventsUsingArrayofAddedEventsByChecking:(NSMutableArray *) arrAddedEvents
{
	if([arrAddedEvents count])
	{
		//d[tableViewEv removeFromSuperview];
		[self removeSearchBarButtons];
		tableViewEv.delegate = self;
		tableViewEv.dataSource = self;
		//[vwHome addSubview:tableViewEv];
		[tableViewEv reloadData];
	}
	else {
		[self addSearchBarButtons];
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

#pragma mark UIAlertView,MFMailCompose and UIActionSheet delegate 

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==111)
	{
		if (buttonIndex == 0)
		{
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"This feature will be available during programming." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

			[myAlertView show];
			[myAlertView release];
		}
	}
	else if(alertView.tag == 222 && buttonIndex == 1) {
		
		[alertView dismissWithClickedButtonIndex:0 animated:YES];
		
		UIDevice *device = [UIDevice currentDevice];
		NSString *currDevice = [device model];
		if([currDevice isEqualToString:@"iPhone"]){
			
			UIActionSheet *styleAlert =	[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
														   otherButtonTitles:@"Take Photo", @"Choose From Gallery",nil];
			styleAlert.tag = 98;
			styleAlert.center = CGPointMake(160,200);
			styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
			[styleAlert showInView:self.view];
			[styleAlert release];
			
		}
		else {
			UIActionSheet *styleAlert =	[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
														   otherButtonTitles:@"Choose From Gallery",nil];
			styleAlert.tag = 88;
			styleAlert.center = CGPointMake(160,200);
			styleAlert.actionSheetStyle = UIBarStyleBlackTranslucent;
			[styleAlert showInView:self.view];
			[styleAlert release];
		}
	}
	else if(alertView.tag==1234)
	{
        if (intTagValue >= 1000000)
        {
            objEvent=[appDelegate.arrUpcomingEvents objectAtIndex:intTagValue-1000000];
        }
        else 
        {
            objEvent=[appDelegate.arrFeatured objectAtIndex:intTagValue-100];
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
        if (intTagValue >= 1000000)
        {
            objEvent=[appDelegate.arrUpcomingEvents objectAtIndex:intTagValue-1000000];
        }
        else 
        {
            objEvent=[appDelegate.arrFeatured objectAtIndex:intTagValue-100];
        }
        
        NSMutableArray *arrEvents = [UserFavBussLayer SelectfavEventsByKey:[objEvent.Eventid integerValue]];
        
        if(buttonIndex==0)
        {
            [self deletefavevent:[arrEvents objectAtIndex:0]];
            
        }
    }
	
	else if(alertView.tag == 11)
	{
		if (buttonIndex == 0)
		{
			
			LoginMapViewController *objLogin = [[LoginMapViewController alloc] initWithNibName:@"LoginMapViewController" bundle:[NSBundle mainBundle]];
			[self.navigationController pushViewController:objLogin animated:YES];
			[objLogin release];	
		}
		else 
		{
			
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Enter zipcode" message:@"Some text to increase area" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
			myAlertView.tag=1112;
			myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
			myTextField.keyboardType=UIKeyboardTypeNumberPad;
			[myTextField setBackgroundColor:[UIColor whiteColor]];
			[myAlertView addSubview:myTextField];
			[myAlertView show];
			[myAlertView release];
			[myTextField release];
		
		}
	}
	
	else if(alertView.tag==1112)
	{
		if (buttonIndex == 0)
		{
 			
			if(myTextField.text ==nil)
			{
				UIAlertView *alertenterZip = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid zipcode." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertenterZip show];
				[alertenterZip release];
			}
			else
			{
				[myTextField resignFirstResponder];
				[self GettingDataforZipCode:myTextField.text];
			}
		}
		else if(buttonIndex == 1)
		{
			[myTextField resignFirstResponder];
		}
	}

}	
#pragma mark -
#pragma mark FavoriteEvents Added To Company and Events
#pragma mark -

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
                                            "<addedeventid>%i</addedeventid>\n"  
                                            "</events>\n"
                                            "</useraccount >\n",[appDelegate.currentUserID intValue],evnts.UserAddedEventId ];
    
    
    //UserFavBussLayer.strSopForDeleteEvnt = [NSString stringWithFormat:@"id/%i/deleteids/%i",[appDelegate.currentUserID intValue],evnts.UserAddedEventId ];
    [UserFavBussLayer deleteFavorite];*/
    
    if(appDelegate.isNetAvail)
	{
		HttpRequest *request = [[HttpRequest alloc] init];
 		[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/events/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],evnts.UserAddedEventId] Delegate:self Tag:10];
  		[request release];		
		
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
   /* NSRange rangeIs = [strMsgs rangeOfString:@"successfully" options:NSCaseInsensitiveSearch];
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
    }*/
    
	[self showAlerts:strMsgs];
}

-(void)showAlerts:(NSString*)strMsg
{
    [tableViewEv reloadData];
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(modalView.tag == 98)
	{
		switch (buttonIndex){
			case 0:
				[self takePhoto];
				break;
				
			case 1:
				[self choosePhoto];
				break; 	
			case 2:
				break; 
		}
	}
	else if(modalView.tag == 88)
	{
		switch (buttonIndex){
			case 0:
			{
				[self choosePhoto];
				break; 	
			}
			default:
				break;
		}
	}
	else if(modalView.tag == 401 || modalView.tag == 400)
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
//		else if (buttonIndex == 4) {
//		 
//			facebookConnectViewController *obj = [[facebookConnectViewController alloc]initWithNibName:@"facebookConnectViewController" bundle:[NSBundle mainBundle]];
//			obj.objTemp = objEvent;
//			[self.navigationController pushViewController:obj animated:YES];
//			[obj release];
//			 
//			
//		}
//		else if (buttonIndex == 5) {
//			 
//			twitterViewController *obj = [[twitterViewController alloc]initWithNibName:@"twitterViewController" bundle:[NSBundle mainBundle] withDataToBePublished:objEvent.name];
//			[self.navigationController pushViewController:obj animated:YES];
//			[obj release];
//			 
//		}
		else if (buttonIndex == 4) {
			
		}
		
	}
	else if(modalView.tag == 120)
	{
		if(buttonIndex == 0)
		{
			[modalView dismissWithClickedButtonIndex:0 animated:YES];
			[self pickerShow];
		}
		else if(buttonIndex == 1)
		{
			
			UIAlertView *alertPass=[[UIAlertView alloc]initWithTitle:nil message:@"Choose current location or zip." delegate:self cancelButtonTitle:@"Current location" otherButtonTitles:@"Enter zip",nil];
			alertPass.tag=11;
			[alertPass show];
			[alertPass release];
			
					
		}
	}
	else if(modalView.tag == 121)
	{
		if(buttonIndex == 0)
		{
			UIAlertView *alertPass=[[UIAlertView alloc]initWithTitle:nil message:@"Choose current location or zip." delegate:self cancelButtonTitle:@"Current location" otherButtonTitles:@"Enter zip",nil];
			alertPass.tag=11;
			[alertPass show];
			[alertPass release];
 		}
		else if(buttonIndex == 1)
		{
			//[modalView dismissWithClickedButtonIndex:0 animated:YES];
	
		}
	}
}


-(void *)GettingDataforZipCode:(NSString *) StrValue
{
  	NSString * urlString = [[[NSString alloc] initWithFormat:@"http://maps.google.com/maps/geo?key=AIzaSyAaIDsz4n8sACcuJrGpnwkSfIBrUZwjX9Y&output=xml&q=%@",[StrValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] autorelease];
    
    NSError *parseError = nil;
    XMLLatLang *streamingParser = [[XMLLatLang alloc]init];
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
	UserLocationBO *NewUserLocation = [streamingParser parseXMLFileAtURL:[NSURL URLWithString:urlString] parseError:&parseError];
    
    [streamingParser release]; 
	
	if(![NewUserLocation.City length] && ![NewUserLocation.State length])
	{
		UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to find location for this zip code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[myAlertView show];
		[myAlertView release];
	}
	else 
	{
		
		LoginMapViewController *objLogin = [[LoginMapViewController alloc] initWithNibName:@"LoginMapViewController" bundle:[NSBundle mainBundle]];
		objLogin.userLocationForZip = NewUserLocation;
		[self.navigationController pushViewController:objLogin animated:YES];
		[objLogin release];	
	
	}
    
	
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	switch (result)
	{
		case MessageComposeResultCancelled:
			//SMS.text = @"Result: canceled";
			NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			//SMS.text = @"Result: sent";
			NSLog(@"Result: sent");
			break;
		case MessageComposeResultFailed:
			//SMS.text = @"Result: failed";
			NSLog(@"Result: failed");
			break;
		default:
			//SMS.text = @"Result: not sent";
			NSLog(@"Result: not sent");
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
	
}



#pragma mark UITableView dataSource and delegate methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(tableView.tag !=1111 && tableView.tag !=2222)
	{
		UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
		[v setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1.0]];
		
		UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.textColor = [UIColor colorWithRed:110/255.0 green:150/255.0 blue:165/255.0 alpha:1.0];
		[lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
		lblTitle.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1.0];
		if(section == 0)
		{
			lblTitle.text = @"  Featured Event";
		}
		else	
		{
			lblTitle.text = @"  Upcoming Events";
		}
		[v addSubview:lblTitle];
		UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 300, 2)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
		imgSep.backgroundColor = [UIColor clearColor];
		[v addSubview:imgSep];
		[imgSep release];
		[lblTitle release];
		
		return [v autorelease];
	}
	else {
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(tableView.tag!=1111 && tableView.tag !=2222)
		return 30.0;
	else
		return 0;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag == 1111 || tableView.tag ==2222){
		return 60;
	}
	else
	{
		if(indexPath.section == 0)
		{
			return 80.0;
		}
		else {
			return 80;
		}
	}
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

	if(tableView.tag!=1111 && tableView.tag !=2222)
		return 2;
	else
		return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if(tableView.tag!=1111 && tableView.tag !=2222){
		if(section == 0){
			if([appDelegate.arrFeatured count])
				return [appDelegate.arrFeatured count];
			else 
				return 1;
		}
		else{
			if([appDelegate.arrUpcomingEvents count])
				return [appDelegate.arrUpcomingEvents count];
			else 
				return 1;
			
		}
	}
	else {
		if([arrEventFriend count])
			return [arrEventFriend count];
		else {
			return 1;
		}

	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(tableView.tag!=1111 && tableView.tag!=2222)
	{
		if(indexPath.section == 0)
		{
			if( [appDelegate.arrFeatured count]>0)
			{
                [(TableViewCellForHomePage *)cell showEventsImage];

            }
            
        }
        else{
        
            if( [appDelegate.arrUpcomingEvents count]>0)
			{
                [(EventsListCustomCell *)cell showEventsImage];
                
            }
        }

    }
    else{
    	[(FriendTableCell *)cell showUserImage];

    }
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if(tableView.tag!=1111 && tableView.tag!=2222)
	{
		tableView.separatorColor = [UIColor clearColor];
		if(indexPath.section == 0)
		{
			if( [appDelegate.arrFeatured count]>0)
			{
				static NSString *Ga2ooHomeCell1 = @"Ga2ooHomeCell1";
				
				TableViewCellForHomePage *cell = (TableViewCellForHomePage *)[tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell1];
				if (cell == nil) {
					cell = [[[TableViewCellForHomePage alloc] initWithFrame:CGRectZero reuseIdentifier:Ga2ooHomeCell1] autorelease];
				}
				cell.backgroundColor = [UIColor clearColor];
				
				EventListBO *obj = (EventListBO *)[appDelegate.arrFeatured objectAtIndex:indexPath.row];    
				
				EventListBO *obj_ = [appDelegate.arrFeatured objectAtIndex:indexPath.row];
                
                
                [cell setTheEventInTheCell:obj_];
				
                
               /* NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
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
				
				cell.btn_star.hidden = YES;
                
                
                UIButton *playbtn = [[UIButton alloc]initWithFrame:CGRectMake(205,44,41,26)];
                playbtn.tag=indexPath.row + 100;
                
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
 				
				
					
					
				[cell setBackgroundColor:[UIColor yellowColor]];
				[cell setTips:obj];
				[cell setClipsToBounds:YES];
 				
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				return cell;
			}
			else
			{
				static NSString *Ga2ooHomeCell2 = @"Ga2ooHomeCell2";
				UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell2];
				if(cell == nil)
				{
					cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Ga2ooHomeCell2] autorelease];
				}
				
				cell.textLabel.text = @"No Event Added";
				[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
				cell.textLabel.backgroundColor = [UIColor clearColor];
				cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.backgroundColor = [UIColor clearColor];
				return cell;
			}
		}
		else if(indexPath.section == 1)
		{
			
			if( [appDelegate.arrUpcomingEvents count]>0)
			{
				static NSString *Ga2ooHomeCell3 = @"Ga2ooHomeCell3";
				EventsListCustomCell *cell = (EventsListCustomCell *)[tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell3];
				if(cell == nil)
				{
					cell = [[[EventsListCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ga2ooHomeCell3] autorelease];
				}
 
				EventListBO *obj_ = [appDelegate.arrUpcomingEvents objectAtIndex:indexPath.row];
                
                
                [cell setTheEventInTheCell:obj_];
  				
 				/*NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
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
                   playbtn.tag=indexPath.row + 1000000;
                
                    [playbtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
                    
                    [playbtn addTarget:self action:@selector(btn_starAction:) forControlEvents:UIControlEventTouchUpInside];
                    
               // }
                
                //[cell.contentView addSubview:playbtn];
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
			else
			{
				static NSString *Ga2ooHomeCell4 = @"Ga2ooHomeCell4";
				UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell4];
				if(cell == nil)
				{
					cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Ga2ooHomeCell4] autorelease];
				}
				
				cell.textLabel.text = @"No Event Added";
				[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
				cell.textLabel.backgroundColor = [UIColor clearColor];
				cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];

				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.backgroundColor = [UIColor clearColor];
				return cell;
			}
		}
	}
	else {
		
		if([arrEventFriend count])
		{
			static NSString *Ga2ooHomeCell5 = @"Ga2ooHomeCell5";
			FriendsBO *obj =  [arrEventFriend objectAtIndex:indexPath.row]; 	
			
			FriendTableCell *cell = (FriendTableCell *)[tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell5];
			if (cell == nil) {
				cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:Ga2ooHomeCell5] autorelease];
 			}
				//cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
			static NSString *Ga2ooHomeCell6 = @"Ga2ooHomeCell6";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ga2ooHomeCell6] ;
			if(cell == nil)
			{
				cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Ga2ooHomeCell6] autorelease];;
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
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(tableView.tag!=1111 && tableView.tag!=2222)
	{
		if(indexPath.section == 0 && [appDelegate.arrFeatured count] != 0){
			
			if([appDelegate.arrFeatured count])
			{
				EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 				eventVC.objEventList = [appDelegate.arrFeatured objectAtIndex:indexPath.row];
 				[self.navigationController pushViewController:eventVC animated:YES];
				[eventVC release];	
			}
		}
		else if(indexPath.section == 1 && [appDelegate.arrUpcomingEvents count] != 0){
			
			if([appDelegate.arrUpcomingEvents count])
			{
				EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 				eventVC.objEventList = [appDelegate.arrUpcomingEvents objectAtIndex:indexPath.row];
 				[self.navigationController pushViewController:eventVC animated:YES];
				[eventVC release];	
			}
		}
	}
	else if(tableView.tag == 2222)
	{
		
		
//		UserBO *obj = (UserBO *)[appDelegate.arr_AllFriend objectAtIndex:indexPath.row]; 	
//		if([arrFriendEmails containsObject:obj])
//			[arrFriendEmails removeObjectAtIndex:[arrFriendEmails indexOfObject:obj]];
//		else
//			[arrFriendEmails addObject:obj];
//		[tblFriends reloadData];
		
	}
	else 
	{
		FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
		objFriendDet.objFriend = [arrEventFriend objectAtIndex:indexPath.row];
		[self.navigationController pushViewController:objFriendDet animated:YES];
		[objFriendDet release];
	}
}
#pragma mark UISearchBar delegate  and action methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	keyboardToolBar.frame=CGRectMake(0, 200, 320, 44);
	[UIView commitAnimations];

	return YES;
}

-(void)doneClicked
{
	[self removeSearchBarButtons];
	//[self addTableOfEventsUsingArrayofAddedEventsByChecking:appDelegate.arr_AddedEvents];
	
	if([arrFilteredEvents count])
		[arrFilteredEvents removeAllObjects];
	
	NSString *searchText;
	searchText = txtSearch.text;
	if(!searchText)
	{
		searchText = @"";
	}
	else if([searchText isEqualToString:@""])
	{
		searchText = @" ";
	}
	
    EventsBL *bussinessLayer = [[EventsBL alloc] init];
    NSArray *arr = [bussinessLayer FilerDataUsing:[NSString stringWithFormat:@"EventName contains[cd] %@",searchText]];
    [bussinessLayer release];
    
	if(arr)
	{
		[arrFilteredEvents addObjectsFromArray:arr];
	}	
	eventListViewController *objEventView = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	if(objEventView.arrEvents)
		[objEventView.arrEvents removeAllObjects];
	objEventView.arrEvents = [[NSMutableArray alloc] init];
	[objEventView.arrEvents addObjectsFromArray:arrFilteredEvents];	
	[self.navigationController pushViewController:objEventView animated:YES];
	[objEventView release];
	
}
// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}

-(void)cancelClicked
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	[txtSearch resignFirstResponder];
	[SearchBar resignFirstResponder];
	txtSearch.text = @"";
	keyboardToolBar.frame = CGRectMake(0, 600, 320, 44);
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark -
#pragma mark downloadImage


-(void)displayUserImage:(NSString *)strImagePath
{
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, strImagePath];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
		{
			UIImage *img =[UIImage imageWithData:imageData];
			imgUser = img;
			imgViewProfile.image = img;
			objUser.imgCover = img;
			
			lblAddPhoto.hidden = YES;
            btnProfImage.hidden = YES;
		}
		else
		{
			UIImage *img =[UIImage imageNamed:@"NoImageEvent.png"];
			imgUser = img;
			imgViewProfile.image = img;
			objUser.imgCover = img;
		}
        [imageData release];
		
	}
	else
	{
		UIImage *img =[UIImage imageNamed:@"NoImageEvent.png"];
		imgUser = img;
		imgViewProfile.image = img;
		objUser.imgCover = img;
	}
	
	[UserLayer Update:objUser];
	
	[loader stopAnimating];
    
	
}

-(void)downloadImage:(NSString *)strImagePath Tag:(NSInteger)tag {
	
	NSString *strpath=nil;
	if(tag==12)
	{
		strImagePath = [strImagePath stringByReplacingOccurrencesOfString:@"#38" withString:@""];
		strpath = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, strImagePath];
	}
	else if(tag==15)
		strpath = [NSString stringWithFormat:@"%@%@", imageURL, strImagePath];
	
	HttpRequest *req =[[HttpRequest alloc]init];
	[req GetRequest:strpath Delegate:self Tag:tag ModuleName:strImagePath];
	[req release];
}

- (void)httpResponseReceived:(WebResponse *)response {
	
	if(response.tag ==12 ) 
    {

		if(!response.isError)
        {
            NSString *responseString = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
            NSLog(@"image name %@",responseString);
            
            NSRange rangeIs = [responseString rangeOfString:@"no image" options:NSCaseInsensitiveSearch];
            if (rangeIs.length  >5 )
            {
                UIImage *img =[UIImage imageNamed:@"NoImageEvent.png"];
                imgUser = img;
                imgViewProfile.image = img;
            }
            else 
            {
                UIImage *img =[UIImage imageWithData:response.data];
                imgUser = img;
                imgViewProfile.image = img;
            }
            
            
            lblAddPhoto.hidden = YES;
            btnProfImage.hidden = YES;
        }
		
    
		
		[loader stopAnimating];
	}
	if(response.tag ==15 && !response.isError) {
		
		UIImage *img =[UIImage imageWithData:response.data];
		imgEvent = img;
	}
    
    
    
	
    if (response.tag == 10)
	{
        NSString *strMsg = @"";
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



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    EventsLayer.delegate = nil;
	[EventsLayer release];
	UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
	UserLocationLayer.delegate = nil;
	[UserLocationLayer release];
	[obj_LMV release];
	UserLayer.delegate = nil;
	[UserLayer release];
	[arrUserLocation release];	
	[btnEvents release];
	[arrFriendEmails release];
	[arrFilteredEvents release];
	[tableViewEv release];
	[vwSearch release];
	[arrEventFriend release];
	
	backImageView.image=nil;
	[backImageView release];
	[pickerArray release];
	[notifyBl release];
    [RecomBL release];
    [super dealloc];
}



@end
