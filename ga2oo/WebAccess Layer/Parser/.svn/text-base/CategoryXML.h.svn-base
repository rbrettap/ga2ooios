#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol CategoryXML_Delegate;

@class CategoryBO;

@interface CategoryXML : SaxXMLParser
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

@protocol CategoryXML_Delegate<NSObject>

- (void)CategoryXML_Error:(CategoryXML*)parser encounteredError:(NSError *)error;
- (void)CategoryXML_Finished:(NSMutableArray*)parser;

@end
