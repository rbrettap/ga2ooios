//
//  FriendRequestXML.h
//  Ga2oo
//
//  Created by Fahad on 23/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ga2ooAppDelegate.h"
#import "SaxXMLParser.h"
#import "FriendRequestBO.h"

@protocol FriendRequestXML_Delegate;

@interface FriendRequestXML : SaxXMLParser {
    
    Ga2ooAppDelegate *appDelegate;
	FriendRequestBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;

    
}

@property(nonatomic, retain) FriendRequestBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

@end


@protocol FriendRequestXML_Delegate<NSObject>

- (void)FriendRequestXML_Error:(FriendRequestXML*)parser encounteredError:(NSError *)error with:(FriendRequestBO *)Object;
- (void)FriendRequestXML_Finished:(FriendRequestBO *)parser;

@end
