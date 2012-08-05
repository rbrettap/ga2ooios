//
//  TableViewCellForHomePage.m
//  Ga2oo
//
//  Created by SANDEEP GOYAL on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewCellForHomePage.h"
#import <quartzcore/QuartzCore.h>

@implementation TableViewCellForHomePage
@synthesize lblTitle;
@synthesize imgViewEvent;
@synthesize lblWhen;
@synthesize lblDetail;
@synthesize lblPrice;
@synthesize _thread,loaderView;
@synthesize imgCoverImg;
@synthesize btn_star,btn_favourite;
@synthesize lbl_fnds;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		self.lblTitle = [[UILabel alloc]init];
		[self.lblTitle setFrame:CGRectMake(80, 4, 220, 20)];
		[self.lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
		self.lblTitle.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
		[self.lblTitle setBackgroundColor:[UIColor clearColor]];
  		[self.contentView addSubview:self.lblTitle];
		[self.lblTitle release];
		
				
		self.lblDetail = [[UILabel alloc]init];
		[self.lblDetail setFrame:CGRectMake(80, 25, 120, 15)];
		lblDetail.numberOfLines = 0;
		lblDetail.adjustsFontSizeToFitWidth = NO;
		self.lblDetail.textColor = [UIColor colorWithRed:131.0/255.0 green:179/255.0 blue:197/255.0 alpha:1.0];
		[self.lblDetail setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
		[self.lblDetail setBackgroundColor:[UIColor clearColor]];
		[self.lblDetail setLineBreakMode:UILineBreakModeWordWrap];
  		[self.contentView addSubview:self.lblDetail];
		[self.lblDetail release];
		
		self.lblPrice = [[UILabel alloc]init];
		[self.lblPrice setFrame:CGRectMake(220, 23, 100, 15)];
		[self.lblPrice setFont:[UIFont systemFontOfSize:11]];
		[self.lblPrice setBackgroundColor:[UIColor clearColor]];
		self.lblPrice.textColor = [UIColor colorWithRed:118.0/255.0 green:118.0/255.0 blue:118.0/255.0 alpha:1.0];
		[self.lblPrice setLineBreakMode:UILineBreakModeWordWrap];
  		[self.contentView addSubview:self.lblPrice];
		[self.lblPrice release];
		
//		lbl_fnds=[[UILabel alloc]initWithFrame:CGRectMake(145, 44, 100, 25)];
//		lbl_fnds.backgroundColor=[UIColor clearColor];
//		lbl_fnds.textColor=[UIColor colorWithRed:28/255.0 green:111.0/255.0 blue:176.0/255.0 alpha:1.0];
//		lbl_fnds.font = [UIFont fontWithName:@"Helvetica" size: 12.0];
//		[self.contentView addSubview:lbl_fnds];
//		[lbl_fnds release];
		
		
		btn_star =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btn_star.frame = CGRectMake(215,44,41,26);
		btn_star.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:btn_star];
		
		btn_favourite =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btn_favourite.frame = CGRectMake(260,45,41,26);
		btn_favourite.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:btn_favourite];
		
		
		
		self.imgViewEvent = [[UIImageView alloc]init];
		imgViewEvent.frame = CGRectMake(10, 7,57,57);
		[imgViewEvent.layer setMasksToBounds:YES];
		[imgViewEvent.layer setBorderColor:[[UIColor whiteColor] CGColor]];

		imgViewEvent.contentMode = UIViewContentModeScaleAspectFit;
		imgViewEvent.contentMode = UIViewContentModeScaleToFill;		
		[self.contentView addSubview: self.imgViewEvent];
		[imgViewEvent release];
		imgViewEvent.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];
	
		loaderView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loaderView.hidesWhenStopped=YES;
		loaderView.center=imgViewEvent.center;
		[self.contentView addSubview:loaderView];
		//[loaderView startAnimating];
		[loaderView release];
		
		UIImageView *imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(300, 33, 10, 14)];
		imgArrow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"]];
		[self.contentView addSubview:imgArrow];
		[imgArrow release];
		
		
		UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 77, 320, 3)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eventSeperator@2x" ofType:@"png"]];
		[self.contentView addSubview:imgSep];
		[imgSep release];
		
    }
    return self;
}

///***----****//

-(void)setTheEventInTheCell:(EventListBO *)obj_
{
    
    
//    self.lbl_Title.text=obj_.name;
//    self.lbl_Date.text= obj_.event_start_date; 
//    
//    if(obj_.noOfFriends)
//    {
//		if(obj_.noOfFriends==1)
//            self.lbl_fnds.text=[NSString stringWithFormat:@"%i friend",obj_.noOfFriends];
//        else
//			self.lbl_fnds.text=[NSString stringWithFormat:@"%i friends",obj_.noOfFriends];
//	}	
//    else {
//        self.lbl_fnds.text=[NSString stringWithFormat:@"No friend"];
//    }
    
    if(obj_.isFav)
    {
        [self.btn_star setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
    }
    else
    {
        [self.btn_star setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
        
    }
    
	[self.btn_favourite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"share" ofType:@"png"]] forState:UIControlStateNormal];
	
	
	
}










-(EventListBO *)getTips
{
	return objEvent;
}

- (void)setTips:(EventListBO *)item 
{
	[item retain];
	[objEvent release];
	objEvent = item;
	
	self.lblTitle.text = [NSString stringWithFormat:@"%@",item.name];
	self.lblPrice.text = [NSString stringWithFormat:@"%@",item.price];
	self.lblDetail.text = [NSString stringWithFormat:@"%@  %@", item.event_start_date,item.event_start_time];
}
	
-(void)showEventsImage

{
	
	
	
	@synchronized(self) 
	{	
		if ([[NSThread currentThread] isCancelled])
		{
			return;
		}
		
		[_thread cancel];	
		[_thread release];
		_thread = nil;
		self.imgViewEvent.image = nil;
		
		if ([objEvent image])
		{
			self.imgViewEvent.image = [objEvent image];		
			[loaderView stopAnimating];
		}
		
		else
		{
			_thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImageEvents) object:nil];
			[_thread start];
		}			
	}	
}

-(void)setImage:(UIImage *)image {
	
	self.imgViewEvent.image = image;
	
}
- (void)downloadImageEvents
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[NSThread sleepForTimeInterval:0.0]; 	
	if (![[NSThread currentThread] isCancelled])
	{
		[objEvent downloadImage];
		
		@synchronized(self) 
		{
			if (![[NSThread currentThread] isCancelled])
			{
				self.imgViewEvent.image = nil;
				[self.imgViewEvent performSelectorOnMainThread:@selector(setImage:) withObject:[objEvent image] waitUntilDone:NO];                        
//                EventListBL *eventbl = [[EventListBL alloc]init];
//                [eventbl Update:objEvent withSave:YES];
//                [eventbl release];
				[loaderView stopAnimating];
			}
		}
	}
	[pool release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}
- (void)dealloc {
	
    [super dealloc];
}


@end
