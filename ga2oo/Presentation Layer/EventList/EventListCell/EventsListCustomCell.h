//
//  EventsListCustomCell.h
//  Ga2oo
//
//  Created by SaiKrishna on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListBO.h"

@interface EventsListCustomCell : UITableViewCell {

	UIImageView *img_Event;
	UILabel *lbl_Title;
	UILabel *lbl_Date;
	UILabel *lbl_Price;
	UIScrollView *scrl_Images;
	UILabel *lbl_fnds;
	UIButton *btn_star;
	UIButton *btn_favourite;
	UIImageView *imgPhoto;
	UIImageView *imgPhoto1;
	UIButton *btnFriend;
	
	EventListBO *objEvent;
	NSThread *_thread;
	UIActivityIndicatorView *loaderView;
	UIImage *imgCoverImg;
}

@property(nonatomic,retain) UIImageView *img_Event;
@property(nonatomic,retain)  UILabel *lbl_Title;
@property(nonatomic,retain) UILabel *lbl_Date;
@property(nonatomic,retain) UILabel *lbl_Price;
@property(nonatomic,retain) UIScrollView *scrl_Images;
@property(nonatomic,retain) UILabel *lbl_fnds;
@property(nonatomic,retain) UIButton *btn_star;
@property(nonatomic,retain) UIButton *btn_favourite;
@property(nonatomic,retain) UIImageView *imgPhoto;
@property(nonatomic,retain) UIImageView *imgPhoto1;
@property(nonatomic,retain) UIButton *btnFriend;

@property(nonatomic,retain) EventListBO *objEvent;
@property(nonatomic,retain) NSThread *_thread;
@property(nonatomic,retain) UIActivityIndicatorView *loaderView;
@property(nonatomic,retain) UIImage *imgCoverImg;


-(void)showEventsImage;
-(void)setArticle:(EventListBO *)articleObj;
-(void)setTheEventInTheCell:(EventListBO *)obj_;

@end
