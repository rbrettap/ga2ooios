
//
//  PersonalViewController.m
//  Registration
//
//  Created by SaiKrishna on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCustonCell.h"
#import "Ga2ooAppDelegate.h"
#import "RegisterObject.h"
#import "LoginMapViewController.h"
#import "RegistrationBL.h"
#import "ServiceOutput.h"
#import "XMLLatLang.h"
#import <QuartzCore/QuartzCore.h>

@implementation PersonalViewController

@synthesize mapView,locationManager;
@synthesize ZipLocation;

CLLocationCoordinate2D currentLocation;

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	GoogleMapsAPIKey=@"AIzaSyAaIDsz4n8sACcuJrGpnwkSfIBrUZwjX9Y";

	appDelegate=(Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	//obj_LMV=[[LoginMapViewController alloc]init];
	//[obj_LMV mapFind];
    RegdLayer = [[RegistrationBL alloc] init];
    RegdLayer.delegate = self;
     loaderView = [[UIView alloc] initWithFrame:CGRectMake(75,130+55, 170, 49)];
	
	mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 390)];
	//[self.view addSubview:mapView];
	[mapView setShowsUserLocation:NO];
	
	locationManager = [[CLLocationManager alloc]init];
	locationManager.delegate = self;
	
	intValue = 1;
 	arr_Values=[[NSMutableArray alloc]init];
	[arr_Values addObject:@"First Name"];
	[arr_Values addObject:@"Last Name"];
	[arr_Values addObject:@"Email"];
	[arr_Values addObject:@"Username"];
	[arr_Values addObject:@"Password"];
	[arr_Values addObject:@"Confirm password"];
	[arr_Values addObject:@"Location"];
	[arr_Values addObject:@"Gender"];
	[arr_Values addObject:@"Birth Date"];
	
	arr_Values1=[[NSMutableArray alloc]init];
	[arr_Values1 addObject:@"Enter First Name"];
	[arr_Values1 addObject:@"Enter Last Name"];
	[arr_Values1 addObject:@"Enter Email"];
	[arr_Values1 addObject:@"Enter Username"];

	[arr_Values1 addObject:@"Enter Password"];
	[arr_Values1 addObject:@"Enter Confirm Password"];
	[arr_Values1 addObject:@"Select Location"];
	[arr_Values1 addObject:@"Select Gender"];
	[arr_Values1 addObject:@"Select Birth Date"];
	
	arr_Locations=[[NSMutableArray alloc]init];
	[arr_Locations addObject:@"hyderabad"];
	[arr_Locations addObject:@"Delhi"];
	[arr_Locations addObject:@"Mumbai"];
	[arr_Locations addObject:@"Banglore"];
	[arr_Locations addObject:@"Nizamabad"];
	[arr_Locations addObject:@"Pune"];
	
	arr_Gender=[[NSMutableArray alloc]init];
	[arr_Gender addObject:@"Male"];
	[arr_Gender addObject:@"Female"];
	
	toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 556, 320, 44)];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(barBtnsClicked:)];
	done.tag=3;
	UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(barBtnsClicked:)];
	next.tag=2;
	UIBarButtonItem *prev=[[UIBarButtonItem alloc]initWithTitle:@"Prev" style:UIBarButtonItemStyleBordered target:self action:@selector(barBtnsClicked:)];
	prev.tag=1;
	UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	toolBar.items=[[[NSArray alloc]initWithObjects:prev,next,space,done,nil]autorelease];
	toolBar.center=CGPointMake(160,550);
	[toolBar setTintColor:[UIColor colorWithRed:2.0/255.0 green:94.0/255.0 blue:118.0/255.0 alpha:1.0]];
	[self.view addSubview:toolBar];
    [done release];
    [next release];
    [prev release];
    [space release];
	
	tblView = [[UITableView alloc] initWithFrame:CGRectMake(0,46,320,415) style:UITableViewStyleGrouped];
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.scrollsToTop=YES;
	[tblView setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:tblView]; 
	
	btn_Submit = [UIButton buttonWithType:UIButtonTypeCustom];
	btn_Submit.frame=CGRectMake(50,0,112,47);
	[btn_Submit setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
	viewResult = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 320, 60)];
	[viewResult addSubview:btn_Submit];
	[btn_Submit addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
	tblView.tableFooterView = viewResult;
	
	//[self addPicker];
	[self addPicker1];
	[self addDatePicker];
	[self addToolBar];
}

