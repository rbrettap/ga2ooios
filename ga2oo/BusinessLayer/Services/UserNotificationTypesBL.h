//
//  UserNotificationTypesBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserNotificationTypesBO.h"
#import "UserNotificationTypesDA.h"
#import "UserNotificationTypesXML.h"

@interface UserNotificationTypesBL : BaseBussinessLayer <UserNotificationTypesXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUserNotificationTypes;
-(void)NewUserNotificationTypesXml;
-(void)UserNotificationTypesLoadingCompleted;

@end
