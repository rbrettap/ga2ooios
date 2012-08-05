//
//  SettingWebViewController.h
//  Ga2oo
//
//  Created by SaiKrishna on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingWebViewController : UIViewController {
	int selected;
	
	
	IBOutlet UILabel *lbl_Title;
	IBOutlet UIWebView *web;
	

}

@property(nonatomic,assign)int selected;
@property(nonatomic,retain)	IBOutlet UILabel *lbl_Title;

-(void)ShowWebView;
-(IBAction)btn_BackAction;


@end