- (void)locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	[manager stopUpdatingLocation];
	
    currentLocation.latitude = newLocation.coordinate.latitude;
	currentLocation.longitude = newLocation.coordinate.longitude;
	
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [manager stopUpdatingLocation];
	
}

-(IBAction)backButtonPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) btn1Action:(id )sender{
		
 

	
	RegisterObject *obj = [[RegisterObject alloc]init];
	UITextField *txt1 = (UITextField *)[tblView viewWithTag:110];
	obj.strFirstName = txt1.text;
	
	UITextField *txt2 = (UITextField *)[tblView viewWithTag:111];
	obj.strLastName = txt2.text;
	
	UITextField *txt3 = (UITextField *)[tblView viewWithTag:112];
	obj.strEmail = txt3.text;
	
	UITextField *txt4 = (UITextField *)[tblView viewWithTag:114];
	obj.strPaswd = txt4.text;
	
	UITextField *txt5 = (UITextField *)[tblView viewWithTag:113];
	obj.strUserName = txt5.text;
	
	UITextField *txt6 = (UITextField *)[tblView viewWithTag:116];
	obj.strLocation = txt6.text;
	
	
	UITextField *txt7 = (UITextField *)[tblView viewWithTag:117];
	obj.strGender = txt7.text;
	
	UITextField *txt8 = (UITextField *)[tblView viewWithTag:118];
	obj.strBirthDay = txt8.text;

	if (![obj.strFirstName length]) 
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your first name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strLastName length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your last name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strEmail length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strUserName length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strPaswd length]) 
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strLocation length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select your location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strGender length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select your gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (![obj.strBirthDay length])
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select your birth date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else 
    {
		BOOL mail_Check=[self mailIdCheck];
		BOOL pwdCheck=[self passwordCheck];
		
		if(pwdCheck)
		{
			if(mail_Check)
			{
                
                if(SeletedLocationMode==CurrentLocationMode)
                {
                    obj.address = appDelegate.strCurrentLocation.Address;
                    obj.geocode = appDelegate.strCurrentLocation.GeoPoint;
                    obj.city = appDelegate.strCurrentLocation.City;
                    obj.state = appDelegate.strCurrentLocation.State;
                    obj.country = appDelegate.strCurrentLocation.Country;
                    obj.zipcode = appDelegate.strCurrentLocation.Zipcode;                    
                }
                else if(SeletedLocationMode==ZipMode)
                {
                    obj.address = ZipLocation.Address;
                    obj.geocode = ZipLocation.GeoPoint;
                    if([ZipLocation.City length])
                    {
                        obj.city = ZipLocation.City;
                        obj.state = ZipLocation.State;
                    }
                    else
                    {
                        obj.city = ZipLocation.State;
                        obj.state = ZipLocation.State;
                    }
                    
                    
                    obj.country = ZipLocation.Country;
                    obj.zipcode = ZipLocation.Zipcode;                    
                }
                
               
                loaderView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
                loaderView.layer.cornerRadius = 6.0;
                loaderView.layer.borderColor = [[UIColor grayColor] CGColor];
                loaderView.layer.borderWidth = 2.0;
                loaderView.tag = 85;
                
                //add indicator
                UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 6, 37, 37)];
                [indView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
                [indView startAnimating];
                [loaderView addSubview:indView];
                [indView release];
                
                UILabel *lblSyncing = [[UILabel alloc] initWithFrame:CGRectMake(135-75,14, 90, 20)];
                lblSyncing.backgroundColor = [UIColor clearColor];
                lblSyncing.text = @"Loading...";
                lblSyncing.textAlignment =UITextAlignmentCenter;
                lblSyncing.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
                lblSyncing.font = [UIFont boldSystemFontOfSize:14.0];
                lblSyncing.textColor = [UIColor whiteColor];
                lblSyncing.alpha=1.0;
                [loaderView addSubview:lblSyncing];
                [lblSyncing release];
                [self.view addSubview:loaderView];
                
 			
 				[RegdLayer RegisterTheUserwith:obj];
  			}
			else
			{
				UIAlertView *alertPass1=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter a valid email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertPass1 show];
				[alertPass1 release];
			}
		}
		else
		{
			UIAlertView *alertPass2=[[UIAlertView alloc]initWithTitle:nil message:@"Password and confirm password must be same." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertPass2 show];
			[alertPass2 release];
 		}
 	}
	[obj release];
}
 
