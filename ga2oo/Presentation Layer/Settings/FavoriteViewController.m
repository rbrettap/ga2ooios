//
//  FavoriteViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 07/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FavoriteViewController.h"
#import "Ga2ooAppDelegate.h"
#import "BusinessListBO.h"
#import "eventListViewController.h"
#import "HttpRequest.h"
#import "BusinessDetailViewController.h"


@implementation FavoriteViewController
@synthesize ArrAllBusiness;

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
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	searchBarFav = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
	searchBarFav.tintColor = [UIColor colorWithRed:8.0/255.0 green:97.0/255.0 blue:119.0/255.0 alpha:1.0];
	searchBarFav.delegate = self;
	searchBarFav.tag = 3;
	searchBarFav.showsBookmarkButton = YES;
	searchBarFav.showsCancelButton = YES;
	searchBarFav.placeholder = @"Search";
	[self.view addSubview:searchBarFav];
    
    for (UIView *possibleButton in searchBarFav.subviews)
	{
		if ([possibleButton isKindOfClass:[UIButton class]])
		{
			UIButton *cancelButton = (UIButton*)possibleButton;
			cancelButton.enabled = NO;
			break;
		}
	}
    
    UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
    
    BusinessListLayer = [[BusinessListBL alloc]init];
	BusinessListLayer.delegate = self;
    ArrAllBusiness = [[NSMutableArray alloc] init];
    [ArrAllBusiness addObjectsFromArray:[BusinessListLayer SelectAll]];
    
    
	[appDelegate.arrBusinessFav removeAllObjects];
	arrSearched = [[NSMutableArray alloc]init];
	
	tblFavorites.delegate =nil;
	tblFavorites.dataSource = nil;
    
    [self ShowLoading];

	[self loadBusinesFavourites];

	if([arrSearched count])
	{
		btnEdit.enabled = TRUE;
	}		
	else {
		btnEdit.enabled = FALSE;
	}
	searching = NO;
}

-(void)ShowLoading
{

    if([self.view viewWithTag:82])
	{
		[[self.view viewWithTag:82] removeFromSuperview];
	}
 	UIView *vw_Loader = [[UIView alloc] initWithFrame:CGRectMake(75,130+55, 170, 49)];
	vw_Loader.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
	vw_Loader.layer.cornerRadius = 6.0;
	vw_Loader.layer.borderColor = [[UIColor grayColor] CGColor];
	vw_Loader.layer.borderWidth = 2.0;
 	vw_Loader.tag = 82;
	
	//add indicator
	UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 6, 37, 37)];
	[indView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indView startAnimating];
    [vw_Loader addSubview:indView];
	[indView release];
	
	UILabel *lblSyncing = [[UILabel alloc] initWithFrame:CGRectMake(135-75,14, 90, 20)];
	lblSyncing.backgroundColor = [UIColor clearColor];
	lblSyncing.text = @"Loading...";
	lblSyncing.textAlignment =UITextAlignmentCenter;
	lblSyncing.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
	lblSyncing.font = [UIFont boldSystemFontOfSize:14.0];
	lblSyncing.textColor = [UIColor whiteColor];
	lblSyncing.alpha=1.0;
	[vw_Loader addSubview:lblSyncing];
	[lblSyncing release];
	
	[self.view addSubview:vw_Loader];
    [vw_Loader release];
 	
	self.view.userInteractionEnabled = NO;

}

-(void)loadBusinesFavourites
{
	objFavBusinessEvent = [UserFavBusinessEventsXML saxParser];
    objFavBusinessEvent.delegate = self;
    [objFavBusinessEvent getData];	
}

-(void)GUserFavBusinessEventsFinished:(NSMutableArray*)arrEvents
{
	[arrSearched removeAllObjects];
	[arrSearched addObjectsFromArray:arrEvents];
    if([arrSearched count])
	{
		btnEdit.enabled = TRUE;
	}		
	else {
		btnEdit.enabled = FALSE;
	}
    [self RemoveLoading];
	tblFavorites.delegate =self;
	tblFavorites.dataSource = self;

	[tblFavorites reloadData];
}

-(void)GUserBusinessEventXML_Error:(GUserEventXML*)parser encounteredError:(NSError *)error
{
	tblFavorites.delegate =self;
	tblFavorites.dataSource = self;
     [self RemoveLoading];
	NSLog(@"error is found");
}

-(void) RemoveLoading
{
	if([self.view viewWithTag:82])
	{
		[[self.view viewWithTag:82] removeFromSuperview];
	}
	self.view.userInteractionEnabled = YES;
    
}

