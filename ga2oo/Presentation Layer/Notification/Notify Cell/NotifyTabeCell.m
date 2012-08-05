//
//  NotifyTabeCell.m
//  Ga2oo
//
//  Created by Mayank Goyal on 05/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "NotifyTabeCell.h"


@implementation NotifyTabeCell
@synthesize lblTitle;
@synthesize lblSubTitle;
@synthesize imgImage;
@synthesize btnDelete;
@synthesize imgSep;
@synthesize objEvent,_thread,loaderView;
@synthesize imgCoverImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		imgImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
		imgImage.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgImage];
		imgImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoImageEvent" ofType:@"png"]];
		[imgImage release];
		
		lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 225, 25)];
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.font = [UIFont boldSystemFontOfSize:16];
		lblTitle.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
		[self.contentView addSubview:lblTitle];
		[lblTitle release];
		
		lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 225, 20)];
		lblSubTitle.backgroundColor = [UIColor clearColor];
		lblSubTitle.font = [UIFont boldSystemFontOfSize:11];
		lblSubTitle.textColor = [UIColor colorWithRed:131.0/255.0 green:179.0/255.0 blue:197.0/255.0 alpha:1.0];
		[self.contentView addSubview:lblSubTitle];
		[lblSubTitle release];
		
		imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(13, 98, 293, 2)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
		imgSep.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgSep];
		[imgSep release];
		
		UIImageView *imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(300, 24, 10, 14)];
		imgArrow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"]];
		imgArrow.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgArrow];
		[imgArrow release];
		
		btnDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		btnDelete.frame = CGRectMake(-20, 18, 20, 20);
		[self.contentView addSubview:btnDelete];
		
		loaderView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loaderView.hidesWhenStopped=YES;
		loaderView.center=imgImage.center;
		[self.contentView addSubview:loaderView];
		//[loaderView startAnimating];
		[loaderView release];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
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
		self.imgImage.image = nil;
		
		if ([objEvent image])
		{
			self.imgImage.image = [objEvent image];		
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
	
	self.imgImage.image = image;
	
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
				self.imgImage.image = nil;
				[self.imgImage performSelectorOnMainThread:@selector(setImage:) withObject:[objEvent image] waitUntilDone:NO];	
				[loaderView stopAnimating];
			}
		}
	}
	[pool release];
}

- (void)dealloc {
    [super dealloc];
}


@end
