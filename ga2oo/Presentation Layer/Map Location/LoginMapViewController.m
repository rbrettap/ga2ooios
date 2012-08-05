


//  Created by win it on 3/24/10.
//  Copyright 2010 winit. All rights reserved.
//

#import "LoginMapViewController.h"
#import "Ga2ooAppDelegate.h"
#import "ParkPlaceMark.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
#import "ServiceOutput.h"
#import "XMLLatLang.h"

static int intpin;
@implementation LoginMapViewController
@synthesize locationManger;
@synthesize currentLocation;
@synthesize reversegeocoder;
@synthesize mapView;
@synthesize MyPlaceMark;
@synthesize _annotations;
@synthesize Search;
@synthesize latitude;
@synthesize longitude;
@synthesize zip;
@synthesize BtnSave;
@synthesize strDragedPlace;
@synthesize SelectedLocation;
@synthesize objUserLoc;
@synthesize userLocationForZip;

BOOL status;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        // Custom initialization
//    }
//    return self;
//}

-(void)showLoader{
	loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:loader];
	[self.view bringSubviewToFront:loader];
	loader.frame = CGRectMake(140, 200, 35, 35);
	[loader startAnimating];
}

-(void)hideLoader{
	[loader stopAnimating];
	[loader release];
	loader=nil;
}

-(IBAction) back_TouchUpInside
{
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate=(Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
 	objUser = [[UserLocationBL alloc] init];
	objUser.delegate = self;
	
	appDelegate.pinChanged = NO;
	
	mapView.showsUserLocation = NO;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
	self.strDragedPlace = @"";
	
	self._annotations = [[NSMutableSet alloc] initWithCapacity:1];
	
	
	mapView.mapType=MKMapTypeStandard;
	
	self.objUserLoc = [[UserLocationBO alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(_coordinateChanged:)
												 name:@"DDAnnotationCoordinateDidChangeNotification" 
											   object:nil];
	
	if (userLocationForZip)
	{
		self.objUserLoc = userLocationForZip;
		
		[self ShowSelectedLocation];
	}
	else 
	{
	  [self mapFind];
	}
}

-(void)ShowSelectedLocation
{
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.02;
	span.longitudeDelta=0.02;
	
	CLLocationCoordinate2D location ;
	
	NSString *strLatitude = @"40.759255";
	NSString *strLongitude = @"73.923181";
	
	self.objUserLoc.IsPrimary = @"True";
	
	NSArray *arrLocation = [self.objUserLoc.GeoPoint componentsSeparatedByString:@","];
	if([arrLocation count] >= 2)
	{
		strLatitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:1]];
		strLongitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:0]];
 		location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
		location.longitude =[strLongitude floatValue];//
 		self.objUserLoc.GeoPoint = [NSString stringWithFormat:@"%lf,%lf",location.latitude,location.longitude];
	}
	else{
        
        location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
        location.longitude =[strLongitude floatValue];//
        
    }
	
	
	
	region.span=span;
	region.center=location;
	DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:location addressDictionary:nil];
	annotation.title = @"Drag to move Pin";
    
    NSString *strLocation=@"";
    if ([self.objUserLoc.Address length]) {
        strLocation = [strLocation stringByAppendingString:self.objUserLoc.Address];
    }
    if ([self.objUserLoc.City length] && [strLocation length]) {
        strLocation = [strLocation stringByAppendingFormat:@",%@",self.objUserLoc.City];
    }
    else if ([self.objUserLoc.City length]){
        strLocation = [strLocation stringByAppendingString:self.objUserLoc.City];
    }
    
    if ([self.objUserLoc.Country length] && [strLocation length]) {
        strLocation = [strLocation stringByAppendingFormat:@",%@",self.objUserLoc.Country];
    }
    else if ([self.objUserLoc.Country length]){
        strLocation = [strLocation stringByAppendingString:self.objUserLoc.Country];
    }
    
	annotation.subtitle = strLocation;
	[self._annotations addObject:annotation];
	[self.mapView addAnnotation:annotation];
	[annotation release];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
}

