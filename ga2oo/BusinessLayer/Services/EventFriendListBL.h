//
//  EventFriendListBL.h
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventFriendListBO.h"
#import "EventFriendListDA.h"
#import "EventFriendListXML.h"


@interface EventFriendListBL : BaseBussinessLayer <EventFriendListXML_Delegate> {

	id delegate;
	EventFriendListXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUser:(NSString *)userId;
-(void)NewUserXml:(NSString *)userId;
-(void)LoadEventFriendLoadingCompleted;

@end
