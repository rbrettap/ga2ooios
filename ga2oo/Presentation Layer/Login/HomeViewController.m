//
//  HomeViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "FriendsBO.h"
#import <QuartzCore/QuartzCore.h>
 #import "EventCategoryBL.h"
#import "GUserEventXML.h"
#import "UserFavEvents.h"

static int count = 1;
@implementation HomeViewController

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	isUser = YES;
	updateLayer = [[AuthenticateUserBL alloc] init];
    updateLayer.delegate = self;
    
	UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
	
	UserLayer = [[UserBL alloc]init];
	UserLayer.delegate = self;
	
    
    objGa2ooUsersBL = [[Ga2ooUsersBL alloc]init];
	objGa2ooUsersBL.delegate = self;
 
    categotyBl= [[CategoryBL alloc]init];
	categotyBl.delegate = self;
    //[categotyBl dele]
	
	objFrndBL = [[FriendsBL alloc]init];
	objFrndBL.delegate = self;
     
    UserLocationLayer = [[UserLocationBL alloc]init];
    UserLocationLayer.delegate = self;
	
 	EventsLayer = [[EventListBL alloc]init];
	EventsLayer.delegate = self;
     
    EventsImageLayer = [[EventImagesBL alloc]init];
	EventsImageLayer.delegate = self;
     
    EventsimgLayer = [[EventsBL alloc]init];
	EventsimgLayer.delegate = self;
 
	BusinessListLayer = [[BusinessListBL alloc]init];
	BusinessListLayer.delegate = self;
 	
	notifyBL = [[NotificationsBL alloc] init];
	notifyBL.delegate = self;
      
    RecomBL = [[EventRecommendateBL alloc] init];
	RecomBL.delegate = self;
    
	[UserFavBussLayer deleteAll];
    [UserLayer deleteAll];
    [objFrndBL deleteAll];
    [UserLocationLayer deleteAll];
    [EventsLayer deleteAll];
    [EventsImageLayer deleteAll];
    [EventsimgLayer deleteAll];
    [BusinessListLayer deleteAll];
    [notifyBL deleteAll];
    [RecomBL deleteAll];
	
    
    

	self.navigationController.navigationBar.hidden = YES;
	txtFieldUserName.textColor = [UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
	txtFieldPassword.textColor =  [UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
}

-(void)viewWillAppear:(BOOL)animated
{
	objUser = (UserBO *)[UserLayer SelectByKey:appDelegate.currentUserID withMode:NO];
	txtFieldUserName.text =objUser.Username;// @"rbrett2010";
	txtFieldPassword.text = objUser.Password;//@"rbrett";
    
    
    
    
 
}
#pragma mark -
#pragma mark IBAction Methods

-(IBAction)submitBtnClicked
{
	PersonalViewController *objReg= [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:objReg animated:YES];
	[objReg release];
}
//sav curr overdraft casgcredi loanacc nre  card pay
-(void)LoginValidation
{
	
	if([txtFieldUserName.text length]==0)
	{
		UIAlertView *alertEnterUN = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter username." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterUN show];
		[alertEnterUN release];
	}
	else if([txtFieldPassword.text length] == 0)
	{
		UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterPw show];
		[alertEnterPw release];		
	}
	else {
		
		[txtFieldUserName resignFirstResponder];
		[txtFieldPassword resignFirstResponder];
		[self loadAnimation];
		
		if(appDelegate.isNetAvail)
		{
			if (![appDelegate isHostReachable:hostURL])
			{
				[appDelegate showServerNotAvailable];
				[self removeSyncLoader];
			}
			else {
				isUser = YES;
				[self AuthenticateUser];
 
			}

 			[appDelegate.arr_User removeAllObjects];
		}
		else {
			[appDelegate noInternetConnectionAlert];
			[self removeSyncLoader];
		}
 	}
}

