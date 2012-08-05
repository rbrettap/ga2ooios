//
//  TicketWebViewController.h
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsBO.h"
#import <QuartzCore/QuartzCore.h>

@interface TicketWebViewController : BaseViewController <UIWebViewDelegate>{

	EventsBO *objEvent;
	IBOutlet UIWebView* aWebView;
	IBOutlet UIBarButtonItem *backButton;
	IBOutlet UIBarButtonItem *forwardButton;
	IBOutlet UIActivityIndicatorView *mainIndicator;
	NSURL* aUrl;
}
@property (nonatomic, retain) EventsBO *objEvent;

-(IBAction)backButtonPressed:(id)sender;
-(IBAction)forwardButtonPressed:(id)sender;
-(IBAction)refreshButtonPressed:(id)sender;
-(IBAction)opensafariButtonPressed:(id)sender;

-(void)cretaeInterface;

@end
