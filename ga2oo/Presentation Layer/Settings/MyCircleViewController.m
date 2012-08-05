//
//  MyCircleViewController.m
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCircleViewController.h"
#import "FriendTableCell.h"
#import "Ga2ooUsersBL.h"
#import "Ga2ooUserBO.h"
#import "ServiceOutput.h"
#import "FriendDetailViewController.h"

int ROWID = 0;
@implementation MyCircleViewController
@synthesize FriendSearchBar;
@synthesize tblMyCircle;
@synthesize arrGa2ooUsers;
@synthesize arrGa2ooFriends;
@synthesize arrSearchedGa2ooUsers;
@synthesize isSelected;
@synthesize btnEdit;

-(IBAction)back_Touch_Up_Inside:(id)sender{
	
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) logoutBtn_Clicked:(id) sender
{
	[appDelegate removeTabBar];
    
	for(UIViewController *viewCont in appDelegate.navigationController.viewControllers)
	{
		if([viewCont isKindOfClass:[HomeViewController class]])
		{
			[appDelegate.navigationController popToViewController:viewCont animated:NO];
			break;
		}
	}
}

-(void)EditingTable:(id)sender
{
	if(!isSelected)
	{
        [btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DoneBtn" ofType:@"png"]]
                 forState:UIControlStateNormal];
		FriendSearchBar.userInteractionEnabled = FALSE;
		[super setEditing:YES animated:YES]; 
		[tblMyCircle setEditing:YES animated:YES];
		isSelected = YES;
	}
	else 
    {
        [btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"edit" ofType:@"png"]] forState:UIControlStateNormal];
		
		FriendSearchBar.userInteractionEnabled = TRUE;
		isSelected = NO;
		[super setEditing:NO animated:YES]; 
		[tblMyCircle setEditing:NO animated:YES];
	}
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    FriendSearchBar.frame = CGRectMake(0, 44, 320, 50);
	[self.view addSubview:FriendSearchBar];
	[self.view bringSubviewToFront:FriendSearchBar];
    FriendSearchBar.showsCancelButton = YES;
	
	for (UIView *possibleButton in FriendSearchBar.subviews)
	{
		if ([possibleButton isKindOfClass:[UIButton class]])
		{
			UIButton *cancelButton = (UIButton*)possibleButton;
			cancelButton.enabled = NO;
			break;
		}
	}

	
    arrGa2ooUsers = [[NSMutableArray alloc]init];
    arrGa2ooFriends = [[NSMutableArray alloc]init];
    arrSearchedGa2ooUsers= [[NSMutableArray alloc]init];
    
    [arrGa2ooFriends removeAllObjects];
    objFrndBL = [[FriendsBL alloc]init];
    [arrGa2ooFriends addObjectsFromArray:[objFrndBL SelectAll]];
    
    if([arrGa2ooFriends count])
    {
      btnEdit.enabled = TRUE;
    }
    else 
    {
      btnEdit.enabled = FALSE;
    }

	NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
  	[arrGa2ooFriends sortUsingDescriptors:[NSArray arrayWithObjects:nameSortDescriptor,nil]];
    [nameSortDescriptor release];
    
    
    
     Ga2ooUsersBL *objBL = [[Ga2ooUsersBL alloc]init];
     [arrGa2ooUsers addObjectsFromArray:[objBL SelectAll]];
	 [objBL release];
    
	
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ga2ooUserId == %@",appDelegate.currentUserID];
    NSArray *arr = [arrGa2ooUsers filteredArrayUsingPredicate:pred];
    if ([arr count]) {
        [arrGa2ooUsers removeObject:[arr objectAtIndex:0]];
        
    }
	
	for(int k = 0 ; [arrGa2ooFriends count] > k; k++)
	{
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"ga2ooUserId == %@",[[arrGa2ooFriends objectAtIndex:k] FriendId]];
		NSArray *arr = [arrGa2ooUsers filteredArrayUsingPredicate:pred];
		if ([arr count]) {
			[arrGa2ooUsers removeObject:[arr objectAtIndex:0]];
			
		}
	}
	
   

    
    
    
    tblMyCircle = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 320, 460-94-44) style:UITableViewStylePlain];
    tblMyCircle.delegate = self;
    tblMyCircle.dataSource = self;
    tblMyCircle.backgroundColor = [UIColor clearColor];
	tblMyCircle.separatorColor = [UIColor clearColor];
    tblMyCircle.tag = 100;
    [self.view addSubview:tblMyCircle];

     

}
-(void)viewWillAppear:(BOOL)animated{


}
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 74;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    
    if (tableView.tag == 100) 
    {
        for(UIView *vw in tableView.subviews)
        {
            if(vw.tag == 54)
            {
                [vw removeFromSuperview];
            }
        }
        if([arrGa2ooFriends count])
        {
            tableView.scrollEnabled = YES;
            return [arrGa2ooFriends count];
        }
        else {
            
            UILabel *lblNoEvents = [[UILabel alloc] initWithFrame:CGRectMake(110, 85, 120, 50)];
            lblNoEvents.backgroundColor = [UIColor clearColor];
            lblNoEvents.font = [UIFont boldSystemFontOfSize:19];
            lblNoEvents.textColor = [UIColor blackColor];
            lblNoEvents.text = @"No Results";
            lblNoEvents.tag = 54;
            [tableView addSubview:lblNoEvents];
            tableView.scrollEnabled = NO;
            [lblNoEvents release];
            return 0;
        }
        
    }
    else{
        
        for(UIView *vw in tableView.subviews)
        {
            if(vw.tag == 54)
            {
                [vw removeFromSuperview];
            }
        }
        if([arrSearchedGa2ooUsers count])
        {
            tableView.scrollEnabled = YES;
            return [arrSearchedGa2ooUsers count];
        }
        else{
            return 1;
        
        }
    
    }
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {

	static NSString *MyCircleCell1 = @"MyCircleCell1";
	
	FriendTableCell *cell = (FriendTableCell *)[tblMyCircle dequeueReusableCellWithIdentifier:MyCircleCell1];
	if (cell == nil) {
		cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyCircleCell1] autorelease];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 	[cell setTips:[arrGa2ooFriends objectAtIndex:indexPath.row]];
 
	cell.backgroundColor = [UIColor clearColor];
 	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
        
    }
    else{
    
        if ([arrSearchedGa2ooUsers count]) {
            static NSString *MyCircleCell2 = @"MyCircleCell2";
            
            FriendTableCell *cell = (FriendTableCell *)[tblMyCircle dequeueReusableCellWithIdentifier:MyCircleCell2];
            if (cell == nil) {
                cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyCircleCell2] autorelease];
            }
            
             [cell setGa2ooUserForSearch:[arrSearchedGa2ooUsers objectAtIndex:indexPath.row]];
            cell.btnAdd.tag = indexPath.row;
            [cell.btnAdd addTarget:self action:@selector(addTheSelectedUserAsAfriend:) forControlEvents:UIControlEventTouchUpInside];
            //cell.lblTitle.frame = CGRectMake (85,0,175,74);
            //cell.btnAdd.frame = CGRectMake(260, 20, 35, 35);
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;

        } else {
            static NSString *MyCircleCell3 = @"MyCircleCell3";
             
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCircleCell3];
            if (cell == nil) 
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCircleCell3] autorelease];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
             cell.textLabel.text=@"No result found";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
             
            cell.textLabel.textColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
            return cell;
        }
    
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (tableView.tag == 100) {
        [(FriendTableCell *)cell showUserImage];

    }
    
}

 

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {

	if([arrGa2ooFriends count])
	{
		return UITableViewCellEditingStyleDelete;
	}
	else {
		return UITableViewCellEditingStyleNone;
	}
    }
    else {
		return UITableViewCellEditingStyleNone;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
		
		if([arrGa2ooFriends count])
		{
			ROWID = indexPath.row;
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure, you want to delete this friend?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
			alert.tag = 1234;
			[alert show];
			[alert release];
		}
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
        objFriendDet.objFriend = [arrGa2ooFriends objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:objFriendDet animated:YES];
        [objFriendDet release];
    }
   /* else 
    {
        FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
         Ga2ooUserBO *obj = [arrSearchedGa2ooUsers objectAtIndex:indexPath.row];
        FriendsBO *objFriendTemp = [[FriendsBO alloc]init];
        objFriendTemp.firstName = obj.ga2ooUserFirstName;
        objFriendTemp.UserId = obj.ga2ooUserId;
        objFriendTemp.lastName = obj.ga2ooUserLastName;
        objFriendTemp.email = obj.ga2ooUserEmail;
        objFriendTemp.lastName = obj.ga2ooUserLastName;
        objFriendDet.objFriend = objFriendTemp;
        objFriendDet.ForAllUser = 1;
        [self.navigationController pushViewController:objFriendDet animated:YES];
        [objFriendDet release];
    }*/
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

