//
//  DeleteFavouriteToEventXML.h
//  Ga2oo
//
//  Created by Suresh on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeleteFavouriteToEventBO.h"

@protocol DeleteFavouriteToEventXML_Delegate;

@interface DeleteFavouriteToEventXML : SaxXMLParser {
	
	
	DeleteFavouriteToEventBO *currentObject;
	Ga2ooAppDelegate *appDelegate;
	
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;
}

@property(nonatomic, retain) DeleteFavouriteToEventBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

-(NSNumber *)unixDateFormatFromDate:(NSDate *)date;

@end

@protocol DeleteFavouriteToEventXML_Delegate<NSObject>

- (void)DeleteFavouriteToEventXML_Error:(DeleteFavouriteToEventXML*)parser encounteredError:(NSError *)error with:(DeleteFavouriteToEventBO *)Object;
- (void)DeleteFavouriteToEventXML_Finished:(DeleteFavouriteToEventBO *)parser;

@end