-(void)BusinessListLoadingCompleted
{
	BusinessListBO *objBusiness = (BusinessListBO*)[businessLayer SelectByKey:appDelegate.currentUserID withMode:NO];
	[appDelegate.arrBusinessFav addObject:objBusiness];
}

#pragma mark IBAction Method

-(IBAction)BackBtnClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)editBtnClicked
{
	if([arrSearched count])
	{
		if([tblFavorites isEditing])
		{
			[btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"edit" ofType:@"png"]] forState:UIControlStateNormal];
			searchBarFav.userInteractionEnabled = TRUE;
			[tblFavorites setEditing:NO animated:YES];
		}
		else{
			
			[btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DoneBtn" ofType:@"png"]]
					 forState:UIControlStateNormal];
			searchBarFav.userInteractionEnabled = FALSE;
			[tblFavorites setEditing:YES animated:YES];
		}
	}
	else {
		[btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"edit" ofType:@"png"]] forState:UIControlStateNormal];
		searchBarFav.userInteractionEnabled = TRUE;
		[tblFavorites setEditing:NO animated:YES];
		btnEdit.enabled = FALSE;
	}

}

-(IBAction)searchBtnTouchUpInside
{
}

#pragma mark -

#pragma mark UISearchBar Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	btnEdit.enabled = FALSE;
	//[searchBarFav setShowsCancelButton:YES animated:YES];
	return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	
    searching = YES;
	if([arrSearched count])
		[arrSearched removeAllObjects];
	
	if(![searchBar.text isEqualToString:@""])
	{
		NSPredicate *pred = [NSPredicate predicateWithFormat: @"bizname contains[cd] %@", searchBar.text];
		NSArray *arr = [ArrAllBusiness filteredArrayUsingPredicate:pred];
		
		if([arr count])
			[arrSearched addObjectsFromArray:arr];
	}
	else 
    {
		[arrSearched addObjectsFromArray:ArrAllBusiness];
	}

	[tblFavorites reloadData];
	//[searchBarFav resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	searching = YES;
	    
   
	[searchBarFav resignFirstResponder];
}

-(void)removeView
{
	[searchBarFav resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	btnEdit.enabled = TRUE;
	searchBar.text = @"";
	searching = NO;
	[searchBarFav resignFirstResponder];
	if([arrSearched count])
	{
		[arrSearched removeAllObjects];
	}
	[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];
    if([arrSearched count])
	{
		btnEdit.enabled = TRUE;
	}		
	else {
		btnEdit.enabled = FALSE;
	}
    
    for (UIView *possibleButton in searchBarFav.subviews)
	{
		if ([possibleButton isKindOfClass:[UIButton class]])
		{
			UIButton *cancelButton = (UIButton*)possibleButton;
			cancelButton.enabled = NO;
			break;
		}
	}

    
	[tblFavorites reloadData];
}

#pragma mark -

#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 74.0;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if([arrSearched count])
		return [arrSearched count];
	else
		return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if(!searching)
    {
		
		if([arrSearched count])
		{
			static NSString *CellIdentifier1 = @"Cell"; 
			UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1]; 

			if (cell1 == nil) { 
				cell1 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease]; 
			}
			
			for(UIView *vw in cell1.contentView.subviews)
			{
				if(vw.tag == 999)
				{
					[vw removeFromSuperview];
				}
			}
			//cell1.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];
			BusinessFavEventBO *obj = [arrSearched objectAtIndex:indexPath.row];
			cell1.textLabel.text = obj.businessname;
			NSLog(@"the businessname is %@",obj.businessname);
			NSLog(@"the businessid is %@",obj.businessid);
			NSLog(@"the updated date is %@",obj.date_updated);
			NSLog(@"the user added business id %@\n",obj.useraddedbusinessid);
			cell1.textLabel.textAlignment = UITextAlignmentLeft;

			cell1.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendCellBg.png"]];

//			UIImageView *imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendCellBg.png"]];
//			imgBackground.frame = CGRectMake(-30, -1, 350, 44);
//			imgBackground.tag = 999;
//			[cell.contentView addSubview:imgBackground];
//            [cell.contentView sendSubviewToBack:imgBackground];
//			[imgBackground release];

			cell1.textLabel.font = [UIFont boldSystemFontOfSize:17];
			cell1.textLabel.backgroundColor = [UIColor clearColor];
			cell1.selectionStyle = UITableViewCellSelectionStyleGray;
			cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			return cell1;
		}
		else {
			
			static NSString *CellIdentifier2 = @"Cell2"; 
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2]; 
			if (cell == nil) { 
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease]; 
			}
			
			//cell.imageView.image = [UIImage imageNamed:@""];
			
			cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.textLabel.text = @"No organization";
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.accessoryType = UITableViewCellAccessoryNone;
			return cell;
		}
	}
	else 
    {
		if([arrSearched count])
		{
			static NSString *CellIdentifier3 = @"Cell"; 
			UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3]; 
			if (cell3 == nil) { 
				cell3 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease]; 
               

			}
			
			/*for(UIView *vw in cell.contentView.subviews)
			{
				if(vw.tag == 999)
					[vw removeFromSuperview];
				
			}*/
            
            cell3.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendCellBg.png"]];
            
			//cell3.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];
			cell3.textLabel.font = [UIFont boldSystemFontOfSize:17];
			cell3.textLabel.backgroundColor = [UIColor clearColor];
			BusinessListBO *obj = [arrSearched objectAtIndex:indexPath.row];
			cell3.textLabel.text = obj.bizname;
			cell3.textLabel.textAlignment = UITextAlignmentLeft;

						
			cell3.selectionStyle = UITableViewCellSelectionStyleGray;
			cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			return cell3;
		}
		else {
			
			static NSString *CellIdentifier = @"Cell"; 
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
			if (cell == nil) { 
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease]; 
			}
			tableView.separatorColor = [UIColor clearColor];
             //cell.imageView.image = [UIImage imageNamed:@""];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.textLabel.text = @"No organization";
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.accessoryType = UITableViewCellAccessoryNone;
			
			return cell;
		}
	}

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(!searching)
	{
        
        if([arrSearched count])
        {
        BusinessDetailViewController *objEvent1 = [[BusinessDetailViewController alloc] initWithNibName:@"BusinessDetailViewController" bundle:[NSBundle mainBundle]];
        objEvent1.SelectedBussinesId = [[arrSearched objectAtIndex:indexPath.row] businessid];
        [self.navigationController pushViewController:objEvent1 animated:YES];
        [objEvent1 release];
        }


        
        
   }
	
	else 
	{
        if([arrSearched count])
        {
		BusinessDetailViewController *objEvent1 = [[BusinessDetailViewController alloc] initWithNibName:@"BusinessDetailViewController" bundle:[NSBundle mainBundle]];
        objEvent1.SelectedBussinesId = [[arrSearched objectAtIndex:indexPath.row] bussinessId];
        [self.navigationController pushViewController:objEvent1 animated:YES];
        [objEvent1 release];
        }
	}
		
}

