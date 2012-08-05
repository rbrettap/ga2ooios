//
//  twitterViewController.m
//  RestaurantApp
//
//  Created by Basil.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "twitterViewController.h"
#import "Ga2ooAppDelegate.h"

@implementation twitterViewController
//@synthesize back_Btn;
@synthesize txtView;
@synthesize lblCounter;
@synthesize count;
@synthesize loaderVal;
@synthesize dataToBePublished, toolBar1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDataToBePublished:(NSString *)str{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		appDelegate = (SRC_Sports_WWCAppDelegate *)[[UIApplication sharedApplication] delegate];
		self.dataToBePublished=str;
		
    }
    return self;
}

-(IBAction)logout{
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:@"nil" forKey: @"authData"];
	[defaults synchronize];
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Twitter Post";
	
		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainbg.png"]];
	lblCounter.frame = CGRectMake(30, 135+49, 280, 20);
	lblCounter.textAlignment = UITextAlignmentRight;	
	lblCounter.font = [UIFont fontWithName:@"Knockout-HTF31-JuniorMiddlewt" size:17.0];	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1];

	NSString *str_AuthData = [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
	NSLog(@"%@",str_AuthData);
	if ([str_AuthData isEqualToString:@"nil"] || [str_AuthData isKindOfClass:[NSNull class]]|| str_AuthData.length == 0 )
	{
		lblCounter.hidden = YES;
		toolBar1.hidden = YES;
		txtView.hidden = YES;
		
		loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 320, 25)];
		lbl.textAlignment = UITextAlignmentCenter;
		//lbl.font = [UIFont fontWithName:@"Knockout-HTF31-JuniorMiddlewt" size:17.0];
		lbl.text = @"Page load connection...";
		lbl.backgroundColor = [UIColor clearColor];
		lbl.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
		[loaderView  addSubview:lbl];
        [lbl release];
		[self.view addSubview:loaderView];
	}
	else{
		[txtView becomeFirstResponder];
	}
	
	txtView.backgroundColor =[UIColor whiteColor];
	txtView.textColor =[UIColor blackColor];
	txtView.layer.cornerRadius =10.0;
	loaderVal = 0;
		
	UIButton *twitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	twitBtn.frame = CGRectMake(253, 4, 62, 32);
	[twitBtn addTarget:self action:@selector(post_btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[twitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"tweet"] ofType:@"png"]] forState:UIControlStateNormal];
	[self.view addSubview:twitBtn];
	
	UIBarButtonItem *temporaryBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:twitBtn];
	self.navigationItem.rightBarButtonItem = temporaryBarButtonItem2;
	[temporaryBarButtonItem2 release];
	
}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden = NO;

	if(loaderVal == 1)
	{
		[loaderView removeFromSuperview];
		loaderVal = 0;
	}
}

-(void)viewWillDisappear:(BOOL)animated
{
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {

	[self showLoginScreen];
	
	[self.txtView setText: [NSString stringWithFormat:@"%@",self.dataToBePublished]];
	
	NSInteger len = txtView.text.length - 140;
	if(len <= 0)
	{
		
		lblCounter.text = [NSString stringWithFormat:@"%d Characters left.",140-txtView.text.length ];
	}
	else
	{
		lblCounter.text = [NSString stringWithFormat:@"Exceed maximum character."];
	}
}

#pragma mark UITextViewDelegate

// This is call automaticully when user enter a charecter in text view of twitter message
- (void) textViewDidChange:(UITextView *)txtViewText{
	int len = txtView.text.length;
	
	int rest = 140 -len;
	if(rest >= 0)
	{
		NSString *str = [NSString stringWithFormat:@"%3d Characters left.",rest];
		lblCounter.text = str;
	}
	else
	{
		//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Maximum character exceeds." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		[alert show];
		//		[alert release];
		lblCounter.text = @"Exceed maximum character.";
	}
}

#pragma mark Action Methods

-(void)goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)showLoginScreen {

	if(_engine) return;
	
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
//SRC
//	_engine.consumerKey = @"TYDpSMPOpK5344yUZcZQ";
//	_engine.consumerSecret = @"nl61SFIrW9S7Psl6SgnL9oCN1gWnuel6C8sWQ3hLKE";

	//Raw Food
	_engine.consumerKey = TwitterConsumerKey;
	_engine.consumerSecret = TwitterConsumerSecret;

	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) 
	{
		loaderVal = 1;
		[self presentModalViewController:controller animated:YES];
	}
}



-(IBAction)updateStream:(id)sender {	
	[_engine getFollowedTimelineSinceID:1 startingAtPage:1 count:100];
}

-(void) post_btnClick:(id)sender
{	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	  
	NSString *str_postMessage = [txtView text];
	   if(str_postMessage.length > 140)
		str_postMessage = [str_postMessage substringToIndex:135];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		[_engine sendUpdate:str_postMessage];
		[self updateStream:nil];
		
		count = 0;
		
		progressAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"The display is in progress..." delegate: self cancelButtonTitle: nil otherButtonTitles: nil];
		
		UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		activityView.frame = CGRectMake(139.0-18.0, 85.0-20, 37.0, 37.0);
		[progressAlert addSubview:activityView];
		[activityView startAnimating];
		[progressAlert show];
        [activityView release];
	
}

#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
	
	
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	
	NSString *str_AuthData = [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
	NSLog(@"%@",str_AuthData);
	return str_AuthData;
}

#pragma mark SA_OAuthTwitterController Delegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	
		UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"Your login is successful Twitter." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 222;
		[alert show];
		[alert release];
		
	if(username==nil)
	{
	[self.navigationController popViewControllerAnimated:YES];
	}
	[txtView becomeFirstResponder];
	lblCounter.hidden = NO;
	txtView.hidden = NO;
	toolBar1.hidden = YES;
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	

		UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"Failed to connect to the Twitter account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self.navigationController popToRootViewControllerAnimated:YES];
		return;

	[self.navigationController popViewControllerAnimated:YES];
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	
	[loaderView removeFromSuperview];
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark MGTwitterEngineDelegate Methods

- (void)requestSucceeded:(NSString *)connectionIdentifier {
	
	NSLog(@"Request Suceeded: %@", connectionIdentifier);
	
}

- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier {
	
	count+=1;
			if(count == 2)
			{
				UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"Your message was successfully sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag =111;
				[alert show];
				[alert release];
				[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
				 
				//back_Btn.hidden = NO;
			}
	
	[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(removeLoadView) userInfo:nil repeats:NO];
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error {
	//UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"Failed to post the Message. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//	alert.tag =112;
//	[alert show];
//	[alert release];
	
	[self removeLoadView];
}
// 
-(void)removeLoadView
{
	[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)receivedObject:(NSDictionary *)dictionary forRequest:(NSString *)connectionIdentifier {
	
	NSLog(@"Recieved Object: %@", dictionary);
}

- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier {
	
	NSLog(@"Direct Messages Received: %@", messages);
}

- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier {
	
	NSLog(@"User Info Received: %@", userInfo);
}

- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier {
	
	NSLog(@"Misc Info Received: %@", miscInfo);
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

	if(alertView.tag==111){
		[txtView resignFirstResponder];
		[self.navigationController popViewControllerAnimated:YES];
		
	}
	else if(alertView.tag==222){
		
		toolBar1.hidden = NO;
	}
	
	//else if(alertView.tag== 112) {
//		
//	}

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[toolBar1 release];
	[txtView release];
	[lblCounter release];
    [super dealloc];
}


@end
