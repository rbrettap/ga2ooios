//
//  MyCircleViewController.h
//  Ga2oo
//
//  Created by Basil on 19/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FriendsBL.h"
@interface MyCircleViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource> {
	
    IBOutlet UISearchBar *FriendSearchBar;
    UITableView *tblMyCircle;
	NSMutableArray *arrGa2ooUsers;
	NSMutableArray *arrGa2ooFriends;
	NSMutableArray *arrSearchedGa2ooUsers;
    FriendsBL *objFrndBL;
    BOOL isSelected;
	IBOutlet UIButton *btnEdit;
}
@property (nonatomic,retain)NSMutableArray *arrSearchedGa2ooUsers;
@property (nonatomic,retain)IBOutlet UISearchBar *FriendSearchBar;
@property (nonatomic,retain) UITableView *tblMyCircle;
@property (nonatomic,retain)NSMutableArray *arrGa2ooUsers;
@property (nonatomic,retain)NSMutableArray *arrGa2ooFriends;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) UIButton *btnEdit;

-(IBAction)back_Touch_Up_Inside:(id)sender;
-(IBAction) logoutBtn_Clicked:(id) sender;
- (void)yesDeleteTheFriend;
- (void)addTheSelectedUserAsAfriend:(UIButton *)btn;
- (void)yesAddTheFriend;
-(void)EditingTable:(id)sender;
 
@end
