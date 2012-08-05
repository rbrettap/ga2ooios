//
//  EventLocationBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventLocationBO.h"
#import "EventLocationDA.h"
#import "EventLocationXML.h"

@interface EventLocationBL : BaseBussinessLayer <EventLocationXML_Delegate>{

	id delegate;
	UIAlertView *locationAlert;
	EventLocationXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadEventsLocation:(NSString *)eventId;
-(void)NewEventsLocationXml:(NSString *)eventId;
-(void)EventsLocationLoadingCompleted;
-(void)hidealert;

@end
