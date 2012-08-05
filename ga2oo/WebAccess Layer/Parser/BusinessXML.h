#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol BusinessXML_Delegate;

@class BusinessBO;

@interface BusinessXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	BusinessBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) BusinessBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol BusinessXML_Delegate<NSObject>

- (void)BusinessXML_Error:(BusinessXML*)parser encounteredError:(NSError *)error;
- (void)BusinessXML_Finished:(NSMutableArray*)parser;

@end
