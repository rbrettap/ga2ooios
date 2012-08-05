//
//  TableviewEvent.m
//  Ga2oo
//
//  Created by SANDEEP GOYAL on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableviewEvent.h"
#import <quartzcore/QuartzCore.h>
 
@implementation TableviewEvent
@synthesize lblTitle;
@synthesize imgViewEvent;
@synthesize lblWhen;
@synthesize lblWhere;
@synthesize btnDetail;
@synthesize lblDetail;
@synthesize imgViewArrow;
@synthesize imgViewArrowDown;
@synthesize _thread;
@synthesize loaderView;
@synthesize imgCoverImg;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		UIImageView *imgViewDarkBG = [[UIImageView alloc] init];//[WithImage:[UIImage imageNamed:@"friendCellBg.png"]];
		imgViewDarkBG.frame = CGRectMake(0, 0, 320, 44);
		imgViewDarkBG.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:imgViewDarkBG];
		[imgViewDarkBG release];
		
		self.lblTitle = [[UILabel alloc]init];
		[self.lblTitle setFrame:CGRectMake(55,1,240,44)];
		//self.lblTitle.lineBreakMode = UILineBreakModeClip;
		[self.lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
		[self.lblTitle setTextColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]];
		[self.lblTitle setBackgroundColor:[UIColor clearColor]];
  		[self.contentView addSubview:self.lblTitle];
		[self.lblTitle release];
		
		self.lblWhen = [[UILabel alloc]init];
		[self.lblWhen setFrame:CGRectMake(145,40,290,20)];
		[self.lblWhen setFont:[UIFont systemFontOfSize:13]];
		[self.lblWhen setTextColor:[UIColor blackColor]];
		[self.lblWhen setBackgroundColor:[UIColor clearColor]];
		[self.lblWhen setLineBreakMode:UILineBreakModeWordWrap];
  		//[self.contentView addSubview:self.lblWhen];
		[self.lblWhen release];
		
		self.lblWhere = [[UILabel alloc]init];
		[self.lblWhere setFrame:CGRectMake(10,35,280,20)];
		lblWhen.numberOfLines = 0;
		lblWhere.adjustsFontSizeToFitWidth = NO;
		[self.lblWhere setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
		[self.lblWhere setTextColor:[UIColor colorWithRed:209.0/255.0 green:235.0/255.0 blue:145.0/255.0 alpha:1.0]];
		[self.lblWhere setBackgroundColor:[UIColor clearColor]];
		[self.lblWhere setLineBreakMode:UILineBreakModeWordWrap];
  		//[self.contentView addSubview:self.lblWhere];
		[self.lblWhere release];
		
		self.lblDetail = [[UILabel alloc]init];
		[self.lblDetail setFrame:CGRectMake(10,140,300,70)];
		lblDetail.numberOfLines = 0;
		lblDetail.adjustsFontSizeToFitWidth = NO;
		[self.lblDetail setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
		[self.lblDetail setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
		[self.lblDetail setBackgroundColor:[UIColor clearColor]];
		[self.lblDetail setLineBreakMode:UILineBreakModeWordWrap];
  	//	[self.contentView addSubview:self.lblDetail];
		[self.lblDetail release];
		
		self.imgViewEvent = [[UIImageView alloc]init];
		imgViewEvent.frame = CGRectMake(5	,1 , 44	, 44);
		[imgViewEvent.layer setMasksToBounds:YES];
		[imgViewEvent.layer setBorderColor:[[UIColor whiteColor] CGColor]];
		[imgViewEvent.layer setBorderWidth:1.0];
		//imgViewEvent.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];

		//imgViewEvent.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview: self.imgViewEvent];
		
		
		self.btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.btnDetail setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"view_detials_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[self.btnDetail setFrame:CGRectMake(140, 80, 145, 41)];
		//[self.contentView addSubview:self.btnDetail];
		
		imgViewArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_white.png"]];
		imgViewArrow.frame = CGRectMake(305, 28, 9, 13);
		imgViewArrow.backgroundColor = [UIColor clearColor];
		//[self.contentView addSubview: imgViewArrow];
		[imgViewArrow release];
		
		imgViewArrowDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_white_down.png"]];
		imgViewArrowDown.frame = CGRectMake(301, 28, 14, 9);
		//[self.contentView addSubview: imgViewArrowDown];
		imgViewArrowDown.backgroundColor = [UIColor clearColor];
		[imgViewArrowDown release];
		
    }
    return self;
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
	 
}
	

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
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

-(void)setimage:(UIImage *)image {
	
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
				[loaderView stopAnimating];
			}
		}
	}
	[pool release];
}



- (void)dealloc {
	[imgViewEvent release];
    [super dealloc];
}


@end
