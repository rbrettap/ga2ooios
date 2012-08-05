//
//  ProfileViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterObject.h"
#import "LoginMapViewController.h"
#import "NotifyTabeCell.h"
#import "EventListBO.h"
#import "EventDetailViewController.h"
#import "UserBL.h"
#import "HttpRequest.h"
#import "GlobalConstant.h"
#import "UserFavEvents.h"

@implementation ProfileViewController
@synthesize arrUserLocation;
@synthesize imgUser;
@synthesize strlocation;

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
	
	
	[self setTopBarImageToViewWithHome:self.view];
 	self.arrUserLocation = [[NSMutableArray alloc] init];
	UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
	btnBack.frame = CGRectMake(5, 7, 51, 30);
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back_btnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnBack];
	
	UserLayer = [[UserBL alloc]init];
	UserLayer.delegate = self;
	objUser = (UserBO*) [UserLayer SelectByKey:appDelegate.currentUserID withMode:YES];

	UserLocationBL *UserLocationLayer = [[UserLocationBL alloc]init];
	UserLocationLayer.delegate = self;
	self.arrUserLocation = [UserLocationLayer SelectAll];
    [UserLocationLayer release];
    
    [appDelegate.arrFavorite removeAllObjects];
    for(int i = 0 ; [appDelegate.arr_FavoritesID count]>i ; i++)
    {
        NSString *FavId = [[appDelegate.arr_FavoritesID objectAtIndex:i] strEventId];
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"Eventid == %@",FavId];
        NSArray *arr1 = [appDelegate.arr_AllEvents filteredArrayUsingPredicate:pred1];
        
        if ([arr1 count]) {
            [appDelegate.arrFavorite addObjectsFromArray:arr1];
            
        }
    }
    
    [appDelegate.arr_AddedEvents removeAllObjects];
    for(int i = 0 ; [appDelegate.arr_AllEvents count]> i ; i++)
    {
        NSLog(@"under");
       EventListBO *objEvent1 = [appDelegate.arr_AllEvents objectAtIndex:i];
        NSLog(@"objEvent1.favEventUserId %@",objEvent1.UserID);
        NSArray *AttendingUser = [objEvent1.UserID componentsSeparatedByString:@","];
        for(int k = 0 ; k< [AttendingUser count]-1 ; k++)
        {
            NSString *UserId = [AttendingUser objectAtIndex:k];
            if([UserId isEqualToString:appDelegate.currentUserID])
            {
                NSLog(@"coming");
                [appDelegate.arr_AddedEvents addObject:objEvent1];
                break;
            }
        }
    }
    
    
    
    

	
	[self createInterFace];
}

-(void)viewWillAppear:(BOOL)animated
{
}

-(void)createInterFace
{
	
	imgViewProfile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 93, 93)];
    imgViewProfile.backgroundColor = [UIColor whiteColor];
	loader=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	loader.center =CGPointMake(imgViewProfile.center.x, imgViewProfile.center.y);
	[self.view addSubview:loader];
	[loader startAnimating];
	
	if(imgUser)
	{
		imgViewProfile.image = imgUser;
		[loader stopAnimating];
	}
	else 
    {
		//[self downloadImage:objUser.UserImage Tag:12];
		
		[NSThread detachNewThreadSelector:@selector(displayUserImage:) toTarget:self withObject:objUser.UserImage];
	}

	
	imgViewProfile.layer.borderWidth = 3.0;
	imgViewProfile.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
	[imgViewProfile.layer setMasksToBounds:YES];	
	[imgViewProfile.layer setCornerRadius:5.0];
	[self.view addSubview:imgViewProfile];
	

	
	CGSize maximumSize = CGSizeMake(180, 9999);
	int intyRefrence = 49;
	NSString *str = [NSString stringWithFormat:@"%@ %@", objUser.Firstname, objUser.Lastname];
	UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(120, 49, 170, 65)];
	UIFont *TitleFont = [UIFont systemFontOfSize:28];
	CGSize TitleFrameStringSize = [str sizeWithFont:TitleFont 
								  constrainedToSize:maximumSize 
									  lineBreakMode:UILineBreakModeWordWrap];
	intyRefrence = intyRefrence+TitleFrameStringSize.height;
	lblName.frame = CGRectMake(120, 49, 170, TitleFrameStringSize.height);
	lblName.font = [UIFont systemFontOfSize:20];
	lblName.numberOfLines = 0;
	lblName.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	lblName.text = str;
	lblName.backgroundColor = [UIColor clearColor];
	[self.view addSubview:lblName];
	[lblName release];
	intReferecnce = intyRefrence;
	
	lblCountry = [[UILabel alloc] init];
	UIFont *lblCountryFont = [UIFont systemFontOfSize:15];
