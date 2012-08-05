//
//  PersonalViewController.h
//  Registration
//
//  Created by SaiKrishna on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define CurrentLocationMode YES
#define ZipMode NO
@class RegistrationBL;
@class Ga2ooAppDelegate;
@class LoginMapViewController;
@interface PersonalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate,CLLocationManagerDelegate> {
	
	Ga2ooAppDelegate *appDelegate;
	LoginMapViewController *obj_LMV;
    RegistrationBL *RegdLayer;
	UITableView *tblView;
	UITextField *currenttextfiled;
	UITextField *myTextField;
	UIToolbar *toolBar;
	UIToolbar *keyboardToolBar;
	UIPickerView *picker_Location;
	UIPickerView *picker_Gender;
	UIDatePicker *datePicker;
	UIScrollView *scrlView;
	UIView *viewResult;
	NSMutableArray *arr_Values;
	NSMutableArray *arr_Values1;
	NSMutableArray *arr_Locations;
	NSMutableArray *arr_Gender;
	UIButton *btn_Submit;
	NSInteger intValue;
	int selected;
	int sel_pickerValue1;
	int sel_pickerValue2;
	int intSelectedLoc;
	int intSelGender;
	
	NSString *GoogleMapsAPIKey;
 	
	
	MKMapView *mapView ;
	CLLocationManager *locationManager;
	MKPinAnnotationView *annView1;
    
    
    BOOL SeletedLocationMode;
    
    UserLocationBO *ZipLocation;
    
     UIView *loaderView;

}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UserLocationBO *ZipLocation;

-(void)showHideToolBar:(CGPoint)point;
-(void)enableDisableTheBarButtons;
-(void)setTheContentOffsetOfTheTable:(CGPoint)point;
-(void)addPicker;
-(void)addDatePicker;
-(IBAction)backButtonPressed;
-(BOOL)mailIdCheck;
-(BOOL)mailIdCheck;
-(BOOL)passwordCheck;
-(BOOL)validateEmail: (NSString *) candidate;
-(void)addToolBar;
-(void)addPicker1;
-(void)hideDatePicker;
-(void)hidePicker;
-(void)showPicker1;
-(void)hidePicker1;
-(void)showDatePicker;
-(NSString *)GettingDataforZipCode:(NSString *) StrValue;

@end
