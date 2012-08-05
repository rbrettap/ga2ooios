//
//  GUserEventXML.h
//  Ga2oo
//
//  Created by Fahad on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"
#import "UserFavEvents.h"

@protocol GUserEventXML_Delegate;

@interface GUserEventXML : SaxXMLParser {
    Ga2ooAppDelegate *appDelegate;
    NSMutableString *currentValue;
    NSString *SelectedUserId;
    UserFavEvents *UserFavEventsObj;
    
}
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, assign) NSString *SelectedUserId;
@property(nonatomic, retain) UserFavEvents *UserFavEventsObj;

@end

@protocol GUserEventXML_Delegate<NSObject>

- (void)GUserEventXML_Error:(GUserEventXML*)parser encounteredError:(NSError *)error;
- (void)GUserEventXML_Finished:(NSMutableArray*)parser;

@end
