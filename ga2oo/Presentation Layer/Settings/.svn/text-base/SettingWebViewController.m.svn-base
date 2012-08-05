//
//  SettingWebViewController.m
//  Ga2oo
//
//  Created by SaiKrishna on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingWebViewController.h"


@implementation SettingWebViewController

@synthesize selected;
@synthesize lbl_Title;

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
	if(self.selected==1)
	{
		self.lbl_Title.text=@"About";
	}
	else if(self.selected==2)
	{
		self.lbl_Title.text=@"F.A.Q";
	}
	
	[self ShowWebView];
}


-(IBAction)btn_BackAction
{
	[self.navigationController popViewControllerAnimated:YES];
	
}


-(void)ShowWebView
{
	NSString *html=nil;
	
	if(self.selected==1)
	{
		self.lbl_Title.text=@"About";
		html = [NSString stringWithFormat:@"<html><body>%@</body></html>",@"ga2oo version 1 is a particular implementation of ga2oo mobile product on iOS platform.  "];  
	}
	else if(self.selected==2)
	{
		self.lbl_Title.text=@"F.A.Q";
		html = [NSString stringWithFormat:@"<html><body>%@</body></html>",@"There are NO F.A.Qs"];  

	}
	web.backgroundColor = [UIColor clearColor]; 
	[web loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
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
	[lbl_Title release];
	[web release];
    [super dealloc];
}


@end
