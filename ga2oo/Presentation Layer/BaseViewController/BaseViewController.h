//
//  BaseViewController.h
//  Alhilal
//
//  Created by winit on 04/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstant.h"

@class Ga2ooAppDelegate;
@interface BaseViewController : UIViewController {

	Ga2ooAppDelegate *appDelegate;
}

-(void)showNavigationBar;
-(void)setBackgroundImageToView:(UIView *)temp;
-(void)setlogoutbtnToNavController:(UINavigationController *)navcon;
-(void)setTopBarImageToView:(UIView *)temp;
-(void)setTopBarImageToViewWithHome:(UIView *)temp;
-(void)setTopBarImageToViewWithSignUp:(UIView *)temp;
-(void)setTopBarImageToEventDetailView:(UIView *)temp;
-(void) removeSyncLoader;
-(void) loadAnimation;

@end