-(void)RegistrationCompleted:(ServiceOutput *)Object
{
	if([Object.responseStringfromWeb length])
	{
 		NSRange range1 = [Object.responseStringfromWeb rangeOfString:@"user was created with id" options:NSCaseInsensitiveSearch];
		NSRange rangeEmail = [Object.responseStringfromWeb rangeOfString:@"email" options:NSCaseInsensitiveSearch];
		NSRange rangeUsename = [Object.responseStringfromWeb rangeOfString:@"username" options:NSCaseInsensitiveSearch];

		if (range1.length == 24) 
        {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You are successfully registered." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			alert.tag = 458;
			[alert release];	
		}
		else if (rangeEmail.length == 5) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"This email already exists, please enter another email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			//alert.tag = 458;
			[alert release];	
		}
		else if([Object.responseStringfromWeb isEqualToString:@"-1"])
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"An error occurred while registration, please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
		}
		else if(rangeUsename.length == 8)
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"This username already exists, please enter another username." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
			
 		}
		else {
   			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"An error occurred while registration, please try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
 			[alert show];
 			alert.tag = 458;
 			[alert release];	
		}
	}
	else {
 		UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Error." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterPw show];
		[alertEnterPw release];	
	}
    
    [loaderView removeFromSuperview];
 }

#pragma mark -
#pragma mark Validation

-(BOOL)mailIdCheck
{
	UITextField *txtf = (UITextField *)[self.view viewWithTag:112];
	
	if([txtf.text length]==0)
	{
		selected=1;
	}
	if([self validateEmail:txtf.text])
	{
		selected=2;
		NSLog(@"selected:%@",txtf.text);
		return YES;		
	}
	else
	{
		selected=3;
		return NO;
	}
}

-(BOOL)passwordCheck
{
	UITextField *pwd1 = (UITextField *)[self.view viewWithTag:114];
	UITextField *pwd2 = (UITextField *)[self.view viewWithTag:115];
	
	if([pwd1.text length]==0 || [pwd1.text length]==0)
	{
		selected=4;
	}
	if([pwd1.text isEqualToString:pwd2.text])
	{
		selected=5;
		return YES;
	}
	else
	{
		selected=6;
		return NO;
	}
}