-(void)mapFind
{
	
 
 	self.locationManger=[[CLLocationManager alloc]init];
 	self.locationManger.delegate=self;
 	locationManger.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
 	[locationManger startUpdatingLocation];
	
	/*if (self.reversegeocoder) {
		[self.reversegeocoder cancel];
		self.reversegeocoder.delegate = nil;
		self.reversegeocoder = nil;
	}
	
	// Note: If you lookup too many times within a very short of period, you might get error from Apple/Google.
	// e.g."/SourceCache/ProtocolBuffer/ProtocolBuffer-19/Runtime/PBRequester.m:446 server returned error: 503"
	// So you should avoid doing this in your code. This is just a demostration about how to reverse geocoding.
	self.reversegeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:locationManger.location.coordinate];
	self.reversegeocoder.delegate = self;
	[self.reversegeocoder start];	*/
	
}


-(void)viewWillAppear:(BOOL)animated{
	intpin = 1;
    BtnSave.userInteractionEnabled = YES;
}

-(void)_coordinateChanged:(NSNotification *)notification {
	
	/*status = YES;
	DDAnnotation *annotation = notification.object;
	
	if (self.reversegeocoder) {
		[self.reversegeocoder cancel];
		self.reversegeocoder.delegate = nil;
		self.reversegeocoder = nil;
	}
	
	// Note: If you lookup too many times within a very short of period, you might get error from Apple/Google.
	// e.g."/SourceCache/ProtocolBuffer/ProtocolBuffer-19/Runtime/PBRequester.m:446 server returned error: 503"
	// So you should avoid doing this in your code. This is just a demostration about how to reverse geocoding.
	self.reversegeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:annotation.coordinate];
	self.reversegeocoder.delegate = self;
	[self.reversegeocoder start];*/
	
	DDAnnotation *annotation = notification.object;
	
	NSString *NewLatLon = [NSString stringWithFormat:@"%lf,%lf",annotation.coordinate.latitude,annotation.coordinate.longitude];
	
    [self addressLocation:NewLatLon];
    
    
    
    CLLocationCoordinate2D location ;
    
    NSString *strLatitude = @"40.759255";
    NSString *strLongitude = @"73.923181";
    
    NSArray *arrLocation = [self.objUserLoc.GeoPoint componentsSeparatedByString:@","];
    if([arrLocation count] >= 2)
    {
        strLatitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:1]];
        strLongitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:0]];
        
        location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
        location.longitude =[strLongitude floatValue];//
        
        self.objUserLoc.GeoPoint = [NSString stringWithFormat:@"%lf,%lf",location.latitude,location.longitude];
    }
    else{
        
        location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
        location.longitude =[strLongitude floatValue];//
        
    }
    
    
    for (DDAnnotation *annotation2 in _annotations) {
		//if (annotation2.coordinate.latitude == location.latitude && annotation2.coordinate.longitude == location.longitude) {
			annotation2.subtitle = self.objUserLoc.Address ;
			
		//}
	}
    

    
   
	
	
	
}

