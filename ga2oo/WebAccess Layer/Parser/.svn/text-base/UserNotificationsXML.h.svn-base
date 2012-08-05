//
//  UserNotificationsXML.h
//  Ga2oo
//
//  Created by Gopinath PUPPALA on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventNotificationsBO.h"
#import "EventNotifications.h"
#import "Ga2ooAppDelegate.h"
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"


@protocol UserNotificationsXML_Delegate;

@class EventNotificationsBO;


@interface UserNotificationsXML : SaxXMLParser {

	
	Ga2ooAppDelegate *appDelegate;
	EventNotificationsBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	
}

@property(nonatomic, retain)  EventNotificationsBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;


@end


@protocol UserNotificationsXML_Delegate<NSObject>

- (void)UserNotificationsXML_Error:(UserNotificationsXML*)parser encounteredError:(NSError *)error;
- (void)UserNotificationsXML_Finished:(NSMutableArray*)parser;



@end
