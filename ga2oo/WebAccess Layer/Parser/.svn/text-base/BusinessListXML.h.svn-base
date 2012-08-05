#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol BusinessListXML_Delegate;

@class BusinessListBO;

@interface BusinessListXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	BusinessListBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) BusinessListBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol BusinessListXML_Delegate<NSObject>

- (void)BusinessListXML_Error:(BusinessListXML*)parser encounteredError:(NSError *)error;
- (void)BusinessListXML_Finished:(NSMutableArray*)parser;

@end
