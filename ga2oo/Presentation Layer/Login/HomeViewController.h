//
//  HomeViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 01/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthenticateUserBL.h"
#import "AuthenticateUserBO.h"
#import "UserBL.h"
#import "UserBO.h"
#import "FriendsBL.h"
#import "EventListBL.h"
#import "UserLocationBL.h"
#import "BusinessListBL.h"
#import "Ga2ooUsersBL.h"
#import "CategoryBL.h"
#import "GUserEventXML.h"
#import "NotificationsBL.h"
#import "FavoriteBusinessBL.h"
#import"EventImagesBL.h"
#import "EventsBL.h"
#import "EventRecommendateBL.h"


@interface HomeViewController : BaseViewController <GUserEventXML_Delegate>{

	IBOutlet UITextField *txtFieldUserName;
	IBOutlet UITextField *txtFieldPassword;
	IBOutlet UIButton *btnRegister;
	IBOutlet UIButton *btnLogin;
	UserBO *objUser;
    Ga2ooUsersBL *objGa2ooUsersBL;
    
	AuthenticateUserBL *updateLayer;
	UserBL *UserLayer;
	FriendsBL *objFrndBL;
	EventListBL *EventsLayer;
    EventImagesBL *EventsImageLayer;
    EventsBL *EventsimgLayer;
	UserLocationBL *UserLocationLayer;
	BusinessListBL *BusinessListLayer;
	CategoryBL *categotyBl;
	NotificationsBL *notifyBL;
    EventRecommendateBL *RecomBL;
	
	BOOL isUser;
	FavoriteBusinessBL *UserFavBussLayer;

}

-(IBAction) loginClicked:(id) sender;
-(IBAction)submitBtnClicked;
-(void)LoginValidation;
-(void)AuthenticateUser;
-(void)clearDatabase;


@end
