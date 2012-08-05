//
//  UserEventsBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserEventsBO.h"
#import "UserEventsDA.h"
#import "UserEventsXML.h"

@interface UserEventsBL : BaseBussinessLayer <UserEventsXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUserEvents;
-(void)NewUserEventsXml;
-(void)UserEventsLoadingCompleted;

@end
