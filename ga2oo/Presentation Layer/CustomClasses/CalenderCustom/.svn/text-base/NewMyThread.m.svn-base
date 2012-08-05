//
//  NewMyThread.m
//  Church
//
//  Created by winit on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewMyThread.h"



@implementation NewMyThread
@synthesize btn;
@synthesize  ImageNmae;

- (id) initWithData1:(UIButton *)tempBtn andDay:(NSInteger) day andMonth:(NSInteger)month andYear:(NSInteger)year andmy:(NSInteger)flag andImageNamer:(NSString *)imgname andEventImage:(UIImage *)eImage
{
	if((self = [super init])) {
		// save off our parameters
		btn= tempBtn;
		[btn retain];
		int_Day = day;
		int_Month = month;
		int_Year = year;
		flag1 = flag;
        ImageNmae = imgname;
		EventImage = eImage;
		
	}
	
	return self;
}


- (void) main
{
	// no need to call [super main], as per the Apple reference docs
	// do whatever your thread needs to do
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	[super main];
	
	if(EventImage)
	{
		[btn setBackgroundImage:EventImage forState:UIControlStateNormal];
		
		NSLog(@"Image loaded");
		
	}
	
	else if(!ImageNmae || [ImageNmae isEqual:[NSNull null]])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
    }
	else 
	{
		NSError *error = nil;
		NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, ImageNmae];
		str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
		
		NSURL *url = [NSURL URLWithString:str];
		if(url)
		{
			NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
			if(!error){
				
				[btn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
				
			}
			else
            {
				[btn setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
            }
			
			[imageData release];
			
		}
		else
		{
			[btn setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
		}
	}
    
	[pool release];
	
}

- (void) dealloc
{
	[btn release];
	[super dealloc];
}
@end