- (BOOL) validateEmail: (NSString *) candidate {
	
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark -
#pragma mark tableView dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arr_Values count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"PersonalCustonCell";
	PersonalCustonCell *cell = (PersonalCustonCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
	if(cell == nil)
	{
		cell = [[[PersonalCustonCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
	}

	cell.lbl1.text=[arr_Values objectAtIndex:indexPath.row];
	
	cell.txtField.tag=indexPath.row+110;
	cell.txtField.clearButtonMode = UITextFieldViewModeWhileEditing; 
	cell.txtField.delegate=self;
	cell.txtField.placeholder=[arr_Values1 objectAtIndex:indexPath.row];
	cell.txtField.font = [UIFont systemFontOfSize:14];
	
	if(indexPath.row==5 || indexPath.row==4)
		cell.txtField.secureTextEntry=YES;
	if(indexPath.row>6)
	{
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

#pragma mark tableView delegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
		
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;

}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	
    return viewResult.bounds.size.height+20;
}

#pragma mark -
#pragma mark alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if(alertView.tag==458)
	{
		if (buttonIndex == 0)
		{
			[self.navigationController popViewControllerAnimated:YES];
			//[appDelegate.window addSubview:appDelegate.tabBarController.view];
		}
	}
	else if(alertView.tag==11)
	{
		if (buttonIndex == 0)
		{
            
            SeletedLocationMode = CurrentLocationMode;
            
			if ([appDelegate.strCurrentLocation.City length]) 
			{
				if ([appDelegate.strCurrentLocation.City isEqualToString:@"None"])
				{
					currenttextfiled.text= [NSString stringWithFormat:@"%@", appDelegate.strCurrentLocation.State];	
				}
				else 
				{
					currenttextfiled.text= [NSString stringWithFormat:@"%@", appDelegate.strCurrentLocation.City];
				}
			}
			else if ([appDelegate.strCurrentLocation.State length])
			{
				currenttextfiled.text= [NSString stringWithFormat:@"%@", appDelegate.strCurrentLocation.State];
			}
			else 
			{
				UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check your device settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [myAlertView show];
                [myAlertView release];
			}
		}
		else if (buttonIndex==1)
		{
            
            SeletedLocationMode = ZipMode;
            
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Enter zipcode" message:@"Some text to increase area" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
			myAlertView.tag=111;
			myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
			myTextField.keyboardType=UIKeyboardTypeNumberPad;
			[myTextField setBackgroundColor:[UIColor whiteColor]];
			[myAlertView addSubview:myTextField];
			[myAlertView show];
			[myAlertView release];
			[myTextField release];
		}
        
	}
	else if(alertView.tag==111)
	{
		if (buttonIndex == 0)
		{
 			NSString *strCurrentAddress;
			if(myTextField.text ==nil)
			{
				UIAlertView *alertenterZip = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid zipcode." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                [alertenterZip show];
                                [alertenterZip release];
			}
			else{
			    currenttextfiled.text = myTextField.text;
			    [myTextField resignFirstResponder];
                             strCurrentAddress=[NSString stringWithFormat:@"%@", [self GettingDataforZipCode:currenttextfiled.text]];
 			    NSLog(@"the address is%@",strCurrentAddress);
                if ([strCurrentAddress isEqualToString:@"Unable to find location for this zip code"])
                {
                    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to find location for this zip code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [myAlertView show];
                    [myAlertView release];
                }
		    }
		}
		else if(buttonIndex == 1)
		{
			[myTextField resignFirstResponder];
		}
	}
}

-(NSString *)GettingDataforZipCode:(NSString *) StrValue
{
  	NSString * urlString = [[[NSString alloc] initWithFormat:@"http://maps.google.com/maps/geo?key=%@&output=xml&q=%@",GoogleMapsAPIKey,[StrValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] autorelease];
    
    NSError *parseError = nil;
    XMLLatLang *streamingParser = [[XMLLatLang alloc]init];
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
	self.ZipLocation = [streamingParser parseXMLFileAtURL:[NSURL URLWithString:urlString] parseError:&parseError];
    
    [streamingParser release]; 
    
    
    if([ZipLocation.City length])
    {
        currenttextfiled.text= [NSString stringWithFormat:@"%@", ZipLocation.City];	
    }
    else if ([ZipLocation.State length]) 
    {
        currenttextfiled.text= [NSString stringWithFormat:@"%@", ZipLocation.State];
    }
    else if ([ZipLocation.Country length]) 
    {
        currenttextfiled.text= [NSString stringWithFormat:@"%@", ZipLocation.Country];
    }
    else 
    {
        currenttextfiled.text = @"";
        urlString = @"Unable to find location for this zip code";
    }
    
    
	return urlString;
}

#pragma mark -
#pragma mark textField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	CGPoint point = CGPointMake(160, 224);
	[self showHideToolBar:point];
	currenttextfiled = textField;
	[self enableDisableTheBarButtons];
	
	if(currenttextfiled.tag==116)
	{
		toolBar.frame=CGRectMake(0, 600, 320, 44);
		point = CGPointMake(0, 0);
		[self setTheContentOffsetOfTheTable:point];
		if(intValue == 1)
		{
			[(UITextField *)[self.view viewWithTag:111] resignFirstResponder];
            [(UITextField *)[self.view viewWithTag:112] resignFirstResponder];
            [(UITextField *)[self.view viewWithTag:113] resignFirstResponder];
            [(UITextField *)[self.view viewWithTag:114] resignFirstResponder];
            [(UITextField *)[self.view viewWithTag:115] resignFirstResponder];
            [self hidePicker1];
            [self hideDatePicker];
            [currenttextfiled resignFirstResponder];
 			
			UIAlertView *alertPass=[[UIAlertView alloc]initWithTitle:nil message:@"Choose current location or zip." delegate:self cancelButtonTitle:@"Current location" otherButtonTitles:@"Enter zip",nil];
			alertPass.tag=11;
			[alertPass show];
			[alertPass release];
			intValue = 1;
 		}
		else
        {
			intValue = 1;
		}

		return NO;
	}
	else
	{
		point = CGPointMake(0, (currenttextfiled.tag -110)*35);
		[self setTheContentOffsetOfTheTable:point];
	}
	
	if(currenttextfiled.tag==117)
	{
		toolBar.frame=CGRectMake(0, 600, 320, 44);
		[self hideDatePicker];
		//[self hidePicker];
		[self showPicker1];
		return NO;
	}
	else
	{
		[self hidePicker1];
	}
	if(currenttextfiled.tag==118)
	{
		toolBar.frame=CGRectMake(0, 600, 320, 44);
		//[self hidePicker];
		[self hidePicker1];
		[self showDatePicker];
		return NO;
	}
	else
	{
		[self hideDatePicker];
	}
	
	if(currenttextfiled.tag==112)
	{
		currenttextfiled.keyboardType=UIKeyboardTypeEmailAddress;
		currenttextfiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
	}
	return YES;
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
#pragma mark toolbar actions

-(void)addToolBar
{
	keyboardToolBar=[[UIToolbar alloc]init];
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	
	UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked)];
	UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
	keyboardToolBar.items=[[[NSArray alloc]initWithObjects:cancel,space,done,nil]autorelease];
	[keyboardToolBar setTintColor:[UIColor colorWithRed:2.0/255.0 green:94.0/255.0 blue:118.0/255.0 alpha:1.0]];
	[self.view addSubview:keyboardToolBar];
    [space release];
    [cancel release];
    [done release];
}

/*
-(void)addPicker
{
	picker_Location=[[UIPickerView alloc] init];
	picker_Location.frame=CGRectMake(0, 600, 320, 216);
	picker_Location.tag=1;
	picker_Location.backgroundColor = [UIColor clearColor];
	picker_Location.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	picker_Location.showsSelectionIndicator = YES;	
	[self.view addSubview:picker_Location];
}
 */


-(void)addPicker1
{
	picker_Gender=[[UIPickerView alloc] init];
	picker_Gender.frame=CGRectMake(0, 600, 320, 216);
	picker_Gender.tag=2;
	picker_Gender.backgroundColor = [UIColor clearColor];
	picker_Gender.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	picker_Gender.showsSelectionIndicator = YES;	
	[self.view addSubview:picker_Gender];
}

/*
-(void)showPicker
{
	
	[(UITextField *)[self.view viewWithTag:111] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:112] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:113] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:114] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:115] resignFirstResponder];
	
	picker_Location.delegate = self;
	picker_Location.dataSource = self;
	[picker_Location  selectRow:intSelectedLoc inComponent:0 animated:YES];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	picker_Location.frame=CGRectMake(0, 255, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 214, 320, 44);
	[UIView commitAnimations];
}
 */

-(void)showPicker1
{
	[(UITextField *)[self.view viewWithTag:111] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:112] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:113] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:114] resignFirstResponder];
	[(UITextField *)[self.view viewWithTag:115] resignFirstResponder];
	
	picker_Gender.delegate = self;
	picker_Gender.dataSource = self;
	[picker_Gender  selectRow:intSelGender inComponent:0 animated:YES];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	picker_Gender.frame=CGRectMake(0, 255, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 214, 320, 44);
	[UIView commitAnimations];
}


