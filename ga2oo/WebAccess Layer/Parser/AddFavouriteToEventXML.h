//
//  AddFavouriteToEventXML.h
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AddFavouriteToEventBO.h"
#import "Ga2ooAppDelegate.h"
#import "SaxXMLParser.h"

@protocol AddFavouriteToEventXML_Delegate;

@interface AddFavouriteToEventXML : SaxXMLParser {
	
	
	AddFavouriteToEventBO *currentObject;
	Ga2ooAppDelegate *appDelegate;
	
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;
}

@property(nonatomic, retain) AddFavouriteToEventBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

@end

@protocol AddFavouriteToEventXML_Delegate<NSObject>

- (void)AddFavouriteToEventXML_Error:(AddFavouriteToEventXML*)parser encounteredError:(NSError *)error with:(AddFavouriteToEventBO *)Object;
- (void)AddFavouriteToEventXML_Finished:(AddFavouriteToEventBO *)parser;

@end