//	NSString *strAddress = @"";
/*	if([self.arrUserLocation count])
	{
		objUserLoc = [self.arrUserLocation objectAtIndex:0];
		strAddress = [NSString stringWithFormat:@"%@, %@", objUserLoc.City, objUserLoc.Zipcode];	
		lblCountry.text = strAddress;
	}
	*/
	CGSize CountryStringSize = [strlocation sizeWithFont:lblCountryFont 
														   constrainedToSize:maximumSize 
															   lineBreakMode:UILineBreakModeWordWrap];
	
	lblCountry.frame = CGRectMake(120, intyRefrence, 170, CountryStringSize.height);
	lblCountry.font = [UIFont systemFontOfSize:15];
	lblCountry.numberOfLines = 0;
	lblCountry.text = strlocation;
	lblCountry.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	lblCountry.backgroundColor = [UIColor clearColor];
	[self.view addSubview:lblCountry];
	/*
	btnAddLocation = [UIButton buttonWithType:UIButtonTypeCustom];
	btnAddLocation.frame = CGRectMake(120, intyRefrence, 86, 26);
	[btnAddLocation setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"addLoction" ofType:@"png"]] forState:UIControlStateNormal];
	[btnAddLocation addTarget:self action:@selector(btnAddLocationTouchupInside:) forControlEvents:UIControlEventTouchUpInside];
	//[self.view addSubview:btnAddLocation];
	*/
	
	intReferecnce += CountryStringSize.height;
	
	if(intReferecnce <= 160)
	{
		intReferecnce = 160;
	}
	
	tblAttend = [[UITableView alloc] initWithFrame:CGRectMake(0, intReferecnce, 320, 410 - intReferecnce)];
	tblAttend.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tblAttend];
	tblAttend.tag = 1;
	tblAttend.separatorStyle = UITableViewCellSeparatorStyleNone;
	tblAttend.delegate = self;
	tblAttend.dataSource = self;
	
}


#pragma mark AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 222 && buttonIndex == 1) {
		
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
}	

#pragma mark -

#pragma mark actionSheet delegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//[modalView dismissWithClickedButtonIndex:0 animated:YES];
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
			case 1:
			{
				NSLog(@"cancel clicked");
			 	break; 
			}
		}
	}
}

#pragma mark -

