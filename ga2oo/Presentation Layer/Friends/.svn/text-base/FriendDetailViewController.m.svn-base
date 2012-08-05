//
//  FriendDetailViewController.m
//  Ga2oo
//
//  Created by winit on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "UserFriendCalenderViewController.h"
#import "CalenderViewController.h"
#import "EventsListCustomCell.h"
#import "HttpRequest.h"
#import "GlobalConstant.h"
#import "FriendTableCell.h"
#import "EventFriendListBL.h"
#import "BusinessListBL.h"
#import "FriendDetailViewController.h"

@implementation FriendDetailViewController

@synthesize objFriend;
@synthesize arrEventFriend;
@synthesize arrFriendEvents;
@synthesize arrThisFriendEvents;
@synthesize ForAllUser;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

	countForArrow = 0;
	arrEventFriend = [[NSMutableArray alloc] init];
    arrFriendEvents= [[NSMutableArray alloc] init];
    arrFriendEmails = [[NSMutableArray alloc] init];
    arrThisFriendEvents = [[NSMutableArray alloc] init];
    
    UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
    
    EventFriendLayer = [[EventFriendListBL alloc]init];
	EventFriendLayer.delegate = self;

	NSString *strProfileTitle = [NSString stringWithFormat:@"%@'s Profile",objFriend.firstName];
	lblTitlee.text = strProfileTitle;
	lblName.text = objFriend.firstName;
    NSString *areAddr = @"";
    if ([objFriend.address length]) {
        areAddr = [areAddr stringByAppendingFormat:@"%@,",objFriend.address];
    }
    if ([objFriend.city length]) {
        areAddr = [areAddr stringByAppendingFormat:@"%@,",objFriend.city];
    }
    if ([objFriend.state length]) {
        areAddr = [areAddr stringByAppendingFormat:@"%@,",objFriend.state];
    }
    if ([objFriend.country length]) {
        areAddr = [areAddr stringByAppendingFormat:@"%@",objFriend.country];
    }
	 lblAddress.text = areAddr;
	
	[imgViewImage.layer setMasksToBounds:YES];
	imgViewImage.layer.cornerRadius = 10.0;
	imgViewImage.layer.borderWidth = 2.0;
	imgViewImage.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
	
	loader=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	loader.center =imgViewImage.center;
	[self.view addSubview:loader];
	[self.view bringSubviewToFront:loader];
	[loader startAnimating];
	
	if(objFriend.friendImage)
	{
		imgViewImage.image = objFriend.friendImage;
		[loader stopAnimating];
	}
	else
    {
        [NSThread detachNewThreadSelector:@selector(downloadFriendImage) toTarget:self withObject:nil];
    }
 
    if(!ForAllUser)
    {
      [self getFriendsEvents];
    }
    else 
    {
        SendMessage.hidden = YES;
        SeePelandar.hidden = YES;
        tableViewFriend.hidden = YES;
    }
 }
-(void)getFriendsEvents{

    EventListBL *eventListBl = [[EventListBL alloc]init];
    NSLog(@"objFriend.FriendId %@",objFriend.FriendId);
	[appDelegate.arrFriendEvents removeAllObjects];
    [appDelegate.arrFriendEvents addObjectsFromArray:[eventListBl SelectAllEventsAccordingToFriend:objFriend.FriendId]];
    
    NSLog(@"appDelegate.arrFriendEvents %i",[appDelegate.arrFriendEvents count]);
	
	NSMutableArray *FeaturedEvents = [[NSMutableArray alloc] init];
    
    for(int i = 0; i<[appDelegate.arrFriendEvents count]; i++)
	{
		EventListBO *objEventTemp = [appDelegate.arrFriendEvents objectAtIndex:i];
        BOOL isEvtDtFeatured = [appDelegate featuredDateIs:objEventTemp.event_start_date];
		if(isEvtDtFeatured)
		{
			[FeaturedEvents addObject:objEventTemp];
        }
	}
    [arrThisFriendEvents removeAllObjects];
    [arrThisFriendEvents addObjectsFromArray:FeaturedEvents];
    [FeaturedEvents release];
	
	//[arrThisFriendEvents removeAllObjects];
    
    [eventListBl release];
}
-(void)viewWillAppear:(BOOL)animated
{
	[self removeFriendsView];
}

