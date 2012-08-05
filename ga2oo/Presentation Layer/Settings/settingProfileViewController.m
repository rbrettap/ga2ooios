//
//  settingProfileViewController.m
//  Ga2oo
//
//  Created by Fahad on 20/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "settingProfileViewController.h"
#import "LoginMapViewController.h"
#import "RegisterObject.h"
#import "UserBL.h"
#import "UserLocationBL.h"
#import "ServiceOutput.h"
#import "UserAssociationDA.h"
#import "XMLLatLang.h"



@implementation settingProfileViewController

@synthesize arrUserProfile;
@synthesize imgProfile;

int ROWID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	arrSetting = [[NSMutableArray alloc] initWithObjects:@"Email", @"First Name", @"Last Name", @"Username", nil];
	tblSetting.backgroundColor = [UIColor clearColor];
	self.arrUserProfile = [[NSMutableArray alloc] init];
	
	UserLayer = [[UserBL alloc]init];
	UserLayer.delegate = self;
 	objUser = (UserBO*) [UserLayer SelectByKey:appDelegate.currentUserID withMode:YES];
	//[self displayProfileImage];
    
	
	if (objUser.imgCover)
	{
		self.imgProfile = objUser.imgCover; 
	}
	else 
	{
		
		[self loadAnimation];
		[NSThread detachNewThreadSelector:@selector(displayProfileImage) toTarget:self withObject:nil];
	}
	UserLocLayer = [[UserLocationBL alloc]init];
    UserLocLayer.delegate = self;
	
	viewToolBar.frame = CGRectMake(0, 600, 320, 44);
	[self.view addSubview:viewToolBar];
	isFirstTime = YES;
	//[arrUserProfile removeAllObjects];
}

/*
 displayProfileImage used for displaying profile image of the user
 return void
 */
-(void)displayProfileImage
{
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, objUser.UserImage];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error)
			self.imgProfile = [[UIImage alloc]initWithData:imageData];
		else
			self.imgProfile = [UIImage imageNamed:@"NoImageEvent.png"];
		[imageData release];
		
	}
	else
	{
		self.imgProfile = [UIImage imageNamed:@"NoImageEvent.png"];
	}
	objUser.imgCover = self.imgProfile;
	[UserLayer Update:objUser];
	
    [tblSetting reloadData];
    
    [self removeSyncLoader];
	
}

-(void)viewWillAppear:(BOOL)animated
{
    arrUserProfile = nil;
	self.arrUserProfile = [UserLocLayer SelectAll];
    
    NSSortDescriptor *sort_des = [[NSSortDescriptor alloc]initWithKey:@"LocationId" ascending:YES];
    [arrUserProfile sortUsingDescriptors:[NSArray arrayWithObject:sort_des]];
    [sort_des release];
    
	[tblSetting reloadData];
}

