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

@interface TableviewEvent : UITableViewCell {
	UILabel *lblTitle;
	UIImageView *imgViewEvent;
	UILabel *lblWhen;
	UILabel *lblWhere;
	UIButton *btnDetail;
	UILabel *lblDetail;
	UIImageView *imgViewArrow;
	UIImageView *imgViewArrowDown;
	EventListBO *objEvent;
	
	NSThread *_thread;
	UIActivityIndicatorView *loaderView;
	UIImage *imgCoverImg;
}
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIImageView *imgViewEvent;
@property (nonatomic, retain) UILabel *lblWhen;
@property (nonatomic, retain) UILabel *lblWhere;
@property (nonatomic, retain) UIButton *btnDetail;
@property (nonatomic, retain) UILabel *lblDetail;
@property (nonatomic, retain) UIImageView *imgViewArrow;
@property (nonatomic, retain) UIImageView *imgViewArrowDown;

@property(nonatomic,retain) NSThread *_thread;
@property(nonatomic,retain) UIActivityIndicatorView *loaderView;
@property(nonatomic,retain) UIImage *imgCoverImg;

-(EventListBO *)getTips;
- (void)setTips:(EventListBO *)item ;
-(void)showEventsImage;

@end