#pragma mark Methods used localy

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


-(void) addTopBar
{
	NSString *strimgname = nil;
	strimgname = @"top_bar";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 0, 320, 45);
	[self.view addSubview:imgv];
	[self.view sendSubviewToBack:imgv];
	[imgv release];
	
	UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	lblTitle.backgroundColor = [UIColor clearColor];
	lblTitle.font = [UIFont boldSystemFontOfSize:19];
	lblTitle.textAlignment = UITextAlignmentCenter;
	lblTitle.textColor = [UIColor whiteColor];
	lblTitle.text = @"Detail";
	[self.view addSubview:lblTitle];
	[lblTitle release];
	
	//add back button to the logo_bar
	UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
	btnBack.backgroundColor = [UIColor clearColor];
	btnBack.frame = CGRectMake(5, 7, 61, 32);
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnBack];	
}

#pragma mark IBAction Action Methods

-(IBAction)backButtonPressed{
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) MsgTouchUpInside:(id) sender
{
	NSLog(@"Message touched");
	
	NSArray *RecipientArr = [[NSArray alloc]initWithObjects:objFriend.email,nil];
	
	if([MFMailComposeViewController  canSendMail])
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		mail.mailComposeDelegate = self;
		[mail.navigationBar setTintColor: [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1] ];
		if ([MFMailComposeViewController canSendMail]) {
			[mail setToRecipients:RecipientArr];
			[mail setSubject:[NSString stringWithFormat:@""]];
			
			//			NSString *strDesc = [NSString stringWithFormat:URLJobDescriptionForMailBody,objClassified.ClassifiedId];
			//[mail setMessageBody:strDesc isHTML:YES];
			[self presentModalViewController:mail animated:YES];
		}
		[mail release];		
	}
    [RecipientArr release];
	
}
-(IBAction) CalendarTouchUpInside:(id) sender
{
   
 
    if([objFriend.is_calendar_shared caseInsensitiveCompare:@"True"] == NSOrderedSame)
    {
        
        NSArray *arr = self.navigationController.viewControllers;
        NSLog(@"before count = %i",[arr count]);
        int index = -1;
        for (UIViewController *controller in arr) {
            if ([controller isKindOfClass:[UserFriendCalenderViewController class]]) {
                index = [arr indexOfObject:controller];
                NSLog(@"index of login screen = %i",index);
            }
        }
        
        if (index>=0) {
            NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [allViewControllers removeObjectIdenticalTo:[arr objectAtIndex:index]];
            self.navigationController.viewControllers = allViewControllers;
        }
        
        UserFriendCalenderViewController *objCalVC = [[UserFriendCalenderViewController alloc] initWithNibName:@"UserFriendCalenderViewController" bundle:[NSBundle mainBundle]];
        objCalVC.BackBtnName = @"Back";
        objCalVC.SelectedFriendId = objFriend.FriendId;
        objCalVC.ScreenTitle = objFriend.firstName;
        NSLog(@"objFriend.UserId %@",objFriend.FriendId);
        [self.navigationController pushViewController:objCalVC animated:YES];
        [objCalVC release];
    }
    else 
    {
        UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:@"Friend disable its calendar sharing" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alerts show];
        [alerts release];
    }

	
	
	
}

#pragma mark Button Action Methods

-(void)btn_starAction:(id)sender
{
	intTagValue = 0;
	intTagValue = [sender tag];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Choose a category to make a favorite?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Company", @"Event", nil];
	alert.tag = 1234;
	[alert show];
	[alert release];	
}

-(void)btn_shareAction:(id)sender
{
	objEvent=[arrThisFriendEvents objectAtIndex:[sender tag]];
	
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 400;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
	
}

-(void)btnFriendclicked:(id)sender
{
	
 
    
    objEvent=[arrThisFriendEvents objectAtIndex:[sender tag]];
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
            //[oneFriend release];
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
			UIImage *img = [UIImage imageNamed:@""];//objEvent.imgCover;
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
    
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsgs delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
}