#pragma mark imagePickerController delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo	
{
	
	if(myimage)
	{
		imgViewProfile.image = nil;
		imgViewProfile.image = myimage;//[self getScaledImageFrom:myimage toSize:CGRectMake(0, 0, 320, 460)];
		//RegisterObject *obj = [appDelegate.arrRegister objectAtIndex:0];
		//obj.imgImage = myimage;
	}
	
	
  	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark -

#pragma mark imagePickerController Functions

-(void)choosePhoto{
	
	UIImagePickerController	*piccontroller = [[UIImagePickerController alloc] init];
	piccontroller.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
	piccontroller.allowsEditing = NO;
	piccontroller.delegate = self;
	[self presentModalViewController:piccontroller animated:YES];
	[piccontroller release];
	
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

#pragma mark -

#pragma mark UIButton Methods

-(void) btnAddLocationTouchupInside:(id) sender
{
	LoginMapViewController *objLogin = [[LoginMapViewController alloc] initWithNibName:@"LoginMapViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:objLogin animated:YES];
	[objLogin release];
}

-(void) btnChangeImageTouchupInside:(id) sender
{
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

#pragma mark -

#pragma mark uitableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

	return 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

	UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 27)];
	[v setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1.0]];

	UILabel *lblHeader;

	lblHeader= [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 300, 20)];
	lblHeader.font = [UIFont systemFontOfSize:17];
	lblHeader.numberOfLines = 0;
	lblHeader.textColor = [UIColor colorWithRed:110.0/255.0 green:149.0/255.0 blue:165.0/255.0 alpha:1.0];
	lblHeader.backgroundColor = [UIColor clearColor];
	[v addSubview:lblHeader];
	[lblHeader release];
	
	if(section == 0){
		lblHeader.text = @"Attending Events";
	}
	else if(section == 1){
		lblHeader.text = @"Favorite Events";
	}
	
	UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 300, 2)];
	imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
	imgSep.backgroundColor = [UIColor clearColor];
	[v addSubview:imgSep];
	[imgSep release];
	
	return [v autorelease];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(section == 0)
	{
		if([appDelegate.arr_AddedEvents count])
			return [appDelegate.arr_AddedEvents count];
		else 
			return 1;
	}
	else if(section == 1) {
		
		if([appDelegate.arrFavorite count])
			return [appDelegate.arrFavorite count];
		else 
			return 1;
	}
	else {
		return 1;
	}

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(indexPath.section == 0)	
	{
		if([appDelegate.arr_AddedEvents count])
		{
			static NSString *CellIdentifier = @"Cell1";
			
			NotifyTabeCell *cell = (NotifyTabeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

			if (cell == nil) 
			{
				cell = [[[NotifyTabeCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			}
			
			EventListBO *obj = [appDelegate.arr_AddedEvents objectAtIndex:indexPath.row];
			cell.lblTitle.text = obj.name;
			cell.lblSubTitle.text= [NSString stringWithFormat:@"%@    %@",obj.event_start_date,obj.price]; 
			[cell setArticle:obj];
            cell.imgSep.frame = CGRectMake(13, 58, 293, 2);
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleGray;			
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			if([appDelegate.arr_AddedEvents count]==1)
			{
				cell.imgSep.image = [UIImage imageNamed:nil];
			}
			//[cell showEventsImage];

			return cell;
		}
		else
		{
			static NSString *CellIdentifier = @"Cell";
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) 
			{
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			}
			
			cell.textLabel.text = @"No Event Added";
			[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
	}
	else{
		
		if([appDelegate.arrFavorite count])
		{
			static NSString *CellIdentifier = @"Cell2";
			
			NotifyTabeCell *cell = (NotifyTabeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) 
			{
				cell = [[[NotifyTabeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
			}
			
			EventListBO *obj = [appDelegate.arrFavorite objectAtIndex:indexPath.row];
			
			cell.lblTitle.text = obj.name;
			cell.lblSubTitle.text= [NSString stringWithFormat:@"%@    %@",obj.event_start_date,obj.price]; 
			[cell setArticle:obj];
            cell.imgSep.frame = CGRectMake(13, 58, 293, 2);
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleGray;			
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			//[cell showEventsImage];

			return cell;
		}
		else
		{
			static NSString *CellIdentifier = @"Cell";
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) 
			{
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			}
			
			cell.textLabel.text = @"No Event Added";
			[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
	}
}

- (void)tableView:(UITableView *)tblNewsPeople willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)	
	{
		if([appDelegate.arr_AddedEvents count])
		{
            [(NotifyTabeCell *)cell showEventsImage];
        }
    }
    else if([appDelegate.arrFavorite count])
    {
      [(NotifyTabeCell *)cell showEventsImage];
    }
    
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//if(tableView.tag==1)
	if(indexPath.section == 0)
	{
		if([appDelegate.arr_AddedEvents count])
		{
			EventDetailViewController *objDetail = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
 			objDetail.objEventList = [appDelegate.arr_AddedEvents objectAtIndex:indexPath.row];
 			[self.navigationController pushViewController:objDetail animated:YES];
			[objDetail release];
		}
	}
	else if(indexPath.section == 1)
	{
		if([appDelegate.arrFavorite count])
		{
			EventDetailViewController *objDetail = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:[NSBundle mainBundle]];
   			objDetail.objEventList = [appDelegate.arrFavorite objectAtIndex:indexPath.row];
			[self.navigationController pushViewController:objDetail animated:YES];
			[objDetail release];
		}
	}
}

#pragma mark -

#pragma mark -
#pragma mark downloadImage

-(void)downloadImage:(NSString *)strImagePath Tag:(NSInteger)tag {
	
	NSString *strpath = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, strImagePath];
	
	HttpRequest *req =[[HttpRequest alloc]init];
	[req GetRequest:strpath Delegate:self Tag:tag ModuleName:strImagePath];
	[req release];
}

- (void)httpResponseReceived:(WebResponse *)response {
	
	if(response.tag ==12 ) {
        
        if(!response.isError)
		{
            UIImage *img =[UIImage imageWithData:response.data];
            imgViewProfile.image = img;
        }
		
		
		[loader stopAnimating];
	}
}


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
			imgViewProfile.image = img;
			objUser.imgCover = img;
			
			
		}
		else
		{
			UIImage *img =[UIImage imageNamed:@"NoImageEvent.png"];
			imgViewProfile.image = img;
			objUser.imgCover = img;
		}
        
        [imageData release];
		
	}
	else
	{
		UIImage *img =[UIImage imageNamed:@"NoImageEvent.png"];
		imgViewProfile.image = img;
		objUser.imgCover = img;
	}
	
	[UserLayer Update:objUser];
	
	[loader stopAnimating];
    
	
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
	
	[strlocation release];
	[arrUserLocation release];
	tblAttend.delegate = nil;
	tblAttend.dataSource = nil;
	[tblAttend release];
	[lblCountry release];
	[imgViewProfile release];
    [super dealloc];
}

@end