#pragma mark Search Bar delegates


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
{
	[arrSearchedGa2ooUsers removeAllObjects];

    if ([searchText length]) {
        
        
        for (int i=0; i<[arrGa2ooUsers count]; i++) {
            Ga2ooUserBO *obj = [arrGa2ooUsers objectAtIndex:i];
            BOOL isEntered = NO;
             NSRange  rangeFName = [obj.ga2ooUserFirstName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (rangeFName.length > 0) {
                [arrSearchedGa2ooUsers addObject:obj] ;
                isEntered = YES;
            }
            
            if (!isEntered) {
                NSRange  rangeLName = [obj.ga2ooUserEmail rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (rangeLName.length > 0) {
                    [arrSearchedGa2ooUsers addObject:obj] ;
                 }

            }
        }
 
        tblMyCircle.tag = 200;
        [tblMyCircle reloadData];
		[tblMyCircle scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else 
	{		
		[FriendSearchBar resignFirstResponder];
		tblMyCircle.tag = 100;
		[tblMyCircle reloadData];
		
		for (UIView *possibleButton in FriendSearchBar.subviews)
		{
			if ([possibleButton isKindOfClass:[UIButton class]])
			{
				UIButton *cancelButton = (UIButton*)possibleButton;
				cancelButton.enabled = NO;
				break;
			}
		}
	}
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
{ 
	if([arrGa2ooFriends count])
    {
        btnEdit.enabled = TRUE;
    }
    else 
    {
        btnEdit.enabled = FALSE;
    }
  	[aSearchBar resignFirstResponder];
    aSearchBar.text = @"";
    tblMyCircle.tag = 100;
    [tblMyCircle reloadData];
	
	for (UIView *possibleButton in FriendSearchBar.subviews)
	{
		if ([possibleButton isKindOfClass:[UIButton class]])
		{
			UIButton *cancelButton = (UIButton*)possibleButton;
			cancelButton.enabled = NO;
			break;
		}
	}
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	btnEdit.enabled = FALSE;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	
	NSString *strSearchText = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
	NSLog(@"%@",searchBar.text);
	if ([strSearchText length]) {
		 
        tblMyCircle.tag = 200;
	
    }
	else {
        
        tblMyCircle.tag = 100;
        [tblMyCircle reloadData];
        
 	}
    [searchBar resignFirstResponder];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1234) {
        if (buttonIndex==1) {
            [self yesDeleteTheFriend];
        }
    }
    else if (alertView.tag == 4321) {
        if (buttonIndex==1) {
            [self yesAddTheFriend];
        }
    }
    

}
- (void)yesDeleteTheFriend{

    FriendsBO *deleteFr = [arrGa2ooFriends objectAtIndex:ROWID];
     objFrndBL.delegate = self;
     [objFrndBL deleteTheFriendFromServer:deleteFr];

}
- (void)ServiceRequestCompleted:(ServiceOutput *)response{
    
    FriendsBO *deleteFr = [arrGa2ooFriends objectAtIndex:ROWID];

    
    if ([deleteFr.addedFriendId isEqualToString:response.responseStringfromWeb]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"This friend has be successfully deleted." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         [alert show];
        [alert release];
        [objFrndBL deleteObject:deleteFr];
        [arrGa2ooFriends removeObjectAtIndex:ROWID];
        [tblMyCircle reloadData];
		
		[arrGa2ooUsers removeAllObjects];
		Ga2ooUsersBL *objBL = [[Ga2ooUsersBL alloc]init];
		[arrGa2ooUsers addObjectsFromArray:[objBL SelectAll]];
		[objBL release];
		
		
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"ga2ooUserId == %@",appDelegate.currentUserID];
		NSArray *arr = [arrGa2ooUsers filteredArrayUsingPredicate:pred];
		if ([arr count]) {
			[arrGa2ooUsers removeObject:[arr objectAtIndex:0]];
			
		}
		
		for(int k = 0 ; [arrGa2ooFriends count] > k; k++)
		{
			NSPredicate *pred = [NSPredicate predicateWithFormat:@"ga2ooUserId == %@",[[arrGa2ooFriends objectAtIndex:k] FriendId]];
			NSArray *arr = [arrGa2ooUsers filteredArrayUsingPredicate:pred];
			if ([arr count]) {
				[arrGa2ooUsers removeObject:[arr objectAtIndex:0]];
				
			}
		}
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Error occurred while deleting the friend." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    
    }

}
- (void)addTheSelectedUserAsAfriend:(UIButton *)btn{

    ROWID  = btn.tag;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure, you want to add this user as your friend?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag = 4321;
    [alert show];
    [alert release]; 
    
    

 }
- (void)yesAddTheFriend{
    
    Ga2ooUserBO *deleteFr = [arrSearchedGa2ooUsers objectAtIndex:ROWID];
    objFrndBL.delegate = self;
    [objFrndBL addTheUserAsFriendFromServer:deleteFr];
    
}
- (void)ServiceRequestCompletedToAddFriend:(ServiceOutput *)response{
    
	
	 NSRange rangeIs = [response.responseStringfromWeb rangeOfString:@"already exists" options:NSCaseInsensitiveSearch];
	
	NSRange rangeIs2 = [response.responseStringfromWeb rangeOfString:@"was created with" options:NSCaseInsensitiveSearch];
	
	if(rangeIs.length > 12)
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Friend request has already been sent." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[alert show];
        [alert release]; 
	}
     else  if (rangeIs2.length > 12) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Friend request has been successfully sent." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         [alert show];
        [alert release]; 

    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Error." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release]; 

    
    }
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
     [objFrndBL release];

    [FriendSearchBar release];
    tblMyCircle.delegate = nil;
    tblMyCircle.dataSource = nil;
    [tblMyCircle release];
    tblMyCircle=nil;
    
    [super dealloc];
}
@end
