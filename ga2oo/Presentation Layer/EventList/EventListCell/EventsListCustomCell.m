//
//  EventsListCustomCell.m
//  Ga2oo
//
//  Created by SaiKrishna on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventsListCustomCell.h"

@implementation EventsListCustomCell
@synthesize imgPhoto;
@synthesize imgPhoto1;
@synthesize btnFriend;
@synthesize lbl_Title,lbl_Date,lbl_Price,scrl_Images,lbl_fnds,btn_star,btn_favourite;
@synthesize img_Event;
@synthesize objEvent,_thread,loaderView;
@synthesize imgCoverImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {

		img_Event = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7,57,57)];
		[self.contentView addSubview:img_Event];
		
		img_Event.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];

		
		lbl_Title=[[UILabel alloc]initWithFrame:CGRectMake(80, 4, 220, 20)];
		lbl_Title.backgroundColor=[UIColor clearColor];
		lbl_Title.textColor=[UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
		lbl_Title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 16.0];
		[self.contentView addSubview:lbl_Title];
		[lbl_Title release];
		
		lbl_Date=[[UILabel alloc]initWithFrame:CGRectMake(80, 23, 120, 15)];
		lbl_Date.backgroundColor=[UIColor clearColor];
		lbl_Date.font = [UIFont fontWithName:@"Helvetica" size: 12.0];
		lbl_Date.textColor = [UIColor colorWithRed:131.0/255.0 green:179/255.0 blue:197/255.0 alpha:1.0];
		[self.contentView addSubview:lbl_Date];
		[lbl_Date release];
		
		
		lbl_Price=[[UILabel alloc]initWithFrame:CGRectMake(220, 23, 120, 15)];
		lbl_Price.backgroundColor=[UIColor clearColor];
		lbl_Price.textColor=[UIColor colorWithRed:118.0/255.0 green:118.0/255.0 blue:118.0/255.0 alpha:1.0];
		lbl_Price.font = [UIFont fontWithName:@"Helvetica" size: 12.0];
		[self.contentView addSubview:lbl_Price];
		[lbl_Price release];
		
		scrl_Images=[[UIScrollView alloc]initWithFrame:CGRectMake(75, 41, 70, 25)];
		scrl_Images.backgroundColor=[UIColor  clearColor];
		[self.contentView addSubview:scrl_Images];
		scrl_Images.showsHorizontalScrollIndicator = FALSE;
		
		lbl_fnds=[[UILabel alloc]initWithFrame:CGRectMake(95, 44, 100, 25)];
		lbl_fnds.backgroundColor=[UIColor clearColor];
        lbl_fnds.textAlignment = UITextAlignmentRight;
		lbl_fnds.textColor=[UIColor colorWithRed:28/255.0 green:111.0/255.0 blue:176.0/255.0 alpha:1.0];
		lbl_fnds.font = [UIFont fontWithName:@"Helvetica" size: 12.0];
		[self.contentView addSubview:lbl_fnds];
		[lbl_fnds release];
		
		btn_star =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btn_star.frame = CGRectMake(205,41,41,26);
		btn_star.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:btn_star];
		
		btn_favourite =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btn_favourite.frame = CGRectMake(260,45,41,26);
		btn_favourite.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:btn_favourite];
		
		UIImageView *imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(300, 30, 10, 14)];
		imgArrow.tag = 877689;
		imgArrow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"]];
		[self.contentView addSubview:imgArrow];
		[imgArrow release];
		
		UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 77, 320, 3)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eventSeperator@2x" ofType:@"png"]];
		[self.contentView addSubview:imgSep];
		[imgSep release];
		
		imgPhoto = [[UIImageView alloc]init];
		imgPhoto.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgPhoto];
		[imgPhoto release];
		
		imgPhoto1 = [[UIImageView alloc]init];
		imgPhoto1.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgPhoto1];
		[imgPhoto1 release];
		[scrl_Images release];
		
		btnFriend = [UIButton buttonWithType:UIButtonTypeCustom];
		btnFriend.frame = CGRectMake(145, 40, 50, 35);
		[self.contentView addSubview:btnFriend];
		
		loaderView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loaderView.hidesWhenStopped=YES;
		loaderView.center=CGPointMake(45,35);
		[self.contentView addSubview:loaderView];
		//[loaderView startAnimating];
		[loaderView release];
	}
	return self;
}

-(void)setTheEventInTheCell:(EventListBO *)obj_{
    
    
    self.lbl_Title.text=obj_.name;
    self.lbl_Date.text= [NSString stringWithFormat:@"%@ %@",obj_.event_start_date,obj_.event_start_time]; 
    
    if(obj_.noOfFriends)
    {
		if(obj_.noOfFriends==1)
           self.lbl_fnds.text=[NSString stringWithFormat:@"%i friend",obj_.noOfFriends];
		  else 
			self.lbl_fnds.text=[NSString stringWithFormat:@"%i friends",obj_.noOfFriends];
    }	
    else {
        self.lbl_fnds.text=[NSString stringWithFormat:@"No friend"];
    }
    
    /*if(obj_.isFav)
    {
        [self.btn_star setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
    }
    else
    {
        [self.btn_star setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
        
    }*/
    
      [self.btn_favourite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"share" ofType:@"png"]] forState:UIControlStateNormal];
      
      
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark -
#pragma mark LazyLoading

-(EventListBO *)getArticle
{
	return objEvent;
}

-(void)setArticle:(EventListBO *)articleObj
{
	objEvent = nil;
	objEvent = articleObj;
	lbl_Price.text = objEvent.price;
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
		self.img_Event.image = nil;
		
		if ([objEvent image])
		{
			self.img_Event.image = [objEvent image];		
			[loaderView stopAnimating];
		}
		
		else
		{
			_thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImageEvents) object:nil];
			[_thread start];
		}			
	}	
}

-(void)setimage:(UIImage *)image {
	
	self.img_Event.image = image;
	
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
				self.img_Event.image = nil;
				[self.img_Event performSelectorOnMainThread:@selector(setImage:) withObject:[objEvent image] waitUntilDone:NO];	
				[loaderView stopAnimating];
			}
		}
	}
	[pool release];
}



-(void)dealloc
{
	[img_Event release];
	[super dealloc];
}
@end
