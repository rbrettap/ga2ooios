//
//  SettingCellViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "SettingCellViewController.h"
#import "facebookConnectViewController.h"
#import "RegisterObject.h"
#import <QuartzCore/QuartzCore.h>


@implementation SettingCellViewController
@synthesize strInvisibleMode;
@synthesize strDeleteAccount;

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
	
	self.navigationController.navigationItem.rightBarButtonItem =  nil;
	arrAssociation = [[NSMutableArray alloc] init];

	associationLayer = [[UserAssociationBL alloc] init];
	associationLayer.delegate = self;
    
    
    
	[self loadAnimation];
	
	if(appDelegate.isNetAvail)
	{
		if (![appDelegate isHostReachable:hostURL])
		{
			[appDelegate showServerNotAvailable];
			[self removeSyncLoader];
		}
		[associationLayer LoadUserAssociation:appDelegate.currentUserID];
	}
	else {
		[appDelegate noInternetConnectionAlert];
		[self removeSyncLoader];
	}
	
}

-(void)UserAssociationLoadingCompleted
{
	arrAssociation = [associationLayer SelectAll];

	tblSetting.backgroundColor = [UIColor clearColor];
	tblSetting.scrollEnabled = FALSE;
	
	arrSetting = [[NSMutableArray alloc] init] ;
	[arrSetting addObject:@"Password"];
	
	[arrSetting addObject:@"Invisible Mode"];
	[arrSetting addObject:@"Delete Account"];
	/*for(int i = 0; i<[arrAssociation count]; i++)
	{
		UserAssociationBO *objAss = [arrAssociation objectAtIndex:i];
		[arrSetting addObject:objAss.AssociationType];
	}*/
	arrPswd = [[NSMutableArray alloc] initWithObjects:@"New Password", @"Retype Password", nil];
	
	UserLayer = [[UserBL alloc]init];
	UserLayer.delegate = self;
 	objUser = (UserBO*) [UserLayer SelectByKey:appDelegate.currentUserID withMode:YES];
	[self removeSyncLoader];
	[tblSetting reloadData];
}




