//
//  facebookConnectViewController.m
//  iVoucher
//
//  Created by rajender on 10/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "facebookConnectViewController.h"

static NSString* kApiKey = @"e28aa0647ab1f5f072853e25a68ac50c";
static NSString* kApiSecret = @"cd7664adf351cbc6a3cb3ef6eae9f5c0";
static NSString* kGetSessionProxy = nil;
static NSString *storyTitle;


@implementation facebookConnectViewController
@synthesize permissionStatusForUser;
@synthesize str_FaceBookUserName;
@synthesize btn_login;
@synthesize lbl_LoginName;
@synthesize lbl_FooterText;
@synthesize loaderView;
@synthesize objTemp;
@synthesize _session;
@synthesize forLogin;
@synthesize canGetUserDetails;
@synthesize isFromLoginPage;
@synthesize indv_loader;
//@synthesize dialog;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		
		if (kGetSessionProxy) {
			
			_session = [[FBSession sessionForApplication:kApiKey getSessionProxy:kGetSessionProxy
												delegate:self] retain];
		} else {
			
			_session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
		}
		
    }
	
    return self;
}

//implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	//[self.view setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"loginbg1.png"]]];
	self.title = @"Facebook";
	//self.view.backgroundColor = [UIColor lightGrayColor];
	self.loaderView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
	[self.view addSubview:self.loaderView];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleBordered target:self action:@selector(publishFeed:) ] autorelease];
	[self.navigationItem.rightBarButtonItem setEnabled:NO];
		
	if(![_session resume]) {
		
		[self.loaderView removeFromSuperview];
		btn_login.tag=0;
		[btn_login setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"login_btnfb" ofType:@"png"]] forState:UIControlStateNormal];
		lbl_LoginName.text=@"Login to Facebook";
		lbl_FooterText.text=@"Login to your Facebook Account here to share Ga2oo App with your facebook friends from your iPhone";
		
	}else{
		
		btn_login.tag=1;
		[btn_login setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logout_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[self.navigationItem.rightBarButtonItem setEnabled:YES];
		if(_session.sessionKey)
		{
			NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
			[userDefaults setObject:_session.sessionKey forKey:@"facebok_SessionKey"];
			[userDefaults synchronize];
		}
	}	
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden = NO;
	
	[[self.navigationController navigationBar] setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
	
	self.navigationController.navigationBarHidden = YES;
	
	[[self.navigationController navigationBar] setHidden:YES];
}



-(void)back:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btn_LogingOnClick:(id)sender
{
	
	switch ([sender tag]) {
		case 0:
			[self show_logingDialog];
			break;
		case 1:
			[self manageLoginLogoutButton];
			break;
		default:
			break;
	}
	
}

-(void)manageLoginLogoutButton
{
	/* btn_login.tag=0;
	lbl_LoginName.text=@"Login to Facebook";
	lbl_FooterText.text=@"Login to your Facebook Account here to share iVoucher app with your facebook friends from your iPhone";
	[btn_login setTitle:@"Login" forState:UIControlStateNormal];*/
	
	[self.view addSubview:self.loaderView];
	[_session logout];	
	
}

-(void)show_logingDialog
{
	FBLoginDialog *dialog = [[[FBLoginDialog alloc] initWithSession:_session] autorelease];
	dialog.delegate = self;
	[dialog show];
	self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{

}

- (void)sessionDidNotLogin:(FBSession*)session {
	
	[self.navigationController popViewControllerAnimated:YES];
	self.navigationController.navigationBar.userInteractionEnabled = YES;
}


- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	
	indv_loader =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(145, 160, 30, 30)];
	indv_loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	indv_loader.hidesWhenStopped =YES;
	[self.view addSubview:indv_loader];
	//if(btn_login.tag == 0)
	[indv_loader startAnimating];
	
	[self.navigationItem.rightBarButtonItem setEnabled:YES];
	[self.loaderView removeFromSuperview];
	if(_session.sessionKey)
	{
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:_session.sessionKey forKey:@"facebok_SessionKey"];
		[userDefaults synchronize];
	}
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	permissionStatusForUser = [[PermissionStatus alloc] initWithUserId:uid];
	permissionStatusForUser.delegate = self;
	
	[self getUserName:[NSString stringWithFormat:@"%lld",uid]];	
}



