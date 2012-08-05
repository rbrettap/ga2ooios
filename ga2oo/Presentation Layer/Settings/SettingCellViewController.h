//
//  SettingCellViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBO.h"
#import "UpdateProfileBL.h"
#import "UpdateProfileBO.h"
#import <QuartzCore/QuartzCore.h>
#import "UserBL.h"
#import "UserAssociationBL.h"

@interface SettingCellViewController : BaseViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>{

	IBOutlet UITableView *tblSetting;
	NSMutableArray *arrSetting;
	NSMutableArray *arrPswd;
	UITableView *tblPswd;
	UIView *vwPswd;
	UserBO *objUser;
	UpdateProfileBL *updateLayer;
	UserAssociationBL *associationLayer;
	NSMutableArray *arrAssociation;
	UserBL *UserLayer;
	
	NSString *strInvisibleMode;
	NSString *strDeleteAccount;
}

@property (nonatomic, retain) NSString *strInvisibleMode;
@property (nonatomic, retain) NSString *strDeleteAccount;


-(IBAction)logoutBtn_Clicked;
-(IBAction)backBtnClicked;

@end
