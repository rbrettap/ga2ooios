//
//  SettingNewViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "SettingNewViewController.h"
#import "SettingCellViewController.h"
#import "FriendsViewController.h"
#import "settingProfileViewController.h"
#import "FavoriteViewController.h"
#import "MyCircleViewController.h"
#import "SettingWebViewController.h"
#import "ContactViewController.h"

@implementation SettingNewViewController

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
	arrSetting = [[NSMutableArray alloc] initWithObjects:@"Profile", @"My Circle",@"Favorites", @"Account", nil];
	arrGeneral = [[NSMutableArray alloc] initWithObjects:@"About", @"F.A.Q", @"Contact",nil];
	
	tblSetting.backgroundColor = [UIColor clearColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Settings";
	else
		return @"General";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return [arrSetting count];
	else
		return [arrGeneral count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}

	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	// Set up the cell...
	if(indexPath.section == 0)
		cell.textLabel.text = [arrSetting objectAtIndex:indexPath.row];
	else
		cell.textLabel.text = [arrGeneral objectAtIndex:indexPath.row];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(indexPath.section == 0){
		
		if(indexPath.row==0)
		{
			settingProfileViewController *objprof = [[settingProfileViewController alloc] initWithNibName:@"settingProfileViewController" bundle:[NSBundle mainBundle]];
			[self.navigationController pushViewController:objprof animated:YES];
			[objprof release];
		}
        else if(indexPath.row == 1)
		{
			MyCircleViewController *objFav = [[MyCircleViewController alloc] initWithNibName:@"MyCircleViewController" bundle:[NSBundle mainBundle]]; 
			[self.navigationController pushViewController:objFav animated:YES];
			[objFav release];
		}
		else if(indexPath.row == 2)
		{
			FavoriteViewController *objFav = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:[NSBundle mainBundle]]; 
			[self.navigationController pushViewController:objFav animated:YES];
			[objFav release];
		}
		else if(indexPath.row == 3)
		{
			SettingCellViewController *objSet = [[SettingCellViewController alloc] initWithNibName:@"SettingCellViewController" bundle:[NSBundle mainBundle]];
			[self.navigationController pushViewController:objSet animated:YES];
			[objSet release];
		}
	}
	else if(indexPath.section==1){
		if(indexPath.row==0)
		{
			SettingWebViewController *swView = [[SettingWebViewController alloc] initWithNibName:@"SettingWebViewController" bundle:[NSBundle mainBundle]];
			swView.selected=1;
			[self.navigationController pushViewController:swView animated:YES];
			[swView release];
		}
		if(indexPath.row==1)
		{
			SettingWebViewController *swView = [[SettingWebViewController alloc] initWithNibName:@"SettingWebViewController" bundle:[NSBundle mainBundle]];
			swView.selected=2;
			[self.navigationController pushViewController:swView animated:YES];
			[swView release];
		}
		if(indexPath.row==2)
		{
			ContactViewController *cvController = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:[NSBundle mainBundle]];
			[self.navigationController pushViewController:cvController animated:YES];
			[cvController release];
		}
		
	}
		
}



-(IBAction) logoutBtn_Clicked
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
	
	[arrGeneral release];
	[arrSetting release];
	tblSetting.delegate = nil;
	tblSetting.dataSource = nil;
	[tblSetting release];
    [super dealloc];
}


@end