-(void)getBusinessIdOfSelectedBusinessEvent:(NSInteger)selectedEvtRow
{
	BusinessFavEventBO *objEvent = [arrSearched objectAtIndex:selectedEvtRow];
	eventListViewController *objEvent1 = [[eventListViewController alloc] initWithNibName:@"eventListViewController" bundle:[NSBundle mainBundle]];
	[objEvent1.arrEvents removeAllObjects];
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for(int i = 0; i < [appDelegate.arr_AllEvents count]; i++)
	{
		EventsBO *obj = [appDelegate.arr_AllEvents objectAtIndex:i];
		if(obj.intOrganisationID == [objEvent.businessid integerValue])
		{
			[arr addObject:obj];
		}
	}
	objEvent1.arrEvents  = arr;
	[self.navigationController pushViewController:objEvent1 animated:YES];
	[arr release];
	[objEvent1 release];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if(!searching)
    {
      return YES;
    }
    else 
    {
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellEditingStyle editingStyle = UITableViewCellEditingStyleDelete;
	if((![arrSearched count]))
		editingStyle = UITableViewCellEditingStyleNone;
	return editingStyle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        if([searchBarFav.text length]==0)
		{
			BusinessFavEventBO *obj = [arrSearched objectAtIndex:indexPath.row];
            Selectedobj = [arrSearched objectAtIndex:indexPath.row];
			if(appDelegate.isNetAvail)
			{
				HttpRequest *request = [[HttpRequest alloc] init];
                
				[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]] Delegate:self Tag:10];
                NSLog(@"id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]);
				[request release];					
			}
            
            //			[appDelegate.arrBusinessFav removeObjectAtIndex:(alertView.tag-13000)];
            //			[arrSearched removeAllObjects];
            //			[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];
		}
		else {
			BusinessFavEventBO *obj = [arrSearched objectAtIndex:indexPath.row];
			if(appDelegate.isNetAvail)
			{
				HttpRequest *request = [[HttpRequest alloc] init];
                Selectedobj = [arrSearched objectAtIndex:indexPath.row];
				[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]] Delegate:self Tag:10];
                NSLog(@"id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]);
                [request release];					
			}
            
            //			[appDelegate.arrBusinessFav removeObjectAtIndex:(alertView.tag-13000)];
            //			[arrSearched removeAllObjects];
            //			[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];			
		}
        
        
		//[self deleteFavMassage:indexPath.row];
