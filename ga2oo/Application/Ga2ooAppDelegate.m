//
//  Ga2ooAppDelegate.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Ga2ooAppDelegate.h"
#import "RegisterObject.h"
#import "EventsBL.h"
#import "BusinessTypeBL.h"
#import "BusinessBL.h"
#import "GlobalizationBL.h"
#import "EventCategoryBL.h"
#import "EventLocationBL.h"
#import "CategoryBL.h"
#import "EventImagesBL.h"
#import "EventVideosBL.h"
#import "UserBL.h"
#import "UserInboxBL.h"
#import "NotificationsBL.h"
#import "UserNotificationTypesBL.h"
#import "FriendsBL.h"
#import "UserEventsBL.h"
#import "UserLocationBL.h"
#import "UserAssociationBL.h"
#import "EventListBL.h"
#import "EventListBO.h"
#import "BusinessListBL.h"
#import <QuartzCore/QuartzCore.h>
#import "Ga2ooViewController.h"
#include "CalenderViewController.h"
#import "CalenderTabViewController.h"
#import "FriendsViewController.h"
#import "SettingNewViewController.h"

@implementation Ga2ooAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize pinChanged;
@synthesize arr_AllEvents;
@synthesize  arr_FavoritesID;
@synthesize arr_AllFriend;
@synthesize arrAllFriendIds;
@synthesize arr_AddedEvents;
@synthesize strCurrentLocation;
@synthesize arrRegister;
@synthesize objHomeVieewController;
@synthesize arrFavorite;
@synthesize arrFriendEvents;
@synthesize selectedBtn;
@synthesize arrUpcomingEvents;
@synthesize arrOrganisationFav;
@synthesize isOraganisation;
@synthesize arrTemp;
@synthesize _session;
@synthesize imgFav;
@synthesize reversegeocoder;
@synthesize hostReach;
@synthesize internetReach;
@synthesize wifiReach;
@synthesize isNetAvail;
@synthesize currentUserID;
@synthesize arr_User;
@synthesize arrFeatured;
@synthesize arrTotalEvents;
@synthesize isWiFi;
@synthesize arrBusinessFav;
@synthesize heightOfCalendarIncreased;


#pragma mark -
#pragma mark Application lifecycle

-(void)UseReverseGeoCoder:(CLLocation*)newLocation
{
    //self.userCurrentLattitude = [NSString stringWithFormat:@"%.7f",newLocation.coordinate.latitude];
	//self.userCurrentLongitude = [NSString stringWithFormat:@"%.7f",newLocation.coordinate.longitude];
	//NSLog(@"latitude = %@ ,\n Longitude = %@",userCurrentLattitude, userCurrentLongitude);
    
 	if (self.reversegeocoder) 
    {
		[self.reversegeocoder cancel];
		self.reversegeocoder.delegate = nil;
		self.reversegeocoder = nil;
	}
	
	// Note: If you lookup too many times within a very short of period, you might get error from Apple/Google.
	// e.g."/SourceCache/ProtocolBuffer/ProtocolBuffer-19/Runtime/PBRequester.m:446 server returned error: 503"
	// So you should avoid doing this in your code. This is just a demostration about how to reverse geocoding.
    
	self.reversegeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
	self.reversegeocoder.delegate = self;
	[self.reversegeocoder start];	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	tabBarController.delegate = self;
	pinChanged = NO;
	isOraganisation = NO;
    heightOfCalendarIncreased =0;
	
	/*****************************************************************/
	/*                   Array Declare                               */
	/*****************************************************************/
	
	arrTotalEvents = [[NSMutableArray alloc] init];
	arrFeatured = [[NSMutableArray alloc] init];
	arrTemp = [[NSMutableArray alloc] init];
 	arrRegister = [[NSMutableArray alloc] init];
	arr_AllEvents = [[NSMutableArray alloc] init];
	arr_FavoritesID = [[NSMutableArray alloc] init];
	arr_AllFriend = [[NSMutableArray alloc] init];
	arrAllFriendIds  = [[NSMutableArray alloc] init];
	arr_AddedEvents = [[NSMutableArray alloc] init];
	arrFavorite = [[NSMutableArray alloc] init];
    arrFriendEvents = [[NSMutableArray alloc]init];
	selectedBtn = [[UIButton alloc] init];
	arrUpcomingEvents = [[NSMutableArray alloc] init];
	arrOrganisationFav = [[NSMutableArray alloc] init];
	strCurrentLocation = [[UserLocationBO alloc] init];
	arrBusinessFav     = [[NSMutableArray alloc]init];
	
	/*****************************************************************/
	/*                   For Default Image                           */
	/*****************************************************************/
	
	UIImageView *defaultImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 460)];
	defaultImgv.image=[UIImage imageNamed:@"Default.png"];
	UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[loader startAnimating];
	loader.center = CGPointMake(160, 430);
	//[defaultImgv addSubview:loader];
	[loader release];
	defaultImgv.tag = 10;
	
	[window addSubview:defaultImgv];
	
	[self checkForInternet];
	[self LoadCoreData];
	[self upcomingEvents];
	
	/*****************************************************************/
	/*                   For Current Location                        */
	/*****************************************************************/
	
