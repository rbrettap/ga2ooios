    //
//  BaseViewController.m
//  Alhilal
//
//  Created by winit on 04/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "Ga2ooAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation BaseViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(void)showNavigationBar
{
	self.navigationController.navigationBarHidden = NO; 
}

-(void)setBackgroundImageToView:(UIView *)temp
{
	NSString *strimgname = nil;
	strimgname = @"mainbg";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 44, 320, 456);
	imgv.tag = 7777;
	[temp addSubview:imgv];
	[temp sendSubviewToBack:imgv];
	[imgv release];
	imgv = nil;
}

-(void)setTopBarImageToView:(UIView *)temp
{
	NSString *strimgname = nil;
	strimgname = @"topbarGa2oo";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 0, 320, 44);
	imgv.tag = 7777;
	[temp addSubview:imgv];
	[temp sendSubviewToBack:imgv];

	UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(246, 6, 69, 31)];
	[btnBack addTarget:self action:@selector(logoutBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
	btnBack.backgroundColor = [UIColor clearColor];
	[btnBack setImage:[UIImage imageNamed:@"logoff_bt.png"] forState:UIControlStateNormal];
	[temp addSubview:btnBack];
	[btnBack release];
	
	[imgv release];
	imgv = nil;
}



-(void)setTopBarImageToEventDetailView:(UIView *)temp
{
	NSString *strimgname = nil;
	strimgname = @"top_bar";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 0, 320, 44);
	imgv.tag = 7777;
	[temp addSubview:imgv];
	[temp sendSubviewToBack:imgv];
	
	UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(246, 6, 69, 31)];
	[btnBack addTarget:self action:@selector(logoutBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
	btnBack.backgroundColor = [UIColor clearColor];
	[btnBack setImage:[UIImage imageNamed:@"logoff_bt.png"] forState:UIControlStateNormal];
	[temp addSubview:btnBack];
	[btnBack release];
		
	[imgv release];
	imgv = nil;
}




-(void)setTopBarImageToViewWithHome:(UIView *)temp
{
	NSString *strimgname = nil;
	strimgname = @"topbarGa2oo";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 0, 320, 44);
	imgv.tag = 7777;
	[temp addSubview:imgv];
	
	UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(246, 6, 69, 31)];
	[btnBack addTarget:self action:@selector(logoutBtn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
	btnBack.backgroundColor = [UIColor clearColor];
	[btnBack setImage:[UIImage imageNamed:@"logoff_bt.png"] forState:UIControlStateNormal];
	[temp addSubview:btnBack];
	[btnBack release];
	[imgv release];
	imgv = nil;
}

-(void)setTopBarImageToViewWithSignUp:(UIView *)temp
{
	NSString *strimgname = nil;
	strimgname = @"top_bar";
	UIImageView *imgv= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strimgname ofType:@"png"]]];
	imgv.frame = CGRectMake(0, 20, 320, 44);
	imgv.tag = 7777;
	[temp addSubview:imgv];
	
	UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 130, 45)];
	lblTitle.backgroundColor = [UIColor clearColor];
	lblTitle.font = [UIFont boldSystemFontOfSize:19];
	lblTitle.textAlignment = UITextAlignmentCenter;
	lblTitle.textColor = [UIColor whiteColor];
	lblTitle.text = @"ga2oo sign up";
	[temp addSubview:lblTitle];
	[lblTitle release];
	
	[imgv release];
	imgv = nil;
}

-(void)setlogoutbtnToNavController:(UINavigationController *)navcon 
{
	navcon.navigationBar.barStyle = UIBarStyleDefault;
	UIBarButtonItem *barLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered 
																 target:self action:@selector(logoutBtn_Clicked)];
	//self.navigationItem.rightBarButtonItem = barLogout;
	[barLogout release];
}

-(void) loadAnimation
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

-(void) removeSyncLoader
{
	if([self.view viewWithTag:82])
	{
		[[self.view viewWithTag:82] removeFromSuperview];
	}
	self.view.userInteractionEnabled = YES;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
