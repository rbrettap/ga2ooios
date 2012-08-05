//
//  ProfileViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBO.h"
#import "UserLocationBO.h"
#import "UserLocationBL.h"
#import "UserBL.h"

@interface ProfileViewController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

	UIImageView *imgViewProfile;
	UIImagePickerController *imgPickerCon;
	UILabel *lblCountry;
	UIButton *btnAddLocation;
	UITableView *tblAttend;
	UITableView *tblFavt;
	
	NSInteger intReferecnce;
	UserBO *objUser;
	NSMutableArray *arrUserLocation;
	UserLocationBO *objUserLoc;
	UIImage *imgUser;
	UIActivityIndicatorView *loader;
	
	NSString *strlocation;
	UserBL *UserLayer;
	
}
@property (nonatomic, retain)NSString *strlocation;
@property (nonatomic, retain) NSMutableArray *arrUserLocation;
@property (nonatomic, retain) UIImage *imgUser;

-(void)createInterFace;
-(void)choosePhoto;
-(void)takePhoto;
-(void)downloadImage:(NSString *)strImagePath Tag:(NSInteger)tag;

@end
