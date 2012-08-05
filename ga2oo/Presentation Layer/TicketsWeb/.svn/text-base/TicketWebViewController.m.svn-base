//
//  TicketWebViewController.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "TicketWebViewController.h"


@implementation TicketWebViewController
@synthesize objEvent;

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
	[self setTopBarImageToEventDetailView:self.view];
	
	UILabel *lblHead = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 188, 45)];
	lblHead.text = @"Tickets";
	lblHead.textAlignment = UITextAlignmentCenter;
	lblHead.backgroundColor = [UIColor clearColor];
	lblHead.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
	lblHead.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
	[self.view addSubview:lblHead];
	[lblHead release];
	
	UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
	btnBack.frame = CGRectMake(5, 7, 51, 30);
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back_btnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnBack];
	NSLog(@"%@", self.objEvent.tickets);
	
	[self cretaeInterface];
}

-(void)cretaeInterface
{
	[self loadAnimation];
	aWebView.delegate=self;
	
	aUrl = [NSURL URLWithString:self.objEvent.tickets];
	NSURLRequest *aUrlRequest;
	aUrlRequest=[NSURLRequest requestWithURL:aUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:600.0];
	
	[aWebView loadRequest:aUrlRequest]; 
	aWebView.scalesPageToFit=YES;
}


#pragma mark WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	if(aWebView.canGoBack)backButton.enabled =YES;
	else backButton.enabled = NO;
	
	if(aWebView.canGoForward)forwardButton.enabled =YES;
	else forwardButton.enabled = NO;
	
	
	[self removeSyncLoader];
	[mainIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self removeSyncLoader];
	[mainIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[mainIndicator startAnimating];
}

#pragma mark -

#pragma mark webViewAction Methods

-(IBAction)backButtonPressed:(id)sender
{
	[aWebView goBack];
}
-(IBAction)forwardButtonPressed:(id)sender
{
	[aWebView goForward];
}
-(IBAction)refreshButtonPressed:(id)sender
{
	[aWebView reload];
}
-(IBAction)opensafariButtonPressed:(id)sender
{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"Would you like to open this website in Safari?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil]autorelease];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{
		NSURLRequest *currentRequest = [aWebView request];
		NSURL *currentURL = [currentRequest URL];
		[[UIApplication sharedApplication] openURL:currentURL];
	}
}

#pragma mark -

#pragma mark Button Action Methods

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
 
#pragma mark -

-(void)viewWillDisappear:(BOOL)animated
{
	[self removeSyncLoader];
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
	
	aWebView.delegate=nil;
	[aWebView stopLoading];
    [super dealloc];
}


@end