#pragma mark UITableView Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	if(tableView.tag!=1111)
		return @"Account";
	else
		return @"Change Password";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if(tableView.tag!=1111)
		return [arrSetting count];
	else
		return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(tableView.tag!=1111)
	{
		static NSString *CellIdentifier = @"Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
		}
		
		// Set up the cell...
		cell.textLabel.text = [arrSetting objectAtIndex:indexPath.row];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		for(UIView *vw in cell.contentView.subviews)
		{
			if(vw.tag == 11112 || vw.tag == 11111 || vw.tag == 7854)
				[vw removeFromSuperview];
			
		}
		
		CGRect frame = CGRectMake(198.0, 7.0, 94.0, 27.0);
		UISwitch *switchCtl = [[UISwitch alloc] initWithFrame:frame];
		[switchCtl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
		switchCtl.backgroundColor = [UIColor clearColor];
		[switchCtl setAccessibilityLabel:NSLocalizedString(@"StandardSwitch", @"")];
		switchCtl.tag = 11111;
		[cell.contentView addSubview:switchCtl];
		
		if(indexPath.row==0)
		{
			switchCtl.hidden = YES;
			
				
				UITextField *txtPassword = [[UITextField alloc] init];
				txtPassword.frame = CGRectMake(125, 10, 167, 24);
				txtPassword.secureTextEntry = YES;
				txtPassword.text = @"";
				txtPassword.tag = 7854;
				txtPassword.textColor = [UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
				[cell.contentView addSubview:txtPassword];
 			
			txtPassword.text = objUser.Password;
			
			NSLog(@"objUser.Password %@ ",objUser.Password);

			
			[txtPassword release];
			
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //[btn setBackgroundImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlEventTouchUpInside];
			btn.frame = CGRectMake(100, 5, 200, 34);
			[btn addTarget:self action:@selector(pswdBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.contentView addSubview:btn];
		}
		if(indexPath.row==2)
		{
			
			switchCtl.hidden = NO;
			if([objUser.IsActive caseInsensitiveCompare:@"True"] == NSOrderedSame)
			{
                [switchCtl setOn:NO];
                [switchCtl setSelected:1];
				self.strDeleteAccount = @"True";
                
				
			}
			else {
				
                [switchCtl setOn:YES];
                [switchCtl setSelected:0];
				self.strDeleteAccount = @"False";
                
				
			}
			
			switchCtl.tag = 11112;
			
		}
		if(indexPath.row==1)
		{
			//CGRect frame = CGRectMake(198.0, 7.0, 94.0, 27.0);
			//UISwitch *switchCtl = [[UISwitch alloc] initWithFrame:frame];
			switchCtl.hidden = NO;
			if([objUser.IsCalenderShared caseInsensitiveCompare:@"True"] == NSOrderedSame)
			{
				[switchCtl setOn:NO];
                [switchCtl setSelected:1];
				self.strInvisibleMode = @"True";
			}
			else {
				
				[switchCtl setOn:YES];
                [switchCtl setSelected:0];
				self.strInvisibleMode = @"False";
			}
			switchCtl.tag = 11111;
			//[switchCtl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
			//switchCtl.backgroundColor = [UIColor clearColor];
			//[switchCtl setAccessibilityLabel:NSLocalizedString(@"StandardSwitch", @"")];
			//[cell.contentView addSubview:switchCtl];
		}
        [switchCtl release];
		return cell;
	}
	else {
		static NSString *CellIdentifier = @"Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Set up the cell...
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = [arrPswd objectAtIndex:indexPath.row];

		UITextField *txtPassword = [[UITextField alloc] init];
		txtPassword.frame = CGRectMake(170, 10, 167, 24);
		txtPassword.secureTextEntry = YES;
		txtPassword.placeholder = @"Enter password";
		txtPassword.tag = 100+indexPath.row;
        txtPassword.delegate = self;
		txtPassword.textColor = [UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
		[cell.contentView addSubview:txtPassword];
		[txtPassword release];
		
		return cell;
	}
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.row > 2) {
		return UITableViewCellEditingStyleDelete;
 	}

	else {
		return UITableViewCellEditingStyleNone;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationLeft];   // crash on this line.
	[arrSetting removeObjectAtIndex:indexPath.row];
	[tableView reloadData];
		
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	/*if(indexPath.row == 3)
	{
		facebookConnectViewController *obj = [[facebookConnectViewController alloc]initWithNibName:@"facebookConnectViewController" bundle:[NSBundle mainBundle]];
		//obj.objTemp = nil;
		[self.navigationController pushViewController:obj animated:YES];
		[obj release];
	}*/
}

#pragma mark -

#pragma mark button Method

-(void)pswdBtnClicked:(id)sender
{
	tblSetting.userInteractionEnabled = FALSE;

   vwPswd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
	vwPswd.backgroundColor = [UIColor redColor];
	[vwPswd.layer setMasksToBounds:YES];
	
	UIImageView *imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
	imgBack.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mainbg" ofType:@"png"]];
	[vwPswd addSubview:imgBack];
	[imgBack release];
	
	UIImageView *imgTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	imgTop.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top_bar" ofType:@"png"]];
	[vwPswd addSubview:imgTop];
	[imgTop release];

	UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	lblTitle.text = @"Account";
	lblTitle.font = [UIFont fontWithName:boldFontName size:20];
	lblTitle.textAlignment = UITextAlignmentCenter;
	lblTitle.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
	lblTitle.backgroundColor = [UIColor clearColor];
	[vwPswd addSubview:lblTitle];
	[lblTitle release];
	
	UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 51, 30)];
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	btnBack.backgroundColor = [UIColor clearColor];
	[btnBack addTarget:self action:@selector(bigBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	[vwPswd addSubview:btnBack];
	[btnBack release];
	
	UIButton *btnDone = [[UIButton alloc]initWithFrame:CGRectMake(246, 7, 69, 31)];
	[btnDone setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
	btnDone.backgroundColor = [UIColor clearColor];
	[btnDone addTarget:self action:@selector(OKbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	[vwPswd addSubview:btnDone];
	[btnDone release];

	UIButton *btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(60, 160+44, 69, 31)];
	[btnCancel setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CancelBtn" ofType:@"png"]] forState:UIControlStateNormal];
	btnCancel.backgroundColor = [UIColor clearColor];
	[btnCancel addTarget:self action:@selector(bigBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[vwPswd addSubview:btnCancel];
	[btnCancel release];
	
	UIButton *btnOK = [[UIButton alloc]initWithFrame:CGRectMake(190, 160+44, 69, 31)];
	[btnOK setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OkBtn" ofType:@"png"]] forState:UIControlStateNormal];
	btnOK.backgroundColor = [UIColor clearColor];
	[btnOK addTarget:self action:@selector(OKbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[vwPswd addSubview:btnOK];
	[btnOK release];
	
	tblPswd = [[UITableView alloc] initWithFrame:CGRectMake(0, 10+44, 320, 140) style:UITableViewStyleGrouped];
	tblPswd.backgroundColor = [UIColor clearColor];
	tblPswd.tag =1111;
	tblPswd.delegate = self;
	tblPswd.dataSource = self;
	tblPswd.scrollEnabled = FALSE;
	[vwPswd addSubview:tblPswd];
		
	[self.view addSubview:vwPswd];
	//transforming the view
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	vwPswd.transform = transform;
	[self.view addSubview:vwPswd];
	
	//animation starts here
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	vwPswd.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
     [vwPswd release];
}

-(void)btnDoneClicked:(id)sender
{
}

-(void)OKbtnClicked:(id)sender
{
	UITextField *txt1 = (UITextField *)[self.view viewWithTag:100];
	UITextField *txt2 = (UITextField *)[self.view viewWithTag:101];
	
	if([txt1.text isEqualToString:@""] || [txt2.text isEqualToString:@""])
	{
		UIAlertView *alertPass2=[[UIAlertView alloc]initWithTitle:nil message:@"Both field are mandatory." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertPass2 show];
		[alertPass2 release];
	}
	else if([txt1.text isEqualToString:txt2.text])
	{
			
			objUser.Password = txt1.text;
			
			[self loadAnimation];
			if(appDelegate.isNetAvail)
			{	
				NSDateFormatter *format = [[NSDateFormatter alloc] init];
				[format setDateFormat:@"yyyy-MM-dd"];
				
				NSString *soapMsg = [[NSString alloc] initWithFormat:@
									 "<useraccount>"
									 "<id>%@</id>"
									 "<email>%@</email>"
									 "<username>%@</username>"
									 "<firstname>%@</firstname>"
									 "<lastname>%@</lastname>"
									 "<currentzip>%@</currentzip>"
									 "<gender>%@</gender>"
									 "<birthday>%@</birthday>"
									 "<password>%@</password>"
									 "<is_active>%@</is_active>"
									 "<is_public>True</is_public>"
									 "<is_calendar_shared>%@</is_calendar_shared>"
									 "<deviceid>123asd123</deviceid>"
									 "</useraccount>",
									 appDelegate.currentUserID, objUser.Email, objUser.Username, objUser.Firstname,
									 objUser.Lastname, objUser.Zipcode,objUser.Gender,[format stringFromDate:objUser.Birthday],txt1.text,objUser.IsActive,objUser.IsCalenderShared];
				
				[format release];
				
				updateLayer = [[UpdateProfileBL alloc] init];
				updateLayer.delegate = self;
                objUser.Password = txt1.text;
                
                NSLog(@"Request url ,%@",soapMsg);

				[updateLayer LoadUpdateProfilewith:soapMsg];
                [soapMsg release];
			}
			else {
				[appDelegate noInternetConnectionAlert];
				[self removeSyncLoader];
			}
		
	}
	else {
		UIAlertView *alertPass2=[[UIAlertView alloc]initWithTitle:nil message:@"Password and confirm password must be same." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertPass2 show];
		[alertPass2 release];
	}
	[txt1 resignFirstResponder];
	[txt2 resignFirstResponder];
    txt1 = nil;
    txt2 = nil;
}

-(void)UpdateProfileCompleted:(UpdateProfileBO *)Object
{
	
	[self removeSyncLoader];
	if(Object.Result>=1)
	{
        [UserLayer Update:objUser];
        

		UIAlertView *alertPass2=[[UIAlertView alloc]initWithTitle:nil message:@"Your Profile has been changed successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alertPass2.tag = 9999;
		[alertPass2 show];
		[alertPass2 release];
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error while updating your profile" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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

-(void)bigBtnClicked:(id)sender
{
 	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	vwPswd.transform = transform;
	vwPswd.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(rempoveLargeView) withObject:nil afterDelay:0.5];
}

-(void)rempoveLargeView
{
	tblSetting.userInteractionEnabled = YES;
	tblPswd.delegate = nil;
	tblPswd.dataSource = nil;
	[tblPswd release];
	[vwPswd removeFromSuperview];
	
}


- (void)switchAction:(id)sender
{
	UISwitch *switchCtl = (UISwitch *)[self.view viewWithTag:[sender tag]];
	if([sender tag]==11111)
	{
		if(switchCtl.on)
            self.strInvisibleMode = @"False";
			
		else
			self.strInvisibleMode = @"True";
		
		NSLog(@"self.strInvisibleMode ,%@",self.strInvisibleMode);
	}
	else if([sender tag]==11112)
	{
		if(switchCtl.on)
			self.strDeleteAccount = @"False";
		else
			self.strDeleteAccount = @"True";
		
		NSLog(@"self.strDeleteAccount ,%@",self.strDeleteAccount);
	}
}

-(void)DelBtnClicked:(id)sender
{
}

#pragma mark -

#pragma mark IBAction Method

-(IBAction) logoutBtn_Clicked
{
	
	[self loadAnimation];
	if(appDelegate.isNetAvail)
	{	
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"yyyy-MM-dd"];
		
		NSString *soapMsg = [[NSString alloc] initWithFormat:@
							 "<useraccount>"
							 "<id>%@</id>"
							 "<email>%@</email>"
							 "<username>%@</username>"
							 "<firstname>%@</firstname>"
							 "<lastname>%@</lastname>"
							 "<currentzip>%@</currentzip>"
							 "<gender>%@</gender>"
							 "<birthday>%@</birthday>"
							 "<password>%@</password>"
							 "<is_active>%@</is_active>"
							 "<is_public>True</is_public>"
							 "<is_calendar_shared>%@</is_calendar_shared>"
							 "<deviceid>123asd123</deviceid>"
							 "</useraccount>",
							 appDelegate.currentUserID, objUser.Email, objUser.Username, objUser.Firstname,
							 objUser.Lastname, objUser.Zipcode,objUser.Gender,[format stringFromDate:objUser.Birthday],objUser.Password, self.strDeleteAccount, self.strInvisibleMode];
		
		
		[format release];
		
		updateLayer = [[UpdateProfileBL alloc] init];
		updateLayer.delegate = self;
        
        NSLog(@"Request url ,%@",soapMsg);
        
        objUser.IsActive = self.strDeleteAccount;
        objUser.IsCalenderShared = self.strInvisibleMode;
		
		[updateLayer LoadUpdateProfilewith:soapMsg];
        [soapMsg release];
	}
	else {
		[appDelegate noInternetConnectionAlert];
		[self removeSyncLoader];
	}
}


-(IBAction)backBtnClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

#pragma mark alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 9999)
	{
       
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.29];
            CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
            vwPswd.transform = transform;
            vwPswd.alpha = 0.0;
            [UIView commitAnimations];
            [self performSelector:@selector(rempoveLargeView) withObject:nil afterDelay:0.5];
        
		   objUser = (UserBO *)[UserLayer SelectByKey:appDelegate.currentUserID withMode:YES]; 
     
		[tblSetting reloadData];
       
	}
}

#pragma mark -

#pragma mark TextField delegate

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	//UITextField *txtField = (UITextField *)[self.view viewWithTag:999];
	
	return [textField resignFirstResponder];
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

    // [vwPswd release];
	UserLayer.delegate = nil;
	[UserLayer release];
	//[arrAssociation release];
	associationLayer.delegate = nil;
	[associationLayer release];
	if(updateLayer.delegate)
	{
		updateLayer.delegate = nil;
		[updateLayer release];
	}
	tblSetting.delegate = nil;
	tblSetting.dataSource = nil;
	[tblSetting release];
	[arrSetting release];
    [super dealloc];
}


@end