#if TARGET_IPHONE_SIMULATOR
    CLLocation *location = [[CLLocation alloc]initWithLatitude:17.412752 longitude:78.407894];
    [self UseReverseGeoCoder:location];
    [location release];
#endif
	
	if(locationManager)
	{
		locationManager.delegate = nil;
		[[NSURLCache sharedURLCache] removeAllCachedResponses];
		[locationManager release], locationManager = nil;
	}
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = 50.0;
	[locationManager locationServicesEnabled];
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	

	/*
	
	
	CLLocationManager *locationManger=[[CLLocationManager alloc]init];
	locationManger.delegate=self;
	locationManger.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[locationManger startUpdatingLocation];
	if (self.reversegeocoder) {
		[self.reversegeocoder cancel];
		self.reversegeocoder.delegate = nil;
		self.reversegeocoder = nil;
	}
	
	// Note: If you lookup too many times within a very short of period, you might get error from Apple/Google.
	// e.g."/SourceCache/ProtocolBuffer/ProtocolBuffer-19/Runtime/PBRequester.m:446 server returned error: 503"
	// So you should avoid doing this in your code. This is just a demostration about how to reverse geocoding.
	self.reversegeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:locationManger.location.coordinate];
	self.reversegeocoder.delegate = self;
	[self.reversegeocoder start];	

 
*/
	
	[defaultImgv release];	
    [self.window makeKeyAndVisible];
	//[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeDefault) userInfo:nil repeats:NO];

     return YES;
}



#pragma mark -
#pragma mark current location

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
 	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"Error fetching location" message:@"\"Ga2oo\" is unable to verify your location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
 	[locationManager stopUpdatingLocation];
	locationManager.delegate = nil;

}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
	
	[locationManager stopUpdatingLocation];
	locationManager.delegate = nil;

 	[self UseReverseGeoCoder:newLocation];
	
}
 


#pragma mark -
#pragma mark reverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	
	
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	
	double currentLong = placemark.coordinate.longitude;
	double currentLatt = placemark.coordinate.latitude;
	NSString *strZip = [placemark.addressDictionary valueForKey:@"ZIP"];
	NSString *strLocality = [placemark.addressDictionary valueForKey:@"Street"];
	NSString *strCity = [placemark.addressDictionary valueForKey:@"City"];
	NSString *strState = [placemark.addressDictionary valueForKey:@"State"];
	NSString *strCountry = [placemark.addressDictionary valueForKey:@"Country"];
	
 	if (strCurrentLocation) {
		[strCurrentLocation release];
		strCurrentLocation = nil;
	}
	strCurrentLocation = [[UserLocationBO alloc] init];
	
	if(currentLong)
		strCurrentLocation.GeoPoint = [NSString stringWithFormat:@"%f,%f",currentLatt, currentLong];
	else
		strCurrentLocation.GeoPoint = @"None";
	
	if([strLocality length])
		strCurrentLocation.Address = strLocality;
	else
		strCurrentLocation.Address = @"None";
	
	if([strCity length])
		strCurrentLocation.City = strCity;
	else
	{
		
		strCurrentLocation.City = @"None";	
	}
	
	if([strState length])
		strCurrentLocation.State = strState;
	else
		strCurrentLocation.State = @"None";
	
	if([strCountry length])
		strCurrentLocation.Country = strCountry;
	else
		strCurrentLocation.Country = @"None";
	
	if([strZip length])
		strCurrentLocation.Zipcode = strZip;
	else
		strCurrentLocation.Zipcode = @"None";
	
 	strCurrentLocation.IsPrimary = @"True";
	
}

