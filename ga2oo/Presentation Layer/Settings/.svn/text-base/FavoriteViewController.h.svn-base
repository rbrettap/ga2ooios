//
//  FavoriteViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 07/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessListBL.h"
#import "UserFavBusinessEventsXML.h"
#import "EventsBO.h"
#import "BusinessListBL.h"

@class Ga2ooAppDelegate;

@interface FavoriteViewController : UIViewController <UserFavBusinessEventsXM_Delegate,UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource>{

	Ga2ooAppDelegate *appDelegate;
    UserFavBusinessEventsXML *objFavBusinessEvent;
	IBOutlet UITableView *tblFavorites;
	BusinessListBL *businessLayer;
	UISearchBar *searchBarFav;
	IBOutlet UIButton *btnEdit;
	NSMutableArray *arrSearched;
	BOOL searching;
    BusinessFavEventBO *Selectedobj;
     FavoriteBusinessBL *UserFavBussLayer;
    BusinessListBL *BusinessListLayer;
    NSMutableArray *ArrAllBusiness;

}
@property (nonatomic,retain) NSMutableArray *ArrAllBusiness;

-(IBAction)BackBtnClicked;
-(IBAction)editBtnClicked;
-(void)getBusinessIdOfSelectedBusinessEvent:(NSInteger)selectedEvtRow;
-(void)loadBusinesFavourites;
@end