-(void)AuthenticateUser
{
 		NSString *soapMsg = [[[NSString alloc] initWithFormat:@
							 "<useraccount>"
							 "<username>%@</username>"
							 "<password>%@</password>"
							 "</useraccount>",
							 txtFieldUserName.text, txtFieldPassword.text] autorelease];
		
		
		[updateLayer LoadAuthenticateUserWith:soapMsg];
   // [soapMsg release];
	 
}
-(void)UserLoadingCompleted
{
	if(isUser)
	{
		count =1;
		
		[objFrndBL LoadFriends];
		[appDelegate.arrAllFriendIds removeAllObjects];

		 [appDelegate.arr_FavoritesID removeAllObjects];
        //[self LoadAllEvents];

 		[self LoadUserEventList];
   	}
	else {
		if (count == 1) {
  		}
 	}
}

-(void)LoadUserEventList
{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	GUserEventXML *parser = [GUserEventXML saxParser];
	parser.delegate = self;
    parser.SelectedUserId = appDelegate.currentUserID;
	[parser getData];
	parser = nil;
	[pool release];
}


- (void)GUserEventXML_Error:(GUserEventXML*)parser encounteredError:(NSError *)error
{
    NSLog(@"Favorite count error");
    [self LoadAllEvents];

}
- (void)GUserEventXML_Finished:(NSMutableArray*)parser
{
    NSLog(@"Favorite count %i",[appDelegate.arr_FavoritesID count]);
    [self LoadAllEvents];
}
-(void)LoadAllEvents{
    [appDelegate.arr_AllEvents removeAllObjects];
    
    EventsLayer.ModeType = GetEventList;
    EventsLayer.str_type = [NSString stringWithFormat:@""];
    EventsLayer.str_date = [NSString stringWithFormat:@""];
    EventsLayer.str_category = [NSString stringWithFormat:@""];
    
    [EventsLayer LoadEventList];
    ///////////// cut from event list completes
    /////////////


}
-(void)AuthenticateUserCompleted:(AuthenticateUserBO *)Object
{
	
 	if(Object)
	{
		if([Object.Response isEqualToString:@"Timed out"])
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"Your request has been timed out, please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
		}
		else if([Object.Response isEqualToString:@"-2"]){
			[self removeSyncLoader];
			UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter correct username." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertEnterPw show];
			[alertEnterPw release];	
		}
        else if([Object.Response isEqualToString:@"-1"])
        {
            [self removeSyncLoader];
			UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter correct password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertEnterPw show];
			[alertEnterPw release];	
        }

		else if(Object.UserId)
 		{
			[self clearDatabase];
  			appDelegate.currentUserID = Object.UserId;
			isUser = YES;
			[UserLayer LoadUser:appDelegate.currentUserID];
  		}
		else if(Object.UserId==0){
			[self removeSyncLoader];
			UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter correct username and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertEnterPw show];
			[alertEnterPw release];	
			
		}

		 
	}
	else {
		UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Invalid email or password. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterPw show];
		[alertEnterPw release];	
	}
 
}

