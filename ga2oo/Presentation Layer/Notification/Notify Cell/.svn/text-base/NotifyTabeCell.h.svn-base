//
//  NotifyTabeCell.h
//  Ga2oo
//
//  Created by Mayank Goyal on 05/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventListBO.h"

@interface NotifyTabeCell : UITableViewCell {

	UILabel *lblTitle;
	UILabel *lblSubTitle;
	UIImageView *imgImage;
	UIImageView *imgSep;
	UIButton *btnDelete;
	
	EventListBO *objEvent;
	NSThread *_thread;
	UIActivityIndicatorView *loaderView;
	UIImage *imgCoverImg;	
}
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UILabel *lblSubTitle;
@property (nonatomic, retain) UIImageView *imgImage;
@property (nonatomic, retain) UIButton *btnDelete;
@property (nonatomic, retain) UIImageView *imgSep;

@property(nonatomic,retain) EventListBO *objEvent;
@property(nonatomic,retain) NSThread *_thread;
@property(nonatomic,retain) UIActivityIndicatorView *loaderView;
@property(nonatomic,retain) UIImage *imgCoverImg;

-(void)showEventsImage;
-(void)setArticle:(EventListBO *)articleObj;

@end
