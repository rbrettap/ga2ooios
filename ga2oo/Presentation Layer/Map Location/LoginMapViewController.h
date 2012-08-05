//
//  LoginMapViewController.h
//  PirateJimbo
//
//  Created by win it on 9/28/10.
//  Copyright 2010 WINITSOFTWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKAnnotation.h>
#import "DDAnnotation.h"
#import "UserLocationBO.h"
#import "UserLocationBL.h"

@class Ga2ooAppDelegate;
@class BaseViewController;

@interface LoginMapViewController : UIViewController <UITabBarDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate,MKMapViewDelegate,UITextFieldDelegate, UISearchBarDelegate> {
	
	Ga2ooAppDelegate *appDelegate;
	NSMutableSet *_annotations;
	CLLocationCoordinate2D currentLocation;
	MKReverseGeocoder *reversegeocoder;
	MKPlacemark *MyPlaceMark;
 	IBOutlet MKMapView *mapView;
	IBOutlet UIButton *BtnSave;
 	IBOutlet UISearchBar *Search;
	DDAnnotation *addAnnotation;
	CLLocationManager *locationManger;
	NSTimer *testTimer;
	UIActivityIndicatorView *loader;
	NSMutableString *latitude;
	NSMutableString *longitude;
	NSMutableString *zip;
	NSString *SelectedLocation;
	
	NSString *strDragedPlace;
	UserLocationBO *objUserLoc;
	UserLocationBL *objUser;
	UserLocationBO *userLocationForZip;
}
@property (nonatomic, retain) IBOutlet UISearchBar *Search;
@property (nonatomic, retain)IBOutlet MKMapView *mapView;
@property (nonatomic, retain)IBOutlet UIButton *BtnSave;
@property(nonatomic,retain) NSMutableSet *_annotations;
@property(nonatomic,retain) MKPlacemark *MyPlaceMark;
@property(nonatomic) CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain) CLLocationManager *locationManger;
@property(nonatomic,retain) MKReverseGeocoder *reversegeocoder;
@property(nonatomic,retain) NSMutableString *latitude;
@property(nonatomic,retain) NSMutableString *longitude;
@property(nonatomic,retain) NSMutableString *zip;
@property(nonatomic,retain) NSString *strDragedPlace;

@property(nonatomic,retain) NSString *SelectedLocation;
@property(nonatomic,retain) UserLocationBO *objUserLoc;
@property(nonatomic,assign) UserLocationBO *userLocationForZip;

-(CLLocationCoordinate2D) addressLocation;
-(void)showLoader;
-(void)hideLoader;
-(IBAction)Savelocation;
-(IBAction)back;
//-(void)_coordinateChanged:(CLLocation *)Location;
-(NSString *) getCurrentLocationFromLong:(double)Long Lattitude:(double)Latt;
-(IBAction) back_TouchUpInside;

-(void)mapFind;


@end