-(void)clearDatabase
{

	[UserFavBussLayer deleteAll];
 	[UserLayer deleteAll];
 	[objFrndBL deleteAll];
 	[EventsLayer deleteAll];
    [EventsImageLayer deleteAll];
    [EventsimgLayer deleteAll];
 	[UserLocationLayer deleteAll];
 	[BusinessListLayer deleteAll];
    [notifyBL deleteAll];
    [RecomBL deleteAll];
    [categotyBl deleteAll];

    EventCategoryBL *eventcatBl = [[EventCategoryBL alloc]init];
    [eventcatBl deleteAll];
    [eventcatBl release]; 

}
-(void)EventsListLoadingCompleted:(NSMutableArray*)arrData
{
    NSMutableArray *FavEvents = [[NSMutableArray alloc]init];
    
    [appDelegate.arrTotalEvents removeAllObjects];
    
    [appDelegate.arrTotalEvents addObjectsFromArray:[EventsLayer SelectAllEventsAddingNoOfFriends]];
    [self ActiveEvents];
    
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
    [objGa2ooUsersBL deleteAll];
    [objGa2ooUsersBL LoadGa2ooUser];  // working
    [categotyBl LoadCategory];
    [BusinessListLayer LoadBusinessList];  // working

       
		
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


-(void)InsertFavEvents:(NSMutableArray*)arrEvents
{
	NSMutableArray *arrFavEvents = [[NSMutableArray alloc]init];
	for(EventListBO *evbo in arrEvents)
	{
		
			AddFavEventBO *addFavBo   = [[AddFavEventBO alloc]init];
			    addFavBo.UserId           = [appDelegate.currentUserID integerValue];
			    addFavBo.EventId          = [evbo.Eventid integerValue];
        
             NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"strEventId == %@",evbo.Eventid];
              NSArray *arr1 = [appDelegate.arr_FavoritesID filteredArrayUsingPredicate:pred1];
        
			    addFavBo.UserAddedEventId = [[[arr1 objectAtIndex:0] strUserAddedEventId] integerValue];
				[arrFavEvents addObject:addFavBo];
				[addFavBo release];
			
		
	}
	if([arrFavEvents count])
	{
    	[self InsertFavBOEvents:arrFavEvents];
	}
	[arrFavEvents release];
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


-(void)Ga2ooUsersLoadingCompleted:(NSMutableArray *)arrGa2ooUsers{

    [notifyBL LoadNotifications]; 
}

-(void)NotificationsLoadingCompleted
{
    [RecomBL LoadEventRecommendate];
	
 
}


-(void)RecommendationLoadingCompleted
{
    [self removeSyncLoader];
    [appDelegate AddTabBarViewControllers];
	[appDelegate.window addSubview:appDelegate.tabBarController.view];
}

-(void)FriendsLoadingCompleted:(NSMutableArray *)arrFriends
{

	//isUser = NO;
//	for(FriendsBO *objFrnd in arrFriends)
//		[UserLayer LoadUser:objFrnd.FriendId];
//	
  
}

-(void)UserLocationLoadingCompleted
{
 	[appDelegate.arr_AllEvents removeAllObjects];
    
    EventsLayer.ModeType = GetEventList;
    EventsLayer.str_type = [NSString stringWithFormat:@""];
    EventsLayer.str_date = [NSString stringWithFormat:@""];
    EventsLayer.str_category = [NSString stringWithFormat:@""];
    
	[EventsLayer LoadEventList];
/////////////////////
}

-(void)BusinessListLoadingCompleted
{
	//[self removeSyncLoader];
	//[appDelegate.window addSubview:appDelegate.tabBarController.view];
}
-(void)CategoryLoadingCompleted
{
    NSLog(@"Category complete");
}
-(IBAction) loginClicked:(id) sender;
{
//    txtFieldUserName.text = @"rbrett2010";
//    txtFieldPassword.text = @"rbrett";
	[self LoginValidation];
}

#pragma mark -

#pragma mark UITextField delegate

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if(textField.tag != 8)
	{
		//
	}
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if(textField.tag == 8)
	{
		[txtFieldPassword becomeFirstResponder];
	}
	else {
		[self LoginValidation];

		return [textField resignFirstResponder];
	}
	
	return YES;
}

#pragma mark -
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	
	UserLocationLayer.delegate = nil;
	[UserLocationLayer release];
	BusinessListLayer.delegate = nil;
	[BusinessListLayer release];
	EventsLayer.delegate = nil;
	[EventsLayer release];
    EventsImageLayer.delegate = nil;
    [EventsImageLayer  release];
    EventsimgLayer.delegate = nil;
    [EventsimgLayer release];
	objFrndBL.delegate = nil;
	[objFrndBL release];
	UserLayer.delegate = nil;
	[UserLayer release];
	UserFavBussLayer.delegate = nil;
	[UserFavBussLayer release];
	updateLayer.delegate = nil;
	[updateLayer release];
	[txtFieldUserName release];
	[txtFieldPassword release];
    [super dealloc];
}


@end
