//
//  twitterViewController.h
//  RestaurantApp
//
//  Created by Basil.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import <QuartzCore/QuartzCore.h>

@class SRC_Sports_WWCAppDelegate;

@interface twitterViewController : UIViewController <SA_OAuthTwitterEngineDelegate, SA_OAuthTwitterControllerDelegate,UITextViewDelegate> {

	IBOutlet UITextView *txtView;
	IBOutlet UILabel *lblCounter;
	SA_OAuthTwitterEngine *_engine;

	UIAlertView *progressAlert;
	int count;
	
	UIView *loaderView;
	int loaderVal;
	
	SRC_Sports_WWCAppDelegate *appDelegate;
	NSString *dataToBePublished;
	
	IBOutlet UIToolbar *toolBar1;
}
@property (nonatomic , retain)	NSString *dataToBePublished;
@property (nonatomic , retain) UITextView *txtView;
@property(nonatomic,retain) UILabel *lblCounter;
@property (nonatomic , assign) int count;
@property (nonatomic , assign) int loaderVal;
@property (nonatomic, retain) 	UIToolbar *toolBar1;


-(void)post_btnClick:(id)sender;
-(void)updateStream:(id)sender;

-(void)removeLoadView;
-(IBAction)logout;
-(void)showLoginScreen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDataToBePublished:(NSString *)str;
@end