-(void)popUpFriendListView
{
	tableViewFriend.userInteractionEnabled	= NO;
	if (friendsView) {
        [friendsView release];
    }
    
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
	tblFriends.separatorColor = [UIColor clearColor];
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

-(void)popUpMail{
	
	tableViewFriend.userInteractionEnabled	= NO;
	
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
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
	
}
-(void)btnOkClicked{
	if([arrFriendEmails count]){

		tableViewFriend.userInteractionEnabled	= YES;
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

-(void)closeBtnClicked:(id)sender
{
	tableViewFriend.userInteractionEnabled	= YES;	
 	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	friendsView.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(removeFriendsView) withObject:nil afterDelay:1.0];
	
}

-(void)removeFriendsView
{
	tableViewFriend.userInteractionEnabled	= YES;
	
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


#pragma mark MFMailCompose UIActionSheet delegate

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

-(void)eventFrienDownload
{
	
	[EventFriendLayer deleteAll];
	[EventFriendLayer LoadUser:objEvent.UserID];
}

-(void)LoadEventFriendLoadingCompleted
{
 	[self.arrEventFriend removeAllObjects];
	self.arrEventFriend = [EventFriendLayer SelectAll];
	
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
	[self removeSyncLoader];
}
 
- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(modalView.tag == 400 || modalView.tag == 401)
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
			/*
             facebookConnectViewController *obj = [[facebookConnectViewController alloc]initWithNibName:@"facebookConnectViewController" bundle:[NSBundle mainBundle]];
             obj.objTemp = objEvent;
             [self.navigationController pushViewController:obj animated:YES];
             [obj release];
			 */
			
		}
		else if (buttonIndex == 5) {
			/*
             twitterViewController *obj = [[twitterViewController alloc]initWithNibName:@"twitterViewController" bundle:[NSBundle mainBundle] withDataToBePublished:objEvent.name];
             [self.navigationController pushViewController:obj animated:YES];
             [obj release];
			 */
		}
		else if (buttonIndex == 6) {
			
		}
		
	}
}


