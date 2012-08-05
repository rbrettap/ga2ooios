//
//  TableviewEvent.h
//  Ga2oo
//
//  Created by SANDEEP GOYAL on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventListBO.h"
#import "Ga2ooAppDelegate.h"
#import "EventImagesBL.h"

@interface TableViewCellForHomePage : UITableViewCell {
	UILabel *lblTitle;
	UIImageView *imgViewEvent;
	UILabel *lblWhen;
	UILabel *lblPrice;
	UILabel *lblDetail;
	UILabel *lbl_fnds;
	
	EventListBO *objEvent;
	
	UIButton *btn_star;
	UIButton *btn_favourite;

	
	NSThread *_thread;
	UIActivityIndicatorView *loaderView;
	UIImage *imgCoverImg;
	EventImagesBL *imagBl;

}
@property(nonatomic,retain)UILabel *lbl_fnds;
@property(nonatomic,retain) UIButton *btn_star;
@property(nonatomic,retain) UIButton *btn_favourite;

@property(nonatomic,retain)UILabel *lblPrice;
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIImageView *imgViewEvent;
@property (nonatomic, retain) UILabel *lblWhen;
@property (nonatomic, retain) UILabel *lblDetail;
@property(nonatomic,retain) NSThread *_thread;
@property(nonatomic,retain) UIActivityIndicatorView *loaderView;
@property(nonatomic,retain) UIImage *imgCoverImg;

-(EventListBO *)getTips;
- (void)setTips:(EventListBO *)item ;
-(void)setTheEventInTheCell:(EventListBO *)obj_;
-(void)showEventsImage;

@end
