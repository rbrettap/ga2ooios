//
//  EventFriendListXML.h
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol EventFriendListXML_Delegate;

@class EventFriendListBO;

@interface EventFriendListXML : SaxXMLParser {

	Ga2ooAppDelegate *appDelegate;
	EventFriendListBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSDateFormatter *dtFormat;
	NSString *strUser;
}
@property(nonatomic, retain) EventFriendListBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic, retain) NSString *strUser;

@end

@protocol EventFriendListXML_Delegate<NSObject>

- (void)EventFriendListXML_Error:(EventFriendListXML*)parser encounteredError:(NSError *)error;
- (void)EventFriendListXML_Finished:(NSMutableArray*)parser;

@end
