//
//  Ga2ooBusinessXML.h
//  Ga2oo
//
//  Created by WINIT on 27/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "BusinessDetailBO.h"


@protocol Ga2ooBusinessXML_Delegate;

@class Ga2ooAppDelegate;

@interface Ga2ooBusinessXML : SaxXMLParser {
    
    Ga2ooAppDelegate *appDelegate;
	BusinessDetailBO *currentObject;
    NSInteger BusinessId;
}

@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain)  BusinessDetailBO *currentObject;
@property(nonatomic, assign) NSInteger BusinessId;

@end

@protocol Ga2ooBusinessXML_Delegate<NSObject>

- (void)Ga2ooBusinessXML_Error:(Ga2ooBusinessXML*)parser encounteredError:(NSError *)error;
- (void)Ga2ooBusinessXMLFinished:(BusinessDetailBO*)parser;

@end
