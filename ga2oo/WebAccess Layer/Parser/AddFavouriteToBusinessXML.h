//
//  AddFavouriteToBusinessXML.h
//  Ga2oo
//
//  Created by Suresh on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddFavouriteToBusinessBO.h"
#import "Ga2ooAppDelegate.h"
#import "SaxXMLParser.h"

@protocol AddFavouriteToBusinessXML_Delegate;

@interface AddFavouriteToBusinessXML : SaxXMLParser {
	
	 
	AddFavouriteToBusinessBO *currentObject;
	Ga2ooAppDelegate *appDelegate;

	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;
}

@property(nonatomic, retain) AddFavouriteToBusinessBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

@end

@protocol AddFavouriteToBusinessXML_Delegate<NSObject>

- (void)AddFavouriteToBusinessXML_Error:(AddFavouriteToBusinessXML*)parser encounteredError:(NSError *)error with:(AddFavouriteToBusinessBO *)Object;
- (void)AddFavouriteToBusinessXML_Finished:(AddFavouriteToBusinessBO *)parser;

@end

