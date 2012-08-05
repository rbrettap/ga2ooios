//
//  EventFriendTableCell.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendTableCell.h"
#import <quartzcore/QuartzCore.h>

@implementation EventFriendTableCell
@synthesize lblTitle;
@synthesize imgViewEvent;
@synthesize imgViewDarkBG;
@synthesize loaderView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		
		imgViewDarkBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendCellBg.png"]];
		imgViewDarkBG.frame = CGRectMake(-50, 0, 420, 74);
		imgViewDarkBG.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgViewDarkBG];
		[imgViewDarkBG release];
		
		self.lblTitle = [[UILabel alloc]init];
		[self.lblTitle setFrame:CGRectMake(85,0,295,74)];
		[self.lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
		[self.lblTitle setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
		[self.lblTitle setBackgroundColor:[UIColor clearColor]];
		[self.lblTitle setLineBreakMode:UILineBreakModeWordWrap];
  		[self.contentView addSubview:self.lblTitle];
		[self.lblTitle release];
		
		self.imgViewEvent = [[UIImageView alloc]init];
		self. imgViewEvent.backgroundColor = [UIColor blackColor];
		self. imgViewEvent.contentMode = UIViewContentModeScaleToFill;
		self. imgViewEvent.frame = CGRectMake(10	,5 , 62	, 64);
		[self.contentView addSubview: self.imgViewEvent];
         [self.imgViewEvent.layer setMasksToBounds:YES];
        [self.imgViewEvent.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        self.imgViewEvent.layer.cornerRadius = 10.0;
        self.imgViewEvent.layer.borderWidth = 2.0;
        self.imgViewEvent.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
        
        
		[imgViewEvent release];
		
		loaderView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loaderView.hidesWhenStopped=YES;
		loaderView.center=imgViewEvent.center;
		[self.contentView addSubview:loaderView];
		[loaderView startAnimating];
		[loaderView release];
		
	}
    return self;
}

-(FriendsBO *)getTips
{
	return objUser;
}

- (void)setTips:(FriendsBO *)item 
{
	[item retain];
	[objUser release];
	objUser = item;
	
	self.lblTitle.text = [NSString stringWithFormat:@"%@ %@",item.firstName, item.lastName];
}




#pragma mark -
#pragma mark LazyLoading

-(void)showUserImage
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
		
		if ([objUser image])
		{
			self.imgViewEvent.image = [objUser friendImage];		
			[loaderView stopAnimating];
		}
		
		else
		{
			_thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImageUserFriends) object:nil];
			[_thread start];
		}			
	}	
}

-(void)setimage:(UIImage *)image {
	
	self.imgViewEvent.image = image;
	
}
- (void)downloadImageUserFriends
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[NSThread sleepForTimeInterval:0.0]; 	
	if (![[NSThread currentThread] isCancelled])
	{
		[objUser downloadImage];
		
		@synchronized(self) 
		{
			if (![[NSThread currentThread] isCancelled])
			{
				self.imgViewEvent.image = nil;
				[self.imgViewEvent performSelectorOnMainThread:@selector(setImage:) withObject:[objUser image] waitUntilDone:NO];	
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