#pragma mark UIAlertView delegate

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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1234)
	{
        
            objEvent=[arrThisFriendEvents objectAtIndex:intTagValue-1000000];
        		
		if(buttonIndex==0)
		{
			[self loadAddFavrXml:objEvent forCompany:YES];
		}
		else if(buttonIndex==1)
		{
			[self loadAddFavrXml:objEvent forCompany:NO];
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

-(void)showAlerts:(NSString*)strMsg
{
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
}


-(void)FavoriteBusinessEventsLoadingCompleted:(NSString*)strMsgs
{
	[self showAlerts:strMsgs];
}


#pragma mark -

#pragma mark Table view methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(tableView.tag != 2222 && tableView.tag != 1111)
	{
		UIView *viewForHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
		[viewForHeader setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1.0]];
		
		UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 320, 20)];
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.textColor = [UIColor colorWithRed:110/255.0 green:150/255.0 blue:165/255.0 alpha:1.0];
		lblTitle.backgroundColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
		[lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.text = @"  Upcoming Events";
		[viewForHeader addSubview:lblTitle];
		[lblTitle release];
		
		UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 300, 2)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
		imgSep.backgroundColor = [UIColor clearColor];
		[viewForHeader addSubview:imgSep];
		[imgSep release];
		
		return [viewForHeader autorelease];
	}
	else {
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(tableView.tag == 2222 && tableView.tag != 1111){
		return 1;
	}
	else{
		return 35.0;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag != 2222 && tableView.tag != 1111){
		return 80;
	}
	else {
		
		return 60;	
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView.tag == 2222 || tableView.tag == 1111){
		
		return [arrEventFriend count];
	}
	else{
		
		if([arrThisFriendEvents count])
			return [arrThisFriendEvents count];		
		else
			return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(tableView.tag!=2222 && tableView.tag != 1111)
	{
		
		if([arrThisFriendEvents count]>0)
		{
			static NSString *FriendDetailCell1 = @"FriendDetailCell1";
			EventsListCustomCell *cell = (EventsListCustomCell *)[tableView dequeueReusableCellWithIdentifier:FriendDetailCell1];
			if(cell == nil)
			{
				cell = [[[EventsListCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FriendDetailCell1] autorelease];
			}
			
			EventListBO *obj_ = [arrThisFriendEvents objectAtIndex:indexPath.row];
			
            [cell setTheEventInTheCell:obj_];
            
            cell.btn_star.tag = indexPath.row+100;
			
			cell.btn_star.hidden = YES;
			
			
			UIButton *playbtn = [[UIButton alloc]initWithFrame:CGRectMake(205,45,41,26)];
			playbtn.tag=indexPath.row + 1000000;
			
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
		else
		{
			static NSString *FriendDetailCell2 = @"FriendDetailCell2";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendDetailCell2];
			if(cell == nil)
			{
				cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FriendDetailCell2] autorelease];
			}
						
			cell.textLabel.text = @"No Event Added";
			[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.textLabel.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		}
	}
	else {
		
		if([arrEventFriend count])
		{
			static NSString *FriendDetailCell3 = @"FriendDetailCell3";
			FriendsBO *obj =  [arrEventFriend objectAtIndex:indexPath.row]; 	
			
			FriendTableCell *cell = (FriendTableCell *)[tableView dequeueReusableCellWithIdentifier:FriendDetailCell3];
			if (cell == nil) {
				cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:FriendDetailCell3] autorelease];
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
			//[cell showUserImage];
			return cell;
		}
		else
		{
			static NSString *FriendDetailCell4 = @"FriendDetailCell4";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendDetailCell4];
 			if(cell == nil)
			{
				cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FriendDetailCell4] autorelease];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(tableView.tag!=1111 && tableView.tag!=2222)
	{
 			if( [arrThisFriendEvents count]>0)
			{
                [(TableViewCellForHomePage *)cell showEventsImage];
             }
     }
    else{
        if ([arrEventFriend count]) {
            [(FriendTableCell *)cell showUserImage];
         }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(tableView.tag!=1111 && tableView.tag != 2222)
	{
		if([arrThisFriendEvents count])
		{
			EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 			eventVC.objEventList = [arrThisFriendEvents objectAtIndex:indexPath.row];
 			[self.navigationController pushViewController:eventVC animated:YES];
			[eventVC release];	
		}
		
	}
	else if(tableView.tag == 2222)
	{
				
	}
	else 
	{
		FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
		objFriendDet.objFriend = [arrEventFriend objectAtIndex:indexPath.row];
		[self.navigationController pushViewController:objFriendDet animated:YES];
		[objFriendDet release];
	}
}


#pragma mark -
#pragma mark downloadImage

-(void)downloadFriendImage {
 	
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if (!objFriend.imageUrl || [objFriend isEqual:[NSNull null]]) {
		
		imgViewImage.image = [[UIImage imageNamed:@"icon.png"] retain];
        [loader stopAnimating];
		return; // No url? Then no Image!
	}
	
	NSError *error = nil;
	NSString *str = [[NSString alloc] initWithFormat:@"%@%@", Ga2ooimageURL, objFriend.imageUrl];
	str = [str stringByReplacingOccurrencesOfString:@"#38;" withString:@""];
 	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
 	
	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
			imgViewImage.image = [[UIImage alloc]initWithData:imageData];
		else
			imgViewImage.image = [UIImage imageNamed:@"icon.png"];
		[imageData release];
		
	}
	else
	{
		imgViewImage.image = [UIImage imageNamed:@"icon.png"];
	}
    [loader stopAnimating];
    [pool release];
 }

 

#pragma mark -


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [EventFriendLayer release];
    [arrFriendEvents release];
	[loader release];
	[arrFriendEmails release];
	[lblAddress release];
	[lblName release];
	[imgViewImage release];
	tableViewFriend.delegate = nil;
	tableViewFriend.dataSource = nil;
	[tableViewFriend release];
	[arrEventFriend release];
    UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
    
	[super dealloc];
}


@end