#pragma mark -
#pragma mark LocalMethods

-(void)removeDefault
{
	UIImageView *temp = (UIImageView *)[window viewWithTag:10];
	[temp removeFromSuperview];
	temp = nil;
	
	objHomeVieewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
	navigationController = [[UINavigationController alloc] initWithRootViewController:objHomeVieewController];
	[self.window addSubview:navigationController.view];
}


-(void)upcomingEvents
{
	[arrUpcomingEvents removeAllObjects];
    NSMutableArray *UserUpcoming = [[NSMutableArray alloc] init];
	for(int i = 0; i<[arr_AllEvents count]; i++)
	{
		EventListBO *objEvent = [arr_AllEvents objectAtIndex:i];
         BOOL isEvtDtFeatured = [self featuredDateIs:objEvent.event_start_date];
		if(isEvtDtFeatured)
		{
			[UserUpcoming addObject:objEvent];
		 }
	}
	
    for(int i = 0 ; [self.arr_FavoritesID count]>i ; i++)
    {
        NSString *FavId = [[self.arr_FavoritesID objectAtIndex:i] strEventId];
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"Eventid == %@",FavId];
        NSArray *arr1 = [UserUpcoming filteredArrayUsingPredicate:pred1];
        
        if ([arr1 count]) {
            [arrUpcomingEvents addObjectsFromArray:arr1];
            
        }
    }
    
    [UserUpcoming release];
	if([arrUpcomingEvents count])
	{
		[self sortDateInAssending:arrUpcomingEvents];
	}
}

/*
   sorting dates of fourthcoming events in assending order
   return void
 */
-(void)sortDateInAssending:(NSMutableArray*)arrUpEvents
{
	for(int i=0;i<[arrUpEvents count];i++)
	{
		EventListBO *objEvent1 = [arrUpEvents objectAtIndex:i];
		NSDate *dtFrst = [self dtForEventStrtString:objEvent1.event_start_date];
		for(int j=i+1;j<[arrUpEvents count];j++)
		{
			EventListBO *objEvent = [arrUpEvents objectAtIndex:j];
			NSDate *dtEventNxt = [self dtForEventStrtString:objEvent.event_start_date];
			if([dtFrst compare:dtEventNxt]>0)
			{
				[arrUpEvents replaceObjectAtIndex:j withObject:objEvent1];
				[arrUpEvents replaceObjectAtIndex:i withObject:objEvent];
				//EventListBO *objEvntTmp = objEvent1;
				objEvent1 = objEvent;
				//objEvent = objEvntTmp;
				dtFrst = [self dtForEventStrtString:objEvent1.event_start_date];
			}

		}
	}
}


/*
   drForEventStrtString: method for converting strDt format to date format
    param: string
    return: date
 */
-(NSDate*)dtForEventStrtString:(NSString*)strEvntStrtDt
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM-dd"];
	NSDate *eventDate = [format dateFromString:strEvntStrtDt];
	[format release];
	return eventDate;
}

