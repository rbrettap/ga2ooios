//
//  UserFavBusinessEventsXML.h
//  Ga2oo
//
//  Created by Suresh on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "BusinessFavEventBO.h"

@protocol UserFavBusinessEventsXM_Delegate;

@class Ga2ooAppDelegate;
@interface UserFavBusinessEventsXML : SaxXMLParser 
{
	Ga2ooAppDelegate *appDelegate;
	BusinessFavEventBO *currentObject;
}

@property(nonatomic, retain) NSMutableString *currentValue;
@end

@protocol UserFavBusinessEventsXM_Delegate<NSObject>

- (void)GUserBusinessEventXML_Error:(GUserEventXML*)parser encounteredError:(NSError *)error;
- (void)GUserFavBusinessEventsFinished:(NSMutableArray*)parser;

@end

