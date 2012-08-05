//
//  Ga2ooAppDelegate.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "FBConnect.h"
#import "PermissionStatus.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKAnnotation.h>
#import "ParkPlaceMark.h"
#import <CoreData/CoreData.h>
#import "Reachability.h"
#import "ConnectionCheck.h"
#import "UserLocationBO.h"


@interface Ga2ooAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, CLLocationManagerDelegate,MKReverseGeocoderDelegate,MKMapViewDelegate> {
	
    UIWindow *window;
    UITabBarController *tabBarController;
	UINavigationController *navigationController;
	HomeViewController *objHomeVieewController;
	
	CLLocationManager *locationManager;
	
	IBOutlet UIView *tempSignUp;
	UIScrollView *scrolSignUp;
	IBOutlet UIImageView *imgViewLogin;

	BOOL pinChanged;
	UserLocationBO *strCurrentLocation;
	NSMutableArray *arr_AllEvents;
	NSMutableArray *arr_AllFriend;
	NSMutableArray *arrAllFriendIds;
	NSMutableArray *arr_AddedEvents;
	NSMutableArray *arr_User;
	NSMutableArray *arrRegister;
	NSMutableArray *arrFavorite;
    NSMutableArray *arrFriendEvents;
	UIButton *selectedBtn;
	NSMutableArray *arrUpcomingEvents;
	NSMutableArray *arrOrganisationFav;
	BOOL isOraganisation;
	NSMutableArray *arrTemp;
	
	FBSession* _session;
	UIImage *imgFav;
	MKReverseGeocoder *reversegeocoder;
	
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;	    
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	Reachability* hostReach;
	Reachability* internetReach;
	Reachability* wifiReach;
	BOOL isNetAvail;
	BOOL isWiFi;
	
	NSString *currentUserID;
	NSMutableArray *arrFeatured;
	NSMutableArray *arrTotalEvents;
	NSMutableArray *arr_FavoritesID;
	NSMutableArray *arrBusinessFav;
    NSInteger heightOfCalendarIncreased;
}

@property (nonatomic, retain) 	NSMutableArray *arrBusinessFav;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain)  UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController *navigationController;

@property(nonatomic,retain)CLLocationManager *locationManager;


@property (nonatomic, retain) NSMutableArray* arr_AllEvents;
@property (nonatomic, retain) NSMutableArray* arr_AllFriend;
@property (nonatomic, retain) NSMutableArray *arrAllFriendIds;
@property (nonatomic, retain) NSMutableArray* arr_AddedEvents;
@property (nonatomic) BOOL pinChanged;
@property (nonatomic, retain) UserLocationBO *strCurrentLocation;
@property (nonatomic, retain) NSMutableArray *arrRegister;
@property (nonatomic, retain) HomeViewController *objHomeVieewController;
@property (nonatomic, retain) NSMutableArray *arrFavorite;
@property (nonatomic, retain) NSMutableArray *arrFriendEvents;
@property (nonatomic, retain) UIButton *selectedBtn;
@property (nonatomic, retain) NSMutableArray *arrUpcomingEvents;
@property (nonatomic, retain) NSMutableArray *arrOrganisationFav;
@property (nonatomic) BOOL isOraganisation;
@property (nonatomic, retain) NSMutableArray *arrTemp;
@property (nonatomic, retain) FBSession* _session;
@property (nonatomic, retain) UIImage *imgFav;
@property(nonatomic, retain) MKReverseGeocoder *reversegeocoder;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) Reachability* hostReach;
@property (nonatomic, retain) Reachability* internetReach;
@property (nonatomic, retain) Reachability* wifiReach;
@property (nonatomic, assign) BOOL isNetAvail;
@property (nonatomic, assign) BOOL isWiFi;
@property (nonatomic,retain) NSString * currentUserID;
@property (nonatomic, retain) NSMutableArray *arr_User;
@property (nonatomic, retain) NSMutableArray *arrFeatured;
@property (nonatomic, retain) NSMutableArray *arrTotalEvents;
@property (nonatomic, retain) NSMutableArray *arr_FavoritesID;
@property (nonatomic, assign) NSInteger heightOfCalendarIncreased;


-(void)upcomingEvents;
-(void )eventParser;
-(void)FriendParser;
-(void) removeTabBar;
-(UIImage*)resizedImage2:(UIImage*)inImage  inRect:(CGRect)thumbRect;
- (NSString *)applicationDocumentsDirectory;
-(void)LoadCoreData;
-(void)checkForInternet;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;
- (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags;
- (BOOL)isHostReachable:(NSString *)host;
-(void)showServerNotAvailable;
-(void) loadAnimation;
-(void) removeSyncLoader;
-(void)noInternetConnectionAlert;
-(BOOL)featuredDateIs:(NSString*)eventStartDate;
-(void)sortDateInAssending:(NSMutableArray*)arrUpEvents;
-(NSDate*)dtForEventStrtString:(NSString*)strEvntStrtDt;

@end
