#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol EventCategoryXML_Delegate;

@class CategoryBO;

@interface EventCategoryXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	CategoryBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) CategoryBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol EventCategoryXML_Delegate<NSObject>

- (void)EventCategoryXML_Error:(EventCategoryXML*)parser encounteredError:(NSError *)error;
- (void)EventCategoryXML_Finished:(NSMutableArray*)parser;

@end