-(void)hidePicker1
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.29];
	picker_Gender.frame=CGRectMake(0, 600, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	[UIView commitAnimations];
}


-(void)addDatePicker
{
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 600, 320, 216)];
	datePicker.datePickerMode = UIDatePickerModeDate;
	datePicker.date = [NSDate date];
	datePicker.maximumDate = [NSDate date];
	[datePicker addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:datePicker];
}

-(void)showDatePicker
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.29];
	datePicker.frame=CGRectMake(0, 255, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 214, 320, 44);
	[UIView commitAnimations];
}

-(void)hideDatePicker
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.29];
	datePicker.frame=CGRectMake(0, 600, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	[UIView commitAnimations];
}

-(void)changeDateInLabel:(id)sender{
	
}



-(void)showHideToolBar:(CGPoint)point
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	toolBar.center = point;
	[self.view bringSubviewToFront:toolBar];
	[UIView commitAnimations];
}

-(void)enableDisableTheBarButtons
{
	UIBarButtonItem *item = [toolBar.items objectAtIndex:0];
	if(currenttextfiled.tag == 110)
	{
		item.enabled = NO;
	}
	else {
		
		item.enabled = YES;
	}
	
	item = [toolBar.items objectAtIndex:1];
	if(currenttextfiled.tag == 115)
	{
		item.enabled = NO;
	}
	else {
		
		item.enabled = YES;
	}
}

