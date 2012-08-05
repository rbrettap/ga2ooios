//
//  eventListViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "eventListViewController.h"
#import "EventDetailViewController.h"
#import "TableViewCellForHomePage.h"
#import "EventsListCustomCell.h"
#import "UserBO.h"
#import "FriendTableCell.h"
#import "EventFriendListBL.h"
#import "BusinessListBL.h"
#import "HttpRequest.h"
#import "FriendDetailViewController.h"

@implementation eventListViewController
@synthesize arrEvents;
@synthesize arrEventFriend;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	EventFriendLayer = [[EventFriendListBL alloc]init];
	EventFriendLayer.delegate = self;
    
    UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;

	arrEventFriend = [[NSMutableArray alloc] init];
    
	//[self setBackgroundImageToView:self.view];
	[self setTopBarImageToViewWithHome:self.view];
	countForArrow = 0;
	
	UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
	btnBack.frame = CGRectMake(5, 7, 51, 30);
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back_btnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnBack];
	
	tblEventList.backgroundColor = [UIColor clearColor];
	arrFriendEmails = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self rempoveFriendsView];
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
		tblEventList.userInteractionEnabled	= YES;
		
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
	
	tblEventList.userInteractionEnabled	= NO;
	
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

-(void)popUpFriendListView
{
	tblEventList.userInteractionEnabled	= NO;
	
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
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
}

-(void)rempoveFriendsView
{
	tblEventList.userInteractionEnabled	= YES;
	
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

#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag == 1111 || tableView.tag == 2222){
		return 60;
	}
	else {
		return 80;
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView.tag!=1111 && tableView.tag != 2222){
		if([arrEvents count])
		{
			for(UIView *vw in tableView.subviews)
			{
				if(vw.tag == 54)
				{
					[vw removeFromSuperview];
				}
			}
			return [arrEvents count];
		}
		else {
			
			return 1;
		}
	}
	else{
		return [arrEventFriend count];
	}
}


// Customize the appearance of table view cells.


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(tableView.tag!=1111 && tableView.tag != 2222)
	{
		
 		
		if([arrEvents count])
		{
            static NSString *SearchEventCell = @"SearchEventCell";
            EventsListCustomCell *cell = (EventsListCustomCell *)[tableView dequeueReusableCellWithIdentifier:SearchEventCell];
            if(cell == nil)
            {
                cell = [[[EventsListCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SearchEventCell] autorelease];
            }
            EventListBO *obj_ = [arrEvents objectAtIndex:indexPath.row];
            [cell setTheEventInTheCell:obj_];
            
          /*  NSMutableArray *arrEvents1 = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
            BOOL isEventExists = NO;
            if([arrEvents1 count] && !isEventExists)
            {
                NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[obj_.Eventid integerValue]];
                [arrEvents1 filterUsingPredicate:predic];
                if([arrEvents1 count])
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
                
            //}
            
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
            static NSString *SearchEventCell1 = @"SearchEventCell1";

			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchEventCell1];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:SearchEventCell1] autorelease];
			}
			
			cell.textLabel.text = @"No Events";
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		}
	}
	else {
        static NSString *SearchEventCell2 = @"SearchEventCell2";
        FriendsBO *obj =  [arrEventFriend objectAtIndex:indexPath.row]; 	
        
        FriendTableCell *cell = (FriendTableCell *)[tableView dequeueReusableCellWithIdentifier:SearchEventCell2];
        if (cell == nil) {
            cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:SearchEventCell2] autorelease];
        }
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.imgViewDarkBG.image = nil;
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
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(tableView.tag != 2222 && tableView.tag != 1111)
	{
	
		 [tableView deselectRowAtIndexPath:indexPath animated:YES];
		 if([arrEvents count])
		 {
			 EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
			 eventVC.objEventList = [arrEvents objectAtIndex:indexPath.row];
			 [self.navigationController pushViewController:eventVC animated:YES];
			 [eventVC release];
		 }
	}
	else if(tableView.tag == 2222)
	{
		NSLog(@"dadfsfds");		
	}
	else 
	{
		
		FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
		objFriendDet.objFriend = [arrEventFriend objectAtIndex:indexPath.row];
		[self.navigationController pushViewController:objFriendDet animated:YES];
		[objFriendDet release];
		
	}
	
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(tableView.tag!=1111 && tableView.tag!=2222)
	{
        if( [arrEvents count]>0)
        {
                [(EventsListCustomCell *)cell showEventsImage];
                
            }
     }
    else{
    	[(FriendTableCell *)cell showUserImage];
        
    }
}

#pragma mark -

#pragma mark UIButton Methods

-(void)back_btnClicked
{
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

-(void)btnFriendclicked:(id)sender
{
 
    objEvent=[arrEvents objectAtIndex:[sender tag]];
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
           // [oneFriend release];
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
	objEvent=[arrEvents objectAtIndex:[sender tag]];
	
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 400;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
	
}


#pragma mark -

#pragma mark IBAction Methods

-(IBAction) eventButton_onTouchUpInside:(id)sender{
	UIButton *btn = (UIButton *)sender;
	EventDetailViewController *eventVC = [[EventDetailViewController alloc]initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
	eventVC.objEvent = [arrEvents objectAtIndex:btn.tag];
	[self.navigationController pushViewController:eventVC animated:YES];
	[eventVC release];
}

#pragma mark -

#pragma mark Fuctions

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


#pragma mark -

#pragma mark actionSheet Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1234)
	{
		 objEvent=[arrEvents objectAtIndex:intTagValue-100];
        
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
        objEvent=[arrEvents objectAtIndex:intTagValue-100];
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
		NSMutableArray *arrEvents1 = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
		BOOL isEventExists = NO;
		if([arrEvents1 count] && !isEventExists)
		{
			NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[evnts.Eventid integerValue]];
			[arrEvents1 filterUsingPredicate:predic];
			if([arrEvents1 count])
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
    [UserFavBussLayer deleteFavorite];
    */
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
        NSMutableArray *arrEvents1 = [UserFavBussLayer SelectfavEventsByKey:[objEvent.Eventid integerValue]];
        
        UserFavEvents *addFav   = [[UserFavEvents alloc]init];
        AddFavEventBO *objAddFav = [arrEvents1 objectAtIndex:0];
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
    [tblEventList reloadData];
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
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
	[self removeSyncLoader];
}
 
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if(actionSheet.tag == 400)
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

#pragma mark -

#pragma mark mailComposeController delegate

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

#pragma mark -



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	
    UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
    
	EventFriendLayer.delegate = nil;
	[EventFriendLayer release];
	[arrFriendEmails release];
	tblEventList.delegate = nil;
	tblEventList.dataSource = nil;
	[tblEventList release];
	//[arrEvents release];
	[arrEventFriend release];
	[super dealloc];
}



@end
