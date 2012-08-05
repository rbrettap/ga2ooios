//
//  NotificationViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 05/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utilities.h"
#import "NotificationsBL.h"
#import "EventRecommendateBL.h"
#import "FriendsBL.h"

@interface NotificationViewController : BaseViewController 
{

	IBOutlet UIButton *btnAll;
	IBOutlet UIButton *btnRecomd;
	IBOutlet UIButton *btnNoti;
	IBOutlet UITableView *tblRecomendation;
	NSMutableArray *arrNotification;
    NSMutableArray *arrRecommendation;
	
	NotificationsBL *notifyBl;
    EventRecommendateBL *RecmBL;
	EventNotificationsBO *Selectedobj; 
	FriendsBL *objFrndBL;
	
}
@property (nonatomic, retain) NSMutableArray *arrNotification;
@property (nonatomic, retain) NotificationsBL *notifyBl;
@property (nonatomic, retain)NSMutableArray *arrRecommendation;
@property (nonatomic, retain)EventRecommendateBL *RecmBL;
@property (nonatomic, retain) EventNotificationsBO *Selectedobj;


-(IBAction)backBtnClicked:(id)sender;
-(IBAction)segmentBtnClicked:(id)sender;
-(UIView *)designHeaderView;

@end
