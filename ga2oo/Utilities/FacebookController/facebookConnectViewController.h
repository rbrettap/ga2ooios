//
//  facebookConnectViewController.h
//  iVoucher
//
//  Created by rajender on 10/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "PermissionStatus.h"
#import "EventListBO.h"
#import "Ga2ooAppDelegate.h"

@class FBSession;
@interface facebookConnectViewController : UIViewController<PermissionStatusDelegate,FBSessionDelegate,FBRequestDelegate,FBDialogDelegate,UITextViewDelegate> {
	
	FBSession* _session;
	PermissionStatus *permissionStatusForUser;
	NSString *str_FaceBookUserName;
	Ga2ooAppDelegate *appDelegate;
	
	IBOutlet UIButton *btn_login;
	IBOutlet UILabel *lbl_LoginName;
	IBOutlet UILabel *lbl_FooterText;
	IBOutlet UIView *loaderView;
	EventListBO *objTemp;
	//FBLoginDialog* dialog;
	
	BOOL forLogin;
	BOOL canGetUserDetails;
	BOOL isFromLoginPage;
	UIActivityIndicatorView *indv_loader;
}

@property (nonatomic, retain) FBSession* _session;
@property(nonatomic,retain) PermissionStatus *permissionStatusForUser;
@property(nonatomic,copy) NSString *str_FaceBookUserName;
@property(nonatomic,retain) UIButton *btn_login;
@property(nonatomic,retain) UILabel *lbl_LoginName;
@property(nonatomic,retain) UILabel *lbl_FooterText;
@property (nonatomic, retain) UIView *loaderView;
@property (nonatomic, retain)EventListBO *objTemp;
@property (nonatomic) BOOL forLogin;
@property (nonatomic) BOOL canGetUserDetails;
@property (nonatomic) BOOL isFromLoginPage;
@property (nonatomic, retain) UIActivityIndicatorView *indv_loader;

//@property (nonatomic, retain) FBLoginDialog* dialog;

-(IBAction)publishFeed:(id)target;
-(void)setUsersStatus;
-(IBAction)logoutFromFacebook:(id)sender;
-(void)getUserName:(NSString *)uid;
-(void)publishFeed:(id)target;
-(IBAction)btn_LogingOnClick:(id)sender;
-(void)show_logingDialog;
-(void)manageLoginLogoutButton;
@end
