//
//  EventsBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventsBO.h"
#import "EventsDA.h"
#import "EventsXML.h"


@interface EventsBL : BaseBussinessLayer <EventsXML_Delegate>{

	id delegate;
	UIAlertView *locationAlert;
	
	EventsXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadEvents:(NSString *)eventId;
-(void)NewEventsXml:(NSString *)eventId;
-(void)EventsLoadingCompleted;
-(void)hidealert;

@end
