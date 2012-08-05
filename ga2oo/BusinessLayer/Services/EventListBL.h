//
//  EventListBL.h
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventListBO.h"
#import "EventListDA.h"
#import "EventListXML.h"

@interface EventListBL : BaseBussinessLayer<EventListXML_Delegate> {

    
	id delegate;
    
    NSString *str_date;
    NSString *str_category;
    NSString *str_type;
    
    NSInteger ModeType;
}

@property(nonatomic,assign) id delegate;
@property(nonatomic,retain) NSString *str_date;
@property(nonatomic,retain) NSString *str_category;
@property(nonatomic,retain) NSString *str_type;
@property(nonatomic,assign) NSInteger ModeType;

-(void)LoadEventList;
-(void)NewEventsListXml;
-(void)EventsListLoadingCompleted:(NSMutableArray*)arr;
-(NSMutableArray*)SelectAllEventsAccordingToFriend:(NSString *)friendId;
-(NSMutableArray*)SelectAllEventsAddingFriends;

@end
