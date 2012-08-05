//
//  EventMapViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventMapViewController.h"


@implementation EventMapViewController
@synthesize objEventLocation;
@synthesize mapView;
@synthesize objLoc;
@synthesize objEventListMap;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self setBackgroundImageToView:self.view];
	[self setTopBarImageToEventDetailView:self.view];
	
	UILabel *lblHead = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 188, 45)];
	lblHead.text = @"Event Details";
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
	
	self.mapView=[[MKMapView alloc] initWithFrame:CGRectMake(0,44, 320, 368)];
	self.mapView.mapType=MKMapTypeStandard;
	self.mapView.delegate=self;
	[self.view addSubview:self.mapView];
	
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	
	span.latitudeDelta=1.0;
	span.longitudeDelta=1.0;

	CLLocationCoordinate2D location = mapView.userLocation.coordinate; 

	NSString *strLatitude = @"40.759255";
	NSString *strLongitude = @"73.923181";
	
	NSArray *arrLocation = [objEventListMap.geocode componentsSeparatedByString:@","];
	if([arrLocation count])
	{
		strLatitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:0]];
		strLongitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:1]];
		
		location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
		location.longitude =[strLongitude floatValue];// [obj_store.strLongitude floatValue];
		
		ParkPlaceMark *placemark=[[ParkPlaceMark alloc] initWithCoordinate:location  title:[objEventListMap.name length]?objEventListMap.name:@"" subtitle:[NSString stringWithFormat:@"%@,%@,%@",objEventListMap.address,objEventListMap.city,objEventListMap.country]];
		[self.mapView addAnnotation:placemark];
		[placemark release];
		
		region.span=span;
		region.center=location;
		
		[self.mapView setRegion:region animated:TRUE];
		[self.mapView regionThatFits:region];
		
	}
	else 
	{
		
		location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
		location.longitude =[strLongitude floatValue];
		
		self.mapView.showsUserLocation = YES;
        
        /*region.span=span;
		region.center=self.mapView.userLocation.coordinate;
		
		[self.mapView setRegion:region animated:TRUE];
		[self.mapView regionThatFits:region];*/

	}
	

		
	 // ajit
}

#pragma mark UIButton Methods

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

#pragma mark MApView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView1 viewForAnnotation:(id <MKAnnotation>)annotation
{
	//	ParkPlaceMark *obj_parkplacemark1 = (ParkPlaceMark *)annotation;
	MKPinAnnotationView *annView = (MKPinAnnotationView *) [mapView1 dequeueReusableAnnotationViewWithIdentifier: @"asdf"];
	if (annView == nil) {
		annView = [[[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"asdf"] autorelease];
	} else {
		annView.annotation = annotation;
	}
	
	annView.animatesDrop = NO;
	annView.userInteractionEnabled = YES;
	annView.canShowCallout = YES;
	annView.pinColor = MKPinAnnotationColorRed;
	
	if([mapView1 userLocation] == annotation)
	{
		annView=nil;
	}
	
    return annView;
}

- (void)mapView:(MKMapView *)mapView1 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	// DO SOMETHING.....
	
}

- (void)mapView:(MKMapView *)mapView1 didAddAnnotationViews:(NSArray *)views
{
	
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView1 withError:(NSError *)error {
	
	NSLog(@"%@", [error description]);	
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
	
 	self.mapView.delegate = nil;
	[self.mapView release];
    [super dealloc];
}


@end