//		[appDelegate.arrBusinessFav removeObjectAtIndex:(indexPath.row)];
//		[arrSearched removeAllObjects];
//		[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];
//		
//		if(![arrSearched count])
//		{
//			[btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"edit" ofType:@"png"]] forState:UIControlStateNormal];
//			searchBarFav.userInteractionEnabled = TRUE;
//			[tblFavorites setEditing:NO animated:YES];
//			btnEdit.enabled = FALSE;
//		}			
//		[tblFavorites reloadData];
	}
}

#pragma mark -

-(void)deleteFavMassage:(NSInteger)row{

	UIAlertView *alertBeforeDelete = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete record?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
	alertBeforeDelete.tag = 13000+row;
	[alertBeforeDelete show];
	[alertBeforeDelete release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		if([searchBarFav.text length]==0)
		{
			BusinessFavEventBO *obj = [arrSearched objectAtIndex:alertView.tag-13000];
            Selectedobj = [arrSearched objectAtIndex:alertView.tag-13000];
			if(appDelegate.isNetAvail)
			{
				HttpRequest *request = [[HttpRequest alloc] init];
                
				[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]] Delegate:self Tag:10];
                NSLog(@"id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]);
				[request release];					
			}
				 
//			[appDelegate.arrBusinessFav removeObjectAtIndex:(alertView.tag-13000)];
//			[arrSearched removeAllObjects];
//			[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];
		}
		else {
			BusinessFavEventBO *obj = [arrSearched objectAtIndex:alertView.tag-13000];
			if(appDelegate.isNetAvail)
			{
				HttpRequest *request = [[HttpRequest alloc] init];
                Selectedobj = [arrSearched objectAtIndex:alertView.tag-13000];
				[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]] Delegate:self Tag:10];
                NSLog(@"id/%i/deleteids/%i",[appDelegate.currentUserID intValue],[obj.useraddedbusinessid integerValue]);
				 [request release];					
			}
				 			
//			[appDelegate.arrBusinessFav removeObjectAtIndex:(alertView.tag-13000)];
//			[arrSearched removeAllObjects];
//			[arrSearched addObjectsFromArray:appDelegate.arrBusinessFav];			
		}

		
		
		
		
		
		
	}
}
-(void)httpResponseReceived:(WebResponse *)response
{
	
	
	//NSString *strMsg = nil;
	
    if (response.tag == 10)
	{
		if (!response.isError)
		{
			NSString *responseString = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
            NSLog(@"responseStringdelet  %@",responseString);
			responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding='utf-8'?><useraccount><results><result>" withString:@""];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"</result><results></useraccount>" withString:@""];
			
			
			
			if(![responseString isEqualToString:@"0"] && ![responseString isEqualToString:@"1"] && ![responseString isEqualToString:@"-2"] &&  [responseString length])
			{
				//strMsg = @"Selected business is successfully removed from favorite business.";
                NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"useraddedbusinessid == %@",Selectedobj.useraddedbusinessid];
                NSArray *arr1 = [arrSearched filteredArrayUsingPredicate:pred1];
                
                
                
                [UserFavBussLayer DeletefavBusinessByKey:[Selectedobj.businessid integerValue]];
                if ([arr1 count]) 
                {
                    [arrSearched removeObject:Selectedobj];
                    
                }
                
                NSArray *arr2 = [appDelegate.arrBusinessFav filteredArrayUsingPredicate:pred1];
                
                if ([arr2 count]) 
                {
                    [appDelegate.arrBusinessFav removeObject:Selectedobj];
                    
                }
                
			}
			else if([responseString isEqualToString:@"0"])
			{
				//strMsg = @"Selected business is already removed from favorite business.";
			}
			else if([responseString isEqualToString:@"1"] || [responseString isEqualToString:@"-2"])
			{
				//strMsg = @"Error while removing selected business from favorite business.";
			}
		}
		else 
		{
			//strMsg = @"Error while removing selected business from favorite business.";
		}
        
       // strMsg = nil;
        if(![arrSearched count])
		{
			[btnEdit setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"edit" ofType:@"png"]] forState:UIControlStateNormal];
			searchBarFav.userInteractionEnabled = TRUE;
			[tblFavorites setEditing:NO animated:YES];
			btnEdit.enabled = FALSE;
		}		
		
		[tblFavorites reloadData];
        
		/*UIAlertView *alertAfterDelete = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertAfterDelete show];
		[alertAfterDelete release];*/
    }
    
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
	
    UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
    
	objFavBusinessEvent = nil;
	tblFavorites.delegate = nil;
	tblFavorites.dataSource = nil;
	[tblFavorites release];
	[arrSearched release];
	[searchBarFav release];
    [super dealloc];
	
}


@end
