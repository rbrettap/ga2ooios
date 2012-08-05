//
//  FriendsViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendTableCell.h"
#import "FriendsBL.h"

@implementation FriendsViewController

@synthesize arrMyFriends;
 @synthesize isSetting;
@synthesize backImageView;
@synthesize upTimeLabel;
@synthesize backLabel;

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
    
    appDelegate1 = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];

    
	[self setUpRefreshView];
	//[self setBackgroundImageToView:self.view];
	
 	 
 
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"topbarGa2oo" ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 0, 320, 44);
	[self.view addSubview:imgv];
	[imgv release];
	
    UIButton *btnLogOut = [UIButton buttonWithType:UIButtonTypeCustom];
	btnLogOut.frame = CGRectMake(246, 6, 69, 31);
	[btnLogOut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logoff_bt" ofType:@"png"]] forState:UIControlStateNormal];
	[btnLogOut addTarget:self action:@selector(logoutBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnLogOut];

    
	 	
 	arrMyFriends = [[NSMutableArray alloc] init];
 		
	tblMyFriends.backgroundColor = [UIColor clearColor];
	tblMyFriends.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
	appDelegate1.window.userInteractionEnabled = NO;
    [arrMyFriends removeAllObjects];
    objFrndBL = [[FriendsBL alloc]init];
	objFrndBL.delegate = self;
    [arrMyFriends addObjectsFromArray:[objFrndBL SelectAll]];
    
    
    
    //sort the friends as per first name
	NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
  	[arrMyFriends sortUsingDescriptors:[NSArray arrayWithObjects:nameSortDescriptor,nil]];
    [nameSortDescriptor release];
    
	[tblMyFriends reloadData];
	appDelegate1.window.userInteractionEnabled = YES;
}


#pragma mark refreshtable

-(void)setUpRefreshView
{
	
	UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
	UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, -3, theImage.size.width, theImage.size.height)];
	theImageView.image = theImage;
	self.backImageView = theImageView;
	//self.backImageView.frame = CGRectMake(backImageView.frame.origin.x, -theImageView.frame.origin.y, theImage.size.width, theImage.size.height);
	[theImageView release];
	CGAffineTransform transform = backImageView.transform;
	transform = CGAffineTransformRotate(transform, M_PI);
	backImageView.transform = transform;
	
	UILabel *theLabel           = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 280, 25)];
	UILabel *theUpdateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 280, 20)];
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
	refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, 320, 300)];
	refreshView.backgroundColor = [UIColor colorWithRed:0.88627 green:0.90588 blue:0.92941 alpha:1];
	[refreshView addSubview:upTimeLabel];
	[refreshView addSubview:backLabel];
	[refreshView addSubview:backImageView];
	//[self.view addSubview:refreshView];
	[self.view insertSubview:refreshView atIndex:1];
	//[self.view sendSubviewToBack:refreshView];
	
	backImageViewStatu = NO;
	isRefreshStatu     = NO;
}

#pragma mark --------- Scroll View Delegate -------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	
	refreshView.backgroundColor = [UIColor colorWithRed:0.88627 green:0.90588 blue:0.92941 alpha:1];
	
	UIImage *theImage = [UIImage imageNamed:@"Refresh_White.png"];
	
	if(scrollView.contentOffset.y<=0)
	{
		CGRect rect         = CGRectMake(0, 0, 320, 180);
		rect.origin.y       -= scrollView.contentOffset.y+5;
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
		refreshView.frame = CGRectMake(0, -100, 320, 180);
	}
	if(scrollView.contentOffset.y == 0)
	{
		refreshView.backgroundColor =[ UIColor clearColor];
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	if (scrollView.contentOffset.y<= -60)
		isRefresh = YES;
	else 
		isRefresh = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if(isRefresh)
	{
		
		isRefresh = NO;
		[self refreshData];
	}
}

