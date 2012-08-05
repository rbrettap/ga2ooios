//
//  ContactViewController.m
//  Ga2oo
//
//  Created by SaiKrishna on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactViewController.h"


@implementation ContactViewController
@synthesize web;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self addScrllView];
	
	lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 21)];
	lbl1.backgroundColor=[UIColor clearColor];
	lbl1.text=@"For more Information";
	lbl1.font = [UIFont boldSystemFontOfSize:16];
	lbl1.textColor = [UIColor darkGrayColor];
	[scrlView addSubview:lbl1];
	
	
	lbl_Phone=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 300, 21)];
	lbl_Phone.backgroundColor=[UIColor clearColor];
	//lbl_Phone.text=@"Contact  :   040-65696367";
	[scrlView addSubview:lbl_Phone];
	[lbl_Phone release];
	
	[self ShowWebView];
}

-(void)ShowWebView
{
	NSString *html;

	html = [NSString stringWithFormat:@"<html><body><b>%@</b>%@</body></html>", @"Contact:",@"		040-65696367"];  

	web.opaque = NO;
	web.backgroundColor = [UIColor clearColor]; 
	[web loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
}


-(IBAction)btn_BackAction
{
	[self.navigationController popViewControllerAnimated:YES];
}


// Method Name: shouldStartLoadWithRequest
// Description: This method used for click on the web view.
// Input Parameters: request, request
// Return type: BOOL.

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		NSLog(@"%@", [request URL]);
		NSString *strUrl = [NSString stringWithFormat:@"%@",[request URL]];
		NSRange range =[strUrl rangeOfString:@"tel"];
		if(range.length)
		{
			NSLog(@"strUrl-----> %@", strUrl);
			if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strUrl]])
			{
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
			}
			else
			{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Sorry, your device does not have call facility." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
		}			
		return NO; // if you want to cancel the request, else YES
	}
	return YES;
}

-(void)addScrllView
{
	scrlView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 416)];
	scrlView.delegate=self;
	scrlView.backgroundColor=[UIColor  clearColor];
	scrlView.pagingEnabled=YES;
	scrlView.scrollEnabled=YES;
	scrlView.contentSize=CGSizeMake(320,450);
	[self.view addSubview:scrlView];
	
	web = [[UIWebView alloc] initWithFrame:CGRectMake(10, 45, 300, 460-90)];
	web.delegate = self;
	[scrlView addSubview:web];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[scrlView release];
	[lbl1 release];
	web.delegate = nil;
	[web release];
    [super dealloc];
}


@end