-(void)_coordinateChanged1:(CLLocation *)Location {
	
	if (self.reversegeocoder) {
		[self.reversegeocoder cancel];
		self.reversegeocoder.delegate = nil;
		self.reversegeocoder = nil;
	}
	
	// Note: If you lookup too many times within a very short of period, you might get error from Apple/Google.
	// e.g."/SourceCache/ProtocolBuffer/ProtocolBuffer-19/Runtime/PBRequester.m:446 server returned error: 503"
	// So you should avoid doing this in your code. This is just a demostration about how to reverse geocoding.
	self.reversegeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:Location.coordinate];
	self.reversegeocoder.delegate = self;
	[self.reversegeocoder start];	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	[self hideLoader];
	
	[manager stopUpdatingLocation];
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Unable to update location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	
	[locationManger stopUpdatingLocation];
	
	double currentLong = newLocation.coordinate.longitude;
	double currentLatt = newLocation.coordinate.latitude;
	//SelectedLocation = [self getCurrentLocationFromLong:currentLong Lattitude:currentLatt];
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	CLLocationCoordinate2D location=newLocation.coordinate;

	NSString *NewLatLon = [NSString stringWithFormat:@"%lf,%lf",currentLatt,currentLong];
	
    [self addressLocation:NewLatLon];
	
    
    NSString *strLatitude = @"40.759255";
    NSString *strLongitude = @"73.923181";
    
    NSArray *arrLocation = [self.objUserLoc.GeoPoint componentsSeparatedByString:@","];
    if([arrLocation count]>=2)
    {
        strLatitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:1]];
        strLongitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:0]];
        
        location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
        location.longitude =[strLongitude floatValue];//
        
        self.objUserLoc.GeoPoint = [NSString stringWithFormat:@"%lf,%lf",location.latitude,location.longitude];
    }
    else{
        
        location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
        location.longitude =[strLongitude floatValue];//

    }
    
    
    
    region.span=span;
    region.center=location;
    DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:location addressDictionary:nil];
    annotation.title = @"Drag to move Pin";
    annotation.subtitle = self.objUserLoc.Address;
    [self._annotations addObject:annotation];
    [self.mapView addAnnotation:annotation];
    [annotation release];
    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
	
	
	
	
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	for (DDAnnotation *annotation in _annotations) {
		if (annotation.coordinate.latitude == geocoder.coordinate.latitude && annotation.coordinate.longitude == geocoder.coordinate.longitude) {
			annotation.subtitle = nil;
		}
	}
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	
	
	for (DDAnnotation *annotation in _annotations) {
		if (annotation.coordinate.latitude == geocoder.coordinate.latitude && annotation.coordinate.longitude == geocoder.coordinate.longitude) {
			annotation.subtitle = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
			//NSDictionary *dict =  placemark.addressDictionary;
//			NSArray *arr = [dict allKeys];
//						NSArray *arr1 = [dict allValues];
//						NSArray *arr2 = [dict allKeys];
		}
	}

	
	
	double currentLong = placemark.coordinate.longitude;
	double currentLatt = placemark.coordinate.latitude;
	//SelectedLocation = [self getCurrentLocationFromLong:currentLong Lattitude:currentLatt];
	NSString *strZip = [placemark.addressDictionary valueForKey:@"ZIP"];
	NSString *strLocality = [placemark.addressDictionary valueForKey:@"Street"];
	NSString *strCity = [placemark.addressDictionary valueForKey:@"City"];
	NSString *strState = [placemark.addressDictionary valueForKey:@"State"];
	NSString *strCountry = [placemark.addressDictionary valueForKey:@"Country"];

 	if (objUserLoc) {
		[objUserLoc release];
		objUserLoc = nil;
	}
	objUserLoc = [[UserLocationBO alloc] init];
	
	if(currentLong)
		objUserLoc.GeoPoint = [NSString stringWithFormat:@"%f,%f",currentLatt, currentLong];
	else
		objUserLoc.GeoPoint = @"None";
	
	if([strLocality length])
		objUserLoc.Address = strLocality;
	else
		objUserLoc.Address = @"None";
	
	if([strCity length])
		objUserLoc.City = strCity;
	else
	{
		
			objUserLoc.City = @"None";	
	}
	
	if([strState length])
		objUserLoc.State = strState;
	else
		objUserLoc.State = @"None";

	if([strCountry length])
		objUserLoc.Country = strCountry;
	else
		objUserLoc.Country = @"None";
	
	if([strZip length])
		objUserLoc.Zipcode = strZip;
	else
		objUserLoc.Zipcode = @"None";
 	 	
 	objUserLoc.IsPrimary = @"True";

 }