-(void)refreshDataPart
{
    
    [self loadAnimation];
	[objFrndBL deleteAll];
	
    
	[appDelegate1.arrAllFriendIds removeAllObjects];
	[objFrndBL LoadFriends];
	
}

-(void) refreshData
{
    tblMyFriends.scrollEnabled = NO;
    [self performSelector:@selector(refreshDataPart) withObject:nil afterDelay:0];
	
	
}

-(void)FriendsLoadingCompleted:(NSMutableArray *)arrFriends
{
	refreshView.backgroundColor = [UIColor clearColor];
	[arrMyFriends removeAllObjects];
	[arrMyFriends addObjectsFromArray:[objFrndBL SelectAll]];
	[tblMyFriends reloadData];
    [self removeSyncLoader];
    tblMyFriends.scrollEnabled = YES;

}
 
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 73;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	for(UIView *vw in tableView.subviews)
	{
		if(vw.tag == 54)
		{
			[vw removeFromSuperview];
		}
	}
	if([arrMyFriends count])
	{
		tableView.scrollEnabled = YES;
		return [arrMyFriends count];
	}
	else {
		
		UILabel *lblNoEvents = [[UILabel alloc] initWithFrame:CGRectMake(110, 85, 120, 50)];
		lblNoEvents.backgroundColor = [UIColor clearColor];
		lblNoEvents.font = [UIFont boldSystemFontOfSize:19];
		lblNoEvents.textColor = [UIColor blackColor];
		lblNoEvents.text = @"No Friends";
		lblNoEvents.tag = 54;
		[tableView addSubview:lblNoEvents];
		tableView.scrollEnabled = NO;
		[lblNoEvents release];
		return 0;
	}
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([arrMyFriends count]) {
        tblMyFriends.scrollEnabled = YES;

        static NSString *FriendCell = @"FriendCell";
        
        FriendTableCell *cell = (FriendTableCell *)[tblMyFriends dequeueReusableCellWithIdentifier:FriendCell];
        if (cell == nil) {
            cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:FriendCell] autorelease];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		
		/*FriendsBO *selfriend = [arrMyFriends objectAtIndex:indexPath.row];
		FriendsBL *friendbl = [[FriendsBL alloc]init];
		friendbl.delegate = self;
		FriendsBO *friend =  (FriendsBO *)[friendbl SelectByKey:selfriend.FriendId withMode:YES];
		
        if (!friend.friendImage) {
			if (selfriend.friendImage) {
				[friendbl Update:selfriend withSave:YES];
 			}
 		}
		[friendbl release];*/
		

        [cell setTips:[arrMyFriends objectAtIndex:indexPath.row]];
         cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;

    } 
    else {
        
        tblMyFriends.scrollEnabled = NO;
         static NSString *FriendCell1 = @"FriendCell1";
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendCell1];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FriendCell1] autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         cell.textLabel.text=@"No Friends Added";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleCell.png"]];

        cell.textLabel.textColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
        return cell;
    }
}

- (void)tableView:(UITableView *)tblNewsPeople willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[(FriendTableCell *)cell showUserImage];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
	objFriendDet.objFriend = [arrMyFriends objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:objFriendDet animated:YES];
	[objFriendDet release];
}


#pragma mark -

#pragma mark UIButton methods

-(void)backBtnClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}

 
 
-(void) logoutBtn_Clicked:(id) sender
{
	[appDelegate1 removeTabBar];
    
 
	for(UIViewController *viewCont in appDelegate1.navigationController.viewControllers)
	{
		if([viewCont isKindOfClass:[HomeViewController class]])
		{
			[appDelegate1.navigationController popToViewController:viewCont animated:NO];
			break;
		}
	}
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

	[objFrndBL release];

	tblMyFriends.delegate = nil;
	tblMyFriends.dataSource = nil;
	[tblMyFriends release];
    tblMyFriends=nil;
	[arrMyFriends release];
     [super dealloc];
}


@end