-(void)setTheContentOffsetOfTheTable:(CGPoint)point
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	tblView.contentOffset = point;
	[UIView commitAnimations];
}

-(IBAction)barBtnsClicked:(id)sender
{
	if([sender tag] !=3)
	{
		int tag = currenttextfiled.tag;
		if([sender tag] == 1 && tag !=110)
			tag -=1;
		else if ([sender tag] == 2 && tag !=115)
			tag +=1;	
		if(currenttextfiled.tag != tag)
		{
			UIResponder* nextResponder = [tblView viewWithTag:tag];
			if (nextResponder)
			{
				[nextResponder becomeFirstResponder];
			}
			
			currenttextfiled = (UITextField *)nextResponder;
		}
		[self enableDisableTheBarButtons];
		
	}
	else {
		
		CGPoint point = CGPointMake(160, 600);
		[self showHideToolBar:point];
		[currenttextfiled resignFirstResponder];
		point = CGPointZero;
		[self setTheContentOffsetOfTheTable:point];
	}
}

-(void)doneClicked
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.29];
	
	if(currenttextfiled.tag==117)
	{
		currenttextfiled.text=[arr_Gender objectAtIndex:sel_pickerValue2];
		intSelGender=sel_pickerValue2;
	}
 	else if(currenttextfiled.tag==118)
	{
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"yyyy-MM-dd"];
 		currenttextfiled.text =[format stringFromDate:datePicker.date];
		[format release];
	}
	
 	picker_Gender.frame=CGRectMake(0, 600, 320, 216);
	
	datePicker.frame=CGRectMake(0, 600, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	CGPoint	point = CGPointZero;
	[self setTheContentOffsetOfTheTable:point];
	[UIView commitAnimations];
}

-(void)cancelClicked
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.29];
 	picker_Gender.frame=CGRectMake(0, 600, 320, 216);
 	datePicker.frame=CGRectMake(0, 600, 320, 216);
	keyboardToolBar.frame=CGRectMake(0, 800, 320, 44);
	CGPoint	point = CGPointZero;
	[self setTheContentOffsetOfTheTable:point];
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark picker delegate methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	if(currenttextfiled.tag==115)
	{
		return [arr_Locations count];
		
	}
	else if(currenttextfiled.tag==117)
	{
		return [arr_Gender count];
	}
	else {
		return 1;
	}
}
 
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if(currenttextfiled.tag==115)
	{
		return [arr_Locations objectAtIndex:row];
		
	}
	else if(currenttextfiled.tag==117)
	{
		return [arr_Gender objectAtIndex:row];
	}
	else
	{
		return @"";
	}
 }

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	if(thePickerView.tag==1)
	{
		sel_pickerValue1=row;
	}
	else if(thePickerView.tag==2)
	{
		sel_pickerValue2=row;
	}
	else
	{
	}
}

#pragma mark -
#pragma mark memoryManagement


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [RegdLayer release];
    [loaderView release];
	//[obj_LMV release];
    [ZipLocation release];
	[arr_Values1 release];
	arr_Values1=nil;
	[viewResult release];
	viewResult=nil;
	
	//[currenttextfiled release];
	[datePicker release];
 	[picker_Gender release];
	picker_Gender=nil;
	tblView.delegate = nil;
	tblView.dataSource = nil;
	[tblView release];
	[arr_Locations release];
	[arr_Gender release];
	[arr_Values release];
    [super dealloc];
}


@end