-(BOOL)featuredDateIs:(NSString*)eventStartDate
{
	BOOL isFeaturedDate = NO;
	NSDateFormatter *dtform = [[NSDateFormatter alloc]init];
	[dtform setDateFormat:@"yyyy-MM-dd"];
	NSDate *eventDt = [dtform dateFromString:eventStartDate];
	eventDt = (NSDate*)[eventDt dateByAddingTimeInterval:(5*60*60+30*60)];
	NSDate *currDt = [NSDate date];
	if(eventDt!=nil)
	{
		if([currDt compare:eventDt]<0)
		{
			NSLog(@"event date is more than today's date\n");
			isFeaturedDate = YES;
		}
	}
	[dtform release];
	return isFeaturedDate;
}


-(void) removeTabBar
{
   
	tabBarController.selectedIndex = 0;
	[((UINavigationController *)tabBarController.selectedViewController) popToRootViewControllerAnimated:YES];
	[tabBarController.view removeFromSuperview];
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
   
     for (UIViewController *controller in allViewControllers)
     {
         [((UINavigationController *)controller) popToRootViewControllerAnimated:YES];
     }
    
    //[allViewControllers removeAllObjects];
   // tabBarController.viewControllers = allViewControllers;
     
   
    [tabBarController release];
    tabBarController=nil;
}
-(void)AddTabBarViewControllers
{
    if (tabBarController) {
		[tabBarController release];
		tabBarController=nil;
	}
    
    tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray *tabBarViewControllers = [[NSMutableArray alloc] init];
	
	Ga2ooViewController *GVCobj = [[Ga2ooViewController alloc]initWithNibName:@"Ga2ooViewController" bundle:[NSBundle mainBundle]];
	UINavigationController *navigationController1=[[UINavigationController alloc] initWithRootViewController:GVCobj];
	navigationController1.navigationBarHidden = YES;
    GVCobj.tabBarItem.image=[UIImage imageNamed:@"home_icon.png"];
    GVCobj.title = @"Home";
 	[GVCobj release];
	
    CalenderViewController *CVCobj = [[CalenderViewController alloc]initWithNibName:@"CalenderViewController" bundle:[NSBundle mainBundle]];
 	UINavigationController *navigationController2=[[UINavigationController alloc] initWithRootViewController:CVCobj];
 	navigationController2.navigationBarHidden = YES;
    CVCobj.tabBarItem.image=[UIImage imageNamed:@"events_icon.png"];
    CVCobj.title = @"Events";
 	[CVCobj release];
    
    CalenderTabViewController *CTVCobj = [[CalenderTabViewController alloc]initWithNibName:@"CalenderTabViewController" bundle:[NSBundle mainBundle]];
	UINavigationController *navigationController3=[[UINavigationController alloc] initWithRootViewController:CTVCobj];
	navigationController3.navigationBarHidden = YES;
    CTVCobj.tabBarItem.image=[UIImage imageNamed:@"palendar_icon.png"];
    CTVCobj.title = @"Palendar";
 	[CTVCobj release];
	
    FriendsViewController *FVCobj = [[FriendsViewController alloc]initWithNibName:@"FriendsViewController" bundle:[NSBundle mainBundle]];
 	UINavigationController *navigationController4=[[UINavigationController alloc] initWithRootViewController:FVCobj];
 	navigationController4.navigationBarHidden = YES;
    FVCobj.tabBarItem.image=[UIImage imageNamed:@"friends_icon.png"];
    FVCobj.title = @"Friends";
 	[FVCobj release];
    
    SettingNewViewController *SNVCobj = [[SettingNewViewController alloc]initWithNibName:@"SettingNewViewController" bundle:[NSBundle mainBundle]];
 	UINavigationController *navigationController5=[[UINavigationController alloc] initWithRootViewController:SNVCobj];
 	navigationController5.navigationBarHidden = YES;
    SNVCobj.tabBarItem.image=[UIImage imageNamed:@"icon-9.png"];
    SNVCobj.title = @"More";
 	[SNVCobj release];
    
    [tabBarViewControllers addObject:navigationController1];
    
	[tabBarViewControllers addObject:navigationController2];
	[tabBarViewControllers addObject:navigationController3];
    [tabBarViewControllers addObject:navigationController4];
    
    [tabBarViewControllers addObject:navigationController5];
    
	[navigationController1 release];
    [navigationController2 release];
    [navigationController3 release];
    [navigationController4 release];
    [navigationController5 release];
    
    tabBarController.viewControllers = tabBarViewControllers;
    
	tabBarController.delegate = self;
 	[tabBarController setSelectedIndex:0];

    

}


