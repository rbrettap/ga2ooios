//
//  settingProfileViewController.h
//  Ga2oo
//
//  Created by Fahad on 20/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBO.h"
#import "UpdateProfileBL.h"
#import "UserBL.h"
#import <QuartzCore/QuartzCore.h>
#import "UserLocationBL.h"

@interface settingProfileViewController : BaseViewController <UIImagePickerControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate,UINavigationControllerDelegate> {
	IBOutlet UITableView *tblSetting;
	NSMutableArray *arrSetting;
	IBOutlet UIView *viewToolBar;
	IBOutlet UIToolbar *toolBar;
	UITextField *currenttextfiled;
	NSInteger intTag;
	
	BOOL isFirstTime;
	NSMutableArray *arrUserProfile;
	UserBO *objUser;
	UpdateProfileBL *updateLayer;
	UserBL *UserLayer;
	UIButton *btnImage;
	UIImagePickerController *imgPickerCon;
	UIImage *imgProfile;
	UserLocationBL *UserLocLayer;
	UserLocationBO *objuserLoc;
	//UIImageView *imgProfile;
	UITextField *myTextField;
}
@property (nonatomic, retain) NSMutableArray *arrUserProfile;
@property (nonatomic, retain) UIImage *imgProfile;

-(BOOL) validateEmail: (NSString *) candidate;
-(IBAction)backBtnClicked;
-(IBAction)doneBtnClicked;

-(IBAction)barBtnsClicked:(id)sender;
-(void)enableDisableTheBarButtons;
-(void)showHideToolBar:(CGPoint)point;
-(void)setTheContentOffsetOfTheTable:(CGPoint)point;
-(void)choosePhoto;
-(void)takePhoto;

-(void)displayProfileImage;

@end