#pragma mark UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 0)
		return NO;
	else if(indexPath.section == 1)
		return NO;
	else if([arrUserProfile count])
	{
		if(indexPath.row == [arrUserProfile count])
			return NO;
		else
			return YES;
	}
	else {
		return NO;
	}
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Settings";
	else if(section == 1)
		return @"Update Image";
	else
		return @"Saved Locations";
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	NSLog(@"%i",toIndexPath.row);
	UserLocationBO *obj = [self.arrUserProfile objectAtIndex:fromIndexPath.row];
	[obj retain];
	[self.arrUserProfile removeObjectAtIndex:fromIndexPath.row];
	[self.arrUserProfile insertObject:obj atIndex:toIndexPath.row];
	[obj release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return [arrSetting count];
	else if(section == 1)
		return 1; 
	else if([arrUserProfile count])
		return [arrUserProfile count]+1;
	else {
		return 1;
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 1)
	{
		return 100;
	}
	else {
		return 44;
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier111 = @"Cell123";
	
	UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier111];
	   cell = nil;
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier111] autorelease];
	}
	for(UIView *vw in cell.contentView.subviews)
	{
		if(vw.tag == 1000+indexPath.row+indexPath.section)
		{
			[vw removeFromSuperview];
		}
	}
	for(UIView *vw in cell.contentView.subviews)
	{
		if(vw.tag == 100+indexPath.row)
		{
			[vw removeFromSuperview];
		}
	}
	// Set up the cell...
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if(indexPath.section == 0)
	{
		cell.textLabel.text = [arrSetting objectAtIndex:indexPath.row];
		
		UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(125, 10, 165, 25)];
		txtField.textColor = [UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
		txtField.backgroundColor = [UIColor clearColor];
		txtField.tag = 100+indexPath.row;
		if(txtField.tag==100)
			txtField.text = objUser.Email;
		if(txtField.tag==101)
			txtField.text = objUser.Firstname;
		if(txtField.tag==102)
			txtField.text = objUser.Lastname;
		if(txtField.tag==103){
			txtField.text = objUser.Username;
			txtField.userInteractionEnabled = NO;
		}
		
 		txtField.delegate = self;
		[cell.contentView addSubview:txtField];
	}
	else if(indexPath.section == 1)
	{
		cell.textLabel.text = @"Choose Image";
		btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
		btnImage.frame = CGRectMake(180, 10, 80, 80);
		[btnImage setBackgroundColor:[UIColor clearColor]];
		[btnImage setImage:self.imgProfile forState:UIControlStateNormal];
		[btnImage addTarget:self action:@selector(btnImageClicked:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:btnImage];
		[[btnImage layer] setCornerRadius:8.0f];
		[[btnImage layer] setMasksToBounds:YES];
		[[btnImage layer] setBorderWidth:2.0f];
		[[btnImage layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
	}
	else
	{
		if([arrUserProfile count])
		{
			if(indexPath.row==[arrUserProfile count])
			{
				isFirstTime = NO;
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.textLabel.text = @"Add Location";
			}
			else 
			{
				UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 220, 44)];
				if([self.arrUserProfile count])
				{
					UserLocationBO *obj = [self.arrUserProfile objectAtIndex:indexPath.row];
					NSLog(@"obj.Zipcode %@",obj.Zipcode);
					/*if([obj.Zipcode length] || [obj.Zipcode isEqualToString:@"None"])
					 {
					 if (![obj.City length] || [obj.City isEqualToString:@"None"])
					 {
					 lbl.text = [NSString stringWithFormat:@"%@, %@", obj.State, obj.Zipcode];
					 }
					 else 
					 {
					 lbl.text = [NSString stringWithFormat:@"%@, %@", obj.City, obj.Zipcode];
					 }
					 }
					 else 
					 {
					 if (![obj.City length] || [obj.City isEqualToString:@"None"])
					 {
					 lbl.text = [NSString stringWithFormat:@"%@", obj.State];
					 }
					 else 
					 {
					 lbl.text = [NSString stringWithFormat:@"%@", obj.City];
					 }
					 }
					 }
					 */
					NSString *TempString = [NSString stringWithFormat:@""];
					
					if ([obj.City length])
					{
						if ([obj.City isEqualToString:@"None"])
						{
							TempString = [NSString stringWithFormat:@"%@", obj.State];
						}
						else 
						{
							TempString = [NSString stringWithFormat:@"%@", obj.City];
						}
						
					}
					
					if ([obj.Zipcode length])
					{
						if([obj.Zipcode isEqualToString:@"None"])
						{
						}
						else
						{
							TempString = [TempString stringByAppendingFormat:@" , %@",obj.Zipcode];
						}
					}
					
					lbl.text = [NSString stringWithFormat:@"%@", TempString];
					
					lbl.font = [UIFont boldSystemFontOfSize:17];
					lbl.tag = 1000+indexPath.row+indexPath.section;
					lbl.backgroundColor = [UIColor clearColor];
					[cell.contentView addSubview:lbl];
					[lbl release];
				}
			}
		}
		else {
			
			isFirstTime = NO;
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.text = @"Add Location";
		}
		
	}
	return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.section == 2) {
		if([self.arrUserProfile count])
		{
			if (indexPath.row == [self.arrUserProfile count]) {
				return UITableViewCellEditingStyleNone;
 			}
			else {
				return UITableViewCellEditingStyleDelete;
				
			}
			
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
	ROWID=indexPath.row;
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure, you want to delete this location?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
	[alert show];
	alert.tag = 4587;
	[alert release];
	
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(indexPath.section == 0){
		
		if (indexPath.row != 3) {
			UITextField *txtField = (UITextField *)[self.view viewWithTag:100+indexPath.row];
			[txtField becomeFirstResponder];
		}
 	}
	else if(indexPath.section == 1){
		
		
		
	}
	else{
		if([arrUserProfile count])
		{
			if(indexPath.row==[arrUserProfile count])
			{
				UIAlertView *alertPass=[[UIAlertView alloc]initWithTitle:nil message:@"Choose current location or zip." delegate:self cancelButtonTitle:@"Current location" otherButtonTitles:@"Enter zip",nil];
				alertPass.tag=11;
				[alertPass show];
				[alertPass release];
			}
			else {
				
				objuserLoc = [arrUserProfile objectAtIndex:indexPath.row];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to make the location as primary location?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
				alert.tag = 999;
				[alert show];
				[alert release];
			}
			
		}
		else {
			
			UIAlertView *alertPass=[[UIAlertView alloc]initWithTitle:nil message:@"Choose current location or zip." delegate:self cancelButtonTitle:@"Current location" otherButtonTitles:@"Enter zip",nil];
			alertPass.tag=11;
			[alertPass show];
			[alertPass release];
		}
		
	}
}


-(void *)GettingDataforZipCode:(NSString *) StrValue
{
  	NSString * urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps/geo?key=AIzaSyAaIDsz4n8sACcuJrGpnwkSfIBrUZwjX9Y&output=xml&q=%@",[StrValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *parseError = nil;
    XMLLatLang *streamingParser = [[XMLLatLang alloc]init];
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
	UserLocationBO *NewUserLocation = [streamingParser parseXMLFileAtURL:[NSURL URLWithString:urlString] parseError:&parseError];
    
    [streamingParser release]; 
	
	if(![NewUserLocation.City length] && ![NewUserLocation.State length])
	{
		UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to find location for this zip code." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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


#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 999)
	{
		if(buttonIndex == 1)
		{
			
			[self setTheLocationAsPrimary];
			
			
		}
	}
	else if(alertView.tag == 4587)
	{
		if(buttonIndex == 1)
		{
			[self deleteTheLocation];
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
			
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Enter zipcode" message:@"Some text to increase area." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
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
    else if(alertView.tag == 6699)
    {
        
     [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(void)setTheLocationAsPrimary{
	
	[UserLocLayer setTheLocatioAsPrimary:objuserLoc];
	
	
	for(int i = 0; i<[self.arrUserProfile count]; i++)
	{
		UserLocationBO *obj = [arrUserProfile objectAtIndex:i];
		obj.IsPrimary = @"False";
		[UserLocLayer Update:obj withSave:YES];			
	}
	objuserLoc.IsPrimary = @"True";
	[UserLocLayer Update:objuserLoc withSave:YES];	
	
	
}
-(void)deleteTheLocation{
	
	UserLocationBO *obj = [arrUserProfile objectAtIndex:ROWID];
	
 	if([UserLocLayer deleteTheLocatioFromServer:obj])
    {
        [self loadAnimation];
    }
    else 
    {
        
    }
	/*
	 //[objUserLocation Insert:objUserLoc withSave:YES];
	 
	 [self.arrUserProfile removeObjectAtIndex:indexPath.row];
	 [tableView reloadData];
	 if(![self.arrUserProfile count])
	 {
	 
	 }*/
	
}


-(void)ServiceRequestCompleted:(ServiceOutput *)Object
{
 	if([Object.responseStringfromWeb length])
	{
		if([Object.responseStringfromWeb isEqualToString:@"-1"])
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"An error occurred while deleting the location, please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
		}
		else if([Object.responseStringfromWeb isEqualToString:@"-2"])
		{
			
 		}
		else if([Object.responseStringfromWeb isEqualToString:@"Success"])
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Selected location has been deleted successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			alert.tag = 876;
			[alert release];
			UserLocationBO *obj = [arrUserProfile objectAtIndex:ROWID];
			
			[UserLocLayer DeleteObject:obj];
			[arrUserProfile removeObjectAtIndex:ROWID];
			[tblSetting reloadData];
 		}
		
	}
	else {
 		UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Error." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterPw show];
		[alertEnterPw release];	
	}
    [self removeSyncLoader];
	
}



#pragma mark UIButton Method

-(void)btnImageClicked:(id)sender
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

-(void)DelBtnClicked:(id)sender
{
}

#pragma mark -

#pragma mark actionSheetStyle Delegate

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
}

#pragma mark -

#pragma mark ImagePicker Delegate

-(void)choosePhoto{
	
	UIImagePickerController	*piccontroller = [[UIImagePickerController alloc] init];
	piccontroller.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
	piccontroller.allowsEditing = NO;
	piccontroller.delegate = self;
	[self presentModalViewController:piccontroller animated:YES];
	[piccontroller release];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	
	[picker dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo	
{
	if(myimage)
	{
		self.imgProfile = [self getScaledImage:myimage toSize:CGRectMake(0, 0, 320, 480)];
	}
	[tblSetting reloadData];
  	[picker dismissModalViewControllerAnimated:YES];
    [self loadAnimation];
    [NSThread detachNewThreadSelector:@selector(uploadProfileImageToServer) toTarget:self withObject:nil];
	//[self uploadProfileImageToServer];
}


-(UIImage *)getScaledImage:(UIImage *)actualImage toSize:(CGRect)requiredSize
{	
	float actualHeight = actualImage.size.height;
	float actualWidth = actualImage.size.width;
	float imgRatio = actualWidth/actualHeight;
	
	float targetWidth = requiredSize.size.width;
	float targetHeight=requiredSize.size.height;
	
	float maxRatio = targetWidth/targetHeight;
	
	if(imgRatio!=maxRatio){
		
		if(imgRatio < maxRatio){
			imgRatio = targetHeight / actualHeight;
			actualWidth = imgRatio * actualWidth;
			actualHeight = targetHeight;
		}
		else{
			
			imgRatio =targetWidth / actualWidth;
			actualHeight = imgRatio * actualHeight;
			actualWidth = targetWidth;
		}
	}
	CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
	UIGraphicsBeginImageContext(rect.size);
	[actualImage drawInRect:rect];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;	
}

-(void)uploadProfileImageToServer{
	if (!updateLayer) {
		updateLayer = [[UpdateProfileBL alloc] init];
		updateLayer.delegate = self;
		
	}
    
	[updateLayer uploadProfileImageToServer:self.imgProfile];
	
	
	
}

-(void)uploadProfileImageToServerCompleted
{
	
	objUser.imgCover = self.imgProfile;
	[UserLayer Update:objUser];
	
    NSLog(@"Good");
    [self removeSyncLoader];
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

#pragma mark IBAction Method

-(IBAction)barBtnsClicked:(id)sender
{
	int tag1 = currenttextfiled.tag;
	if(tag1 == 100)
	{
		objUser.Email = currenttextfiled.text;
	}
	else if(tag1 == 101)
	{
		objUser.Firstname = currenttextfiled.text;
	}
	else if(tag1 == 102)
	{
		objUser.Lastname = currenttextfiled.text;
	}
	else if(tag1 == 103)
	{
		objUser.Username = currenttextfiled.text;
	}
	
	if([sender tag] !=3)
	{
		int tag = currenttextfiled.tag;
		if(tag == 100)
		{
			objUser.Email = currenttextfiled.text;
		}
		else if(tag == 101)
		{
			objUser.Firstname = currenttextfiled.text;
		}
		else if(tag == 102)
		{
			objUser.Lastname = currenttextfiled.text;
		}
		else if(tag == 103)
		{
			objUser.Username = currenttextfiled.text;
		}
		
		if([sender tag] == 1 && tag !=100)
			tag -=1;
		else if ([sender tag] == 2 && tag !=103)
			tag +=1;	
		if(currenttextfiled.tag != tag)
		{
			UIResponder* nextResponder = [tblSetting viewWithTag:tag];
			if (nextResponder)
			{
				// Found next responder, so set it.
				[nextResponder becomeFirstResponder];
			}
			currenttextfiled = (UITextField *)nextResponder;
		}
		[self enableDisableTheBarButtons];
		
	}
	else 
	{
		CGPoint point = CGPointMake(160, 600);
		[self showHideToolBar:point];
		[currenttextfiled resignFirstResponder];
		point = CGPointZero;
		[self setTheContentOffsetOfTheTable:point];
	}
}

-(IBAction)backBtnClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)doneBtnClicked
{
	CGPoint point = CGPointMake(160, 600);
	[self showHideToolBar:point];
	point = CGPointZero;
	//[self setTheContentOffsetOfTheTable:point];
	
	[currenttextfiled resignFirstResponder];
	
	//UITextField *txt1 = (UITextField *)[self.view viewWithTag:100];
	BOOL isValid = [self validateEmail:objUser.Email];
	
	/*UITextField *txt2 = (UITextField *)[self.view viewWithTag:101];
	objUser.Firstname = txt2.text;
	
	UITextField *txt3 = (UITextField *)[self.view viewWithTag:102];
	objUser.Lastname= txt3.text;
	
	UITextField *txt4 = (UITextField *)[self.view viewWithTag:103];
	objUser.Username = txt4.text;
	*/
	//objUser.UserImage = (UIImageView*)[self.view viewWithTag:<#(NSInteger)tag#>
	if([objUser.Email length]==0 || [objUser.Firstname length]==0 || [objUser.Lastname length]==0 || [objUser.Username length]==0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please fill all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else {
		
		if(isValid)
		{
			[self loadAnimation];
			//objUser.Email = txt1.text;
            
            
            if(objUser.Zipcode==nil)
            {
                objUser.Zipcode = [NSString stringWithFormat:@"None"];
            }
            
            
			if(appDelegate.isNetAvail)
			{
                
                NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                
                
				NSString *soapMsg = [[NSString alloc] initWithFormat:@
									 "<useraccount>\n"
									 "<id>%@</id>\n"
									 "<email>%@</email>\n"
									 "<username>%@</username>\n"
									 "<firstname>%@</firstname>\n"
									 "<lastname>%@</lastname>\n"
									 "<currentzip>%@</currentzip>\n"
									 "<gender>%@</gender>\n"
									 "<birthday>%@</birthday>\n"
									 "<password>%@</password>\n"
 									 "<is_active>True</is_active>\n"
									 "<is_public>True</is_public>\n"
									 "<is_calendar_shared>True</is_calendar_shared>\n"
									 "<deviceid>123asd123</deviceid>\n",
									 appDelegate.currentUserID, objUser.Email, objUser.Username, objUser.Firstname,
									 objUser.Lastname, objUser.Zipcode,objUser.Gender,[formatter stringFromDate:objUser.Birthday],objUser.Password];
				
				[formatter release];
				
				
				NSString *SavedLocatios= @"<savedlocations>\n";
				
				for (int i=0; i<[arrUserProfile count]; i++)
                {
					
					UserLocationBO *loc = [arrUserProfile objectAtIndex:i];
					SavedLocatios = [SavedLocatios stringByAppendingFormat:@
									 "<location>\n"
									 "<id>%@</id>\n"
									 "<is_primary>%@</is_primary>\n"
									 "<geocode>%@</geocode>\n"
									 "<address>%@</address>\n"
									 "<city>%@</city>\n"
									 "<state>%@</state>\n"
									 "<zip>%@</zip>\n"
									 "<country>%@</country>\n"
									 "</location>\n",
									 loc.LocationId,loc.IsPrimary,loc.GeoPoint,loc.Address,loc.City,loc.State,loc.Zipcode,loc.Country];
					
				}
                
				SavedLocatios = [SavedLocatios stringByAppendingString:@"</savedlocations>\n"];
				
				soapMsg = [soapMsg stringByAppendingString:SavedLocatios];
                
                
                
                UserAssociationDA *DAlyer = [[UserAssociationDA alloc]init];
                NSMutableArray *arr_Associations = [DAlyer SelectAll];
                [DAlyer release];
                
                NSSortDescriptor *sort_des = [[NSSortDescriptor alloc]initWithKey:@"AssociationUserId" ascending:YES];
                [arr_Associations sortUsingDescriptors:[NSArray arrayWithObject:sort_des]];
                [sort_des release];
				
                
                NSString *SavedAssociations= @"<associations>\n";
                
				for (int i=0; i<[arr_Associations count]; i++)
                {
					
                    UserAssociationBO *object = [arr_Associations objectAtIndex:i];
                    
                    SavedAssociations = [SavedAssociations stringByAppendingFormat:@
                                         "<association>\n"
                                         "<id>%@</id>\n"
                                         "<associationid>%@</associationid>\n"
                                         "<associationtype>%@</associationtype>\n" 
                                         "</association>\n", object.AssociationUserId,object.AssociationId,object.AssociationType];
					
                }
				
                SavedAssociations = [SavedAssociations stringByAppendingString:@"</associations>\n"];
                
                soapMsg = [soapMsg stringByAppendingString:SavedAssociations];
				
				soapMsg = [soapMsg stringByAppendingString:@"</useraccount>\n"];
				
				NSLog(@"%@",soapMsg);
				updateLayer = [[UpdateProfileBL alloc] init];
				updateLayer.delegate = self;
				[updateLayer UpdateProfileXML:soapMsg];
			}
			else 
            {
				[appDelegate noInternetConnectionAlert];
				[self removeSyncLoader];
			}
		}
		else
        {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a valid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

-(void)UpdateProfileCompleted:(UpdateProfileBO *)Object
{
	[self removeSyncLoader];
	if(Object.Result>0)
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Your Profile have been updated successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
        alert.tag = 6699;
		[alert release];
        
        if(Object.Result==[objUser.UserId integerValue])
        {
            [UserLayer Update:objUser];
        }
 	}
	else
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error while updating your profile." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(BOOL) validateEmail: (NSString *) candidate 
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	return [emailTest evaluateWithObject:candidate];
}

#pragma mark -

#pragma mark UITextField Delgate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGPoint point = CGPointMake(160, 223);
	[self showHideToolBar:point];
	
	if(textField.tag == 100)
		textField.keyboardType = UIKeyboardTypeEmailAddress;
	else
		textField.keyboardType = UIKeyboardTypeDefault;
	
	currenttextfiled = textField;
	
	[self enableDisableTheBarButtons];
	
	if(textField.tag == 103)
		point = CGPointMake(0, (currenttextfiled.tag -100)*23);
	else
		point = CGPointMake(0, (currenttextfiled.tag -100)*15);
	
	[self setTheContentOffsetOfTheTable:point];
	
	//return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	CGPoint point = CGPointMake(160, 600);
	[self showHideToolBar:point];
	point = CGPointZero;
	[self setTheContentOffsetOfTheTable:point];
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -

#pragma mark textField Function

-(void)setTheContentOffsetOfTheTable:(CGPoint)point
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	tblSetting.contentOffset = point;
	[UIView commitAnimations];
}


-(void)enableDisableTheBarButtons
{
	UIBarButtonItem *item = [toolBar.items objectAtIndex:0];
	
	if(currenttextfiled.tag == 100)
	{
		item.enabled = NO;
	}
	else {
		
		item.enabled = YES;
	}
	
	item = [toolBar.items objectAtIndex:1];
	if(currenttextfiled.tag == 102)
	{
		item.enabled = NO;
	}
	else 
	{
		item.enabled = YES;
	}
}


-(void)showHideToolBar:(CGPoint)point
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	viewToolBar.center = point;
	[self.view bringSubviewToFront:viewToolBar];
	[UIView commitAnimations];
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
	tblSetting.delegate = nil;
	tblSetting.dataSource = nil;
	[tblSetting release];
	UserLocLayer.delegate = nil;
	[UserLocLayer release];
	UserLayer.delegate = nil;
	[UserLayer release];
	updateLayer.delegate= nil;
	[updateLayer release];
	[arrUserProfile release];
    [super dealloc];
}


@end