#pragma mark -
#pragma mark rechability checking

-(void)checkForInternet
{
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	
	
	
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
	
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifier];
	[self updateInterfaceWithReachability: wifiReach];
	
	hostReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReach startNotifier];
	[self updateInterfaceWithReachability: hostReach];
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
	
	
}

-(void)noInternetConnectionAlert
{
	UIAlertView *syncAlert = [[UIAlertView alloc]initWithTitle:@"Connection failed" message:@"Please ensure that your internet connection is working" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	syncAlert.tag = 457;
	[syncAlert show];
	[syncAlert release];
	
}

- (BOOL)isHostReachable:(NSString *)host
{
    if (!host || ![host length]) {
        return NO;
    }
    
    SCNetworkReachabilityFlags		flags;
    SCNetworkReachabilityRef reachability =  SCNetworkReachabilityCreateWithName(NULL, [host UTF8String]);
	BOOL gotFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    
	CFRelease(reachability);
    
    if (!gotFlags) {
        return NO;
    }
    
	return [self isReachableWithoutRequiringConnection:flags];
}


- (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags
{
    // kSCNetworkReachabilityFlagsReachable indicates that the specified nodename or address can
	// be reached using the current network configuration.
	BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
	
	// This flag indicates that the specified nodename or address can
	// be reached using the current network configuration, but a
	// connection must first be established.
	//
	// If the flag is false, we don't have a connection. But because CFNetwork
    // automatically attempts to bring up a WWAN connection, if the WWAN reachability
    // flag is present, a connection is not required.
	BOOL noConnectionRequired = !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
		noConnectionRequired = YES;
	}
	
	return (isReachable && noConnectionRequired) ? YES : NO;
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	switch (netStatus)
    {
        case NotReachable:
        {
			isNetAvail = NO;
			break;
		}
		case ReachableViaWWAN:
		case ReachableViaWiFi:
		{
			isNetAvail = YES;
			break;
		}
		default:
			isNetAvail = YES;
			break;	
	}
	
}

-(void)showServerNotAvailable{
	
	UIAlertView *syncAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Server Unavailable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[syncAlert show];
	[syncAlert release];
	
}

#pragma mark -
#pragma mark CoreDataXML

-(void)LoadCoreData
{
	[self removeSyncLoader];
	UIImageView *temp = (UIImageView *)[window viewWithTag:10];
	[temp removeFromSuperview];
	temp = nil;
	
	objHomeVieewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
	navigationController = [[UINavigationController alloc] initWithRootViewController:objHomeVieewController];
	[self.window addSubview:navigationController.view];
}


-(void) loadAnimation
{
	UIImageView *temp = (UIImageView *)[window viewWithTag:10];
	
    UIView *LoaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 55, 320, 425)];
    LoaderView.backgroundColor =[UIColor clearColor];
    LoaderView.tag = 82;
    
	UIView *vw_Loader = [[UIView alloc] initWithFrame:CGRectMake(75,230, 170, 49)];
	vw_Loader.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
	vw_Loader.layer.cornerRadius = 6.0;
	vw_Loader.layer.borderColor = [[UIColor grayColor] CGColor];
	vw_Loader.layer.borderWidth = 2.0;
    [LoaderView addSubview:vw_Loader];
	
	//add indicator
	UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(90, 230 + 6, 37, 37)];
	[indView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indView startAnimating];
    [LoaderView addSubview:indView];
	[indView release];
	
	UILabel *lblSyncing = [[UILabel alloc] initWithFrame:CGRectMake(135, 230 + 14, 90, 20)];
	lblSyncing.backgroundColor = [UIColor clearColor];
	lblSyncing.text = @"Loading...";
	lblSyncing.textAlignment =UITextAlignmentCenter;
	lblSyncing.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
	lblSyncing.font = [UIFont boldSystemFontOfSize:14.0];
	lblSyncing.textColor = [UIColor whiteColor];
	lblSyncing.alpha=1.0;
	[LoaderView addSubview:lblSyncing];
	[lblSyncing release];
	
	[temp addSubview:LoaderView];
    
	[vw_Loader release];
    [LoaderView release];
}