- (void)getUserName:(NSString *)uid {
	
	NSString* fql = [NSString stringWithFormat:@"select first_name, last_name, name, sex, hometown_location, email from user where uid == %@",uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

- (void)request:(FBRequest*)request didLoad:(id)result {
	
	NSArray* users = result;
	NSDictionary* user = [users objectAtIndex:0];
	NSString* name = [user objectForKey:@"first_name"];
	
	self.str_FaceBookUserName = name;
	
	if(!isFromLoginPage)
	{
		lbl_LoginName.text=[NSString stringWithFormat:@"Logged in as %@",name];
		lbl_FooterText.text=@"Your account will remain logged in until you click the Logout button above";
		btn_login.tag=1;
		[btn_login setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logout_btn" ofType:@"png"]] forState:UIControlStateNormal];
	}
	else {
		[indv_loader stopAnimating];
		[indv_loader release];
	}
}


- (void)publishFeed:(id)target {
	
	[self.navigationItem.rightBarButtonItem setEnabled:NO];
	NSString *strCaption= @"";
	NSString *strDesc=@"";
	if(![objTemp.name isEqualToString:@"(null)"])
	{
		strDesc=[NSString stringWithFormat:@"Description: %@", objTemp.name];
	}
	else {
		
		strDesc=@"";
	}
	if(![objTemp.name isEqualToString:@"(null)"])
	{
		storyTitle = objTemp.name;
	}
	else {
		storyTitle = @"";
	}

	FBStreamDialog* dialog1 = [[[FBStreamDialog alloc] init] autorelease];
	dialog1.delegate = self;
	dialog1.userMessagePrompt = @"Write your comment here";
	dialog1.attachment =[NSString stringWithFormat:@"{\"name\":\"%@\",\"href\":\"ga2oo\",\"caption\":\"%@\",\"description\":\"%@\",\"properties\":{\"Website:\":{\"text\":\"Ga2oo\",\"href\":\"ga2oo\"}}}",storyTitle,strCaption,strDesc];
	[dialog1 show];
	self.navigationController.navigationBar.userInteractionEnabled = NO;
}

#pragma mark RAD PermissionStatusDelegate

- (void)statusWasSet:(BOOL)status {
	
	if(!status){
		
		FBPermissionDialog* Permissiondialog = [[[FBPermissionDialog alloc] init] autorelease];
		Permissiondialog.delegate = self;
		Permissiondialog.permission = @"publish_stream";
		[Permissiondialog show];	
	}
	
	[permissionStatusForUser release];
}

- (void)sessionDidLogout:(FBSession*)session {	
	
	[self.navigationItem.rightBarButtonItem setEnabled:NO];
	[self.loaderView removeFromSuperview];
	if(!_session.sessionKey)
	{
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:nil forKey:@"facebok_SessionKey"];
		[userDefaults synchronize];
	}
	
	btn_login.tag=0;
	lbl_LoginName.text=@"Login to Facebook";
	lbl_FooterText.text=@"Login to your Facebook Account here to share ga2oo with your facebook friends from your iPhone";
	//[btn_login setTitle:@"Login" forState:UIControlStateNormal];
	[btn_login setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"login_btnfb" ofType:@"png"]] forState:UIControlStateNormal];
	self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)dialogDidCancel:(FBDialog*)dialog {
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	[self.navigationController.navigationItem.rightBarButtonItem setEnabled:YES];
	[self.navigationController.navigationItem.leftBarButtonItem setEnabled:YES];
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (void)dialogDidSucceed:(FBDialog*)dialog {
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	[self.navigationController popViewControllerAnimated:YES];
	
}

-(IBAction)logoutFromFacebook:(id)sender{
	
	[_session logout];	
	
}

-(void)setUsersStatus { 
	
	NSString *statusString = @"";
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: statusString, @"status", @"true", @"status_includes_verb", nil]; 
	[[FBRequest requestWithDelegate:self] call:@"facebook.Users.setStatus" params:params];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	//NSLog(@"facebookViewController");
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self.navigationController.navigationBar setUserInteractionEnabled:YES];
	[self.navigationItem.rightBarButtonItem setEnabled:YES];
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	//[dialog dismissWithSuccess:YES animated:YES];
	for(UIView *v in [self.navigationController.navigationBar subviews])
	{
		if(v.tag != 1122 && v.tag != 1123)
			[v removeFromSuperview];
		
	}
	[self.navigationController.navigationBar setUserInteractionEnabled:YES];
	[self.navigationItem.rightBarButtonItem setEnabled:YES];
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
}

- (void)dealloc {
	
	[indv_loader release];
	permissionStatusForUser.delegate = nil;
	[btn_login release],btn_login = nil;
	[str_FaceBookUserName release],str_FaceBookUserName = nil;
	[lbl_LoginName release],lbl_LoginName = nil;
	[lbl_FooterText release],lbl_FooterText = nil;
	[_session release],_session = nil;
    [super dealloc];
}


@end