- (MKAnnotationView *) mapView:(MKMapView *)mapView1 viewForAnnotation:(id <MKAnnotation>) annotation{
	
	DDAnnotationView *annotationView = (DDAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
	if (annotation != self.mapView.userLocation) {	
		if (annotationView == nil) {
			annotationView = [[[DDAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"] autorelease];
		}
		annotationView.mapView = mapView;
	}
	return annotationView;
}

-(NSString *) getCurrentLocationFromLong:(double)Long Lattitude:(double)Latt{
	NSLog(@"%lf",Long);
	NSLog(@"%lf",Latt);
	NSLog(@" Latitude = %s  Longitude = %s",[NSString stringWithFormat:@"%.7f",Latt],[NSString stringWithFormat:@"%.7f",Long]);
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%lf,%lf&output=csv&sensor=false",Latt,Long];
	NSURL *urlFromString = [NSURL URLWithString:urlString];
	NSStringEncoding encodingType = NSUTF8StringEncoding;
	NSMutableString *reverseGeoString =[NSString stringWithContentsOfURL:urlFromString encoding:encodingType error:nil];
	NSArray *arrList = [reverseGeoString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
	if([arrList count]>1)
		reverseGeoString = [arrList objectAtIndex:1];
	(@"%@",reverseGeoString);
	return reverseGeoString;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

/*
 //Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void) addressLocation:(NSString *)SearchValue {
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=xml", [SearchValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSError *parseError = nil;
    XMLLatLang *streamingParser = [[XMLLatLang alloc]init];
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
	self.objUserLoc = [streamingParser parseXMLFileAtURL:[NSURL URLWithString:urlString] parseError:&parseError];
    
	self.objUserLoc.IsPrimary = @"True";
	
    [streamingParser release]; 

}

-(IBAction)Savelocation{
	
    BtnSave.userInteractionEnabled = NO;
	NSLog(@"%@",self.strDragedPlace);
	
	NSLog(@"self.objUserLoc city %@ %i",self.objUserLoc.City,[self.objUserLoc.City length]);
    NSLog(@"self.objUserLoc country %@",self.objUserLoc.Country);
	
    if(![self.objUserLoc.City length])
    {
      if([self.objUserLoc.State length])
      {
          self.objUserLoc.City = self.objUserLoc.State;
      }
      else 
      {
       self.objUserLoc.City = @"None";
          self.objUserLoc.State = @"None";

      }
    }
    
    if(![self.objUserLoc.Zipcode length])
    {
      self.objUserLoc.Zipcode = @"None";
    }

	[objUser saveTheLocationInServerForLocation:self.objUserLoc];
	
	
/*
	UserLocationBL *UserLocLayer = [[UserLocationBL alloc]init];
	UserLocLayer.delegate = self;
	 NSMutableArray *arrUserProfile = [UserLocLayer SelectAll];
	
	UserLocationBO *objuserLoc = [[UserLocationBO alloc]init];// [arrUserProfile objectAtIndex:indexPath.row];
objuserLoc.Address = 
	
	for(int i = 0; i<[arrUserProfile count]; i++)
	{
		UserLocationBO *obj = [arrUserProfile objectAtIndex:i];
		obj.IsPrimary = @"None";
		[UserLocLayer Update:obj withSave:YES];			
	}
	objuserLoc.IsPrimary = @"True";
	[UserLocLayer Update:objuserLoc withSave:YES];		
	*/
}

-(IBAction)back{
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark searchBar delegate methods
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
	
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	BtnSave.enabled = NO;
	Search.showsCancelButton = YES;
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
	
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[Search resignFirstResponder];
	BtnSave.enabled = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	//Hide the keypad
	appDelegate.pinChanged = NO;
	self.locationManger.delegate=nil;
	[self showLoader];
	[Search resignFirstResponder];
	mapView.showsUserLocation = NO;

	Search.text = [Search.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([Search.text length]) {
		for (int i = 0; i < [mapView.annotations count]; i++)
		{ 
			if ([[mapView.annotations objectAtIndex:i] isKindOfClass:[DDAnnotation class]])
			{ 
				[mapView removeAnnotation:[mapView.annotations objectAtIndex:i]]; 
			} 
		}
		
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta=0.02;
		span.longitudeDelta=0.02;
		
		[self addressLocation:Search.text];
		
		CLLocationCoordinate2D location ;
		
		NSString *strLatitude = @"40.759255";
		NSString *strLongitude = @"73.923181";
		
		NSArray *arrLocation = [self.objUserLoc.GeoPoint componentsSeparatedByString:@","];
		if([arrLocation count] >=2 )
		{
            
            if ([arrLocation objectAtIndex:1]) {
                strLatitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:1]];

            }
            if ([arrLocation objectAtIndex:0]) {
                strLongitude = [NSString stringWithFormat:@"%@", [arrLocation objectAtIndex:0]];
                
            }
			
			location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
			location.longitude =[strLongitude floatValue];//
			
			self.objUserLoc.GeoPoint = [NSString stringWithFormat:@"%lf,%lf",location.latitude,location.longitude];
		}
		else{
            
            location.latitude =[strLatitude floatValue];// [obj_store.strLatitude floatValue];
            location.longitude =[strLongitude floatValue];//
            
        }
		
			
		 
		region.span=span;
		region.center=location;
		DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:location addressDictionary:nil];
		annotation.title = @"Drag to move Pin";
		annotation.subtitle = [self.objUserLoc.Address stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
		[self._annotations addObject:annotation];
		[self.mapView addAnnotation:annotation];
		[annotation release];
		
		[mapView setRegion:region animated:TRUE];
		[mapView regionThatFits:region];
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"DDAnnotationCoordinateDidChangeNotification" object:annotation];
		[self hideLoader];
	}
	else {
		[self hideLoader];
	}
	
	BtnSave.enabled = YES;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	BtnSave.enabled = NO;
	Search.showsCancelButton = YES;
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
	BtnSave.enabled = NO;
	Search.showsCancelButton = NO;
	return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	BtnSave.enabled = NO;
	Search.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
	BtnSave.enabled = NO;
	Search.showsCancelButton = NO;
}

- (void) searchTableView {
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(alertView.tag == 99)
	{
		if(buttonIndex==0)
			[self.navigationController popViewControllerAnimated:YES];
	}
	else if(alertView.tag == 999)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	else if(alertView.tag == 876)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}


-(void)ServiceRequestCompleted:(ServiceOutput *)Object
{
	
	
	// Object is not saved 
	if([Object.responseStringfromWeb length])
	{
		if([Object.responseStringfromWeb isEqualToString:@"-1"])
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"An error occured while adding your location, please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
		}
		else if([Object.responseStringfromWeb isEqualToString:@"-2"])
		{
			UIAlertView *alertTimedout = [[UIAlertView alloc] initWithTitle:nil message:@"This username already exists, please enter another username." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertTimedout show];
			[alertTimedout release];
			
 		}
		else {
  			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Selected location has been saved successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			alert.tag = 876;
			[alert release];
			
			self.objUserLoc.LocationId = Object.responseStringfromWeb;
			[objUser Insert:self.objUserLoc withSave:YES];

		}
	}
	else {
 		UIAlertView *alertEnterPw = [[UIAlertView alloc] initWithTitle:nil message:@"Error." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertEnterPw show];
		[alertEnterPw release];	
	}
	
}


-(void) viewWillDisappear:(BOOL)animated
{
	//[self Savelocation];
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
//	self.mapView.delegate=nil;
//	self.mapView=nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	
	objUser.delegate = nil;
	[objUser release];
	[[NSNotificationCenter defaultCenter] removeObserver:self]; 
	for (DDAnnotation *annotation in _annotations) {
		[mapView removeAnnotation:annotation];
		[annotation release];
	}
	mapView.delegate=nil;
	[mapView release];
	mapView=nil;
	[_annotations release];
	_annotations=nil;
	
	if(locationManger)
	{
	locationManger.delegate=nil;
	[locationManger release];
	locationManger=nil;
	}
	Search = nil;
	zip = nil;
	latitude = nil;
	longitude = nil;
	[reversegeocoder release];
	[Search release];
	[BtnSave release];
    [super dealloc];
}

@end



