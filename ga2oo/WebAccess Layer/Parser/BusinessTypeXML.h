#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol BusinessTypeXML_Delegate;

@class BusinessTypeBO;

@interface BusinessTypeXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	BusinessTypeBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) BusinessTypeBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol BusinessTypeXML_Delegate<NSObject>

- (void)BusinessTypeXML_Error:(BusinessTypeXML*)parser encounteredError:(NSError *)error;
- (void)BusinessTypeXML_Finished:(NSMutableArray*)parser;

@end
