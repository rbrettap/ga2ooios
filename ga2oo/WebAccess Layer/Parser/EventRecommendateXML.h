//
//  EventRecommendateXML.h
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventRecommendateBO.h"
#import "EventRecommendate.h"
#import "Ga2ooAppDelegate.h"
#import "SaxXMLParser.h"

@protocol EventRecommendateXML_Delegate;

@class EventRecommendateBO;

@interface EventRecommendateXML : SaxXMLParser {

    Ga2ooAppDelegate *appDelegate;
	EventRecommendateBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
    
	
}

@property(nonatomic, retain)  EventRecommendateBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;


@end


@protocol EventRecommendateXML_Delegate<NSObject>

- (void)EventRecommendateXML_Error:(EventRecommendateXML*)parser encounteredError:(NSError *)error;
- (void)EventRecommendateXML_Finished:(NSMutableArray*)parser;



@end

