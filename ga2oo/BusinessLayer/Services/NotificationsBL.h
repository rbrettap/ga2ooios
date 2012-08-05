//
//  NotificationsBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "NotificationsBO.h"
#import "NotificationsDA.h"
#import "UserNotificationsXML.h"

@interface NotificationsBL : BaseBussinessLayer <UserNotificationsXML_Delegate> {

	UserNotificationsXML *parser;
	BOOL CompletedParser;
	UIAlertView *locationAlert;
	id delegate;
}
@property(nonatomic,assign) id delegate;

-(void)LoadNotifications;
-(void)NewNotificationsXml;
-(void)NotificationsLoadingCompleted;

@end