-(void) removeSyncLoader
{
	UIImageView *temp = (UIImageView *)[window viewWithTag:10];
	
	if([temp viewWithTag:82])
	{
		[[temp viewWithTag:82] removeFromSuperview];
	}
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods


// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tbBarController didSelectViewController:(UIViewController *)viewController {
	
	if(tbBarController.selectedIndex ==0){
		
		[arrTemp removeAllObjects];
		isOraganisation = NO;
		[tbBarController setSelectedIndex:0];
		[((UINavigationController *)tbBarController.selectedViewController) popToRootViewControllerAnimated:NO];
	}
	else if(tbBarController.selectedIndex ==1){
		
		[arrTemp removeAllObjects];
		isOraganisation = NO;
		[tbBarController setSelectedIndex:1];
		[((UINavigationController *)tbBarController.selectedViewController) popToRootViewControllerAnimated:NO];
	}
	else if(tbBarController.selectedIndex ==2){
		
		[arrTemp removeAllObjects];
		isOraganisation = NO;
		[tbBarController setSelectedIndex:2];
		[((UINavigationController *)tbBarController.selectedViewController) popToRootViewControllerAnimated:NO];
	}
	else if(tbBarController.selectedIndex ==3){
		
		[arrTemp removeAllObjects];
		isOraganisation = NO;
		[tbBarController setSelectedIndex:3];
		[((UINavigationController *)tbBarController.selectedViewController) popToRootViewControllerAnimated:NO];
	}
	else if(tbBarController.selectedIndex ==4){
		
		[arrTemp removeAllObjects];
		isOraganisation = NO;
		[tbBarController setSelectedIndex:4];
		[((UINavigationController *)tbBarController.selectedViewController) popToRootViewControllerAnimated:NO];
	}
	
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/
#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext 
{
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) 
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil) 
    {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Ga2ooDB.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark ImageResize

-(UIImage*)resizedImage2:(UIImage*)inImage  inRect:(CGRect)thumbRect { 
	
	CGImageRef            imageRef = [inImage CGImage];
	CGImageAlphaInfo    alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	// There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
	// see Supported Pixel Formats in the Quartz 2D Programming Guide
	// Creating a Bitmap Graphics Context section
	// only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
	// and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
	// The images on input here are likely to be png or jpeg files
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	// Build a bitmap context that's the size of the thumbRect
	CGFloat bytesPerRow;
	
	if( thumbRect.size.width > thumbRect.size.height ) {
		bytesPerRow = 4 * thumbRect.size.width;
	} else {
		bytesPerRow = 4 * thumbRect.size.height;
	}
	
	CGContextRef bitmap = CGBitmapContextCreate(    
												NULL,
												thumbRect.size.width,        // width
												thumbRect.size.height,        // height
												8, //CGImageGetBitsPerComponent(imageRef),    // really needs to always be 8
												bytesPerRow, //4 * thumbRect.size.width,    // rowbytes
												CGImageGetColorSpace(imageRef),
												alphaInfo
												);
	
	// Draw into the context, this scales the image
	CGContextDrawImage(bitmap, thumbRect, imageRef);
	
	// Get an image from the context and a UIImage
	CGImageRef    ref = CGBitmapContextCreateImage(bitmap);
	UIImage*    result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);    // ok if NULL
	CGImageRelease(ref);
	
	return result;
}

#pragma mark -
#pragma mark Application's Documents directory

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	[arrBusinessFav release];
	[arrAllFriendIds release];
	[hostReach release];
	[internetReach release];
	[wifiReach release];
	[_session release];
    [tabBarController release];
    [window release];
	[arr_AddedEvents release];
    [super dealloc];
}


@end

