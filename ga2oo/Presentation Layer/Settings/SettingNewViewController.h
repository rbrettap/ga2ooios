//
//  SettingNewViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingNewViewController : BaseViewController {

	IBOutlet UITableView *tblSetting;
	NSMutableArray *arrSetting;
	NSMutableArray *arrGeneral;
}

-(IBAction) logoutBtn_Clicked;

@end
