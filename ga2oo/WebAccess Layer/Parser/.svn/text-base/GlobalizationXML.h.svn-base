#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol GlobalizationXML_Delegate;

@class GlobalizationBO;

@interface GlobalizationXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	GlobalizationBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) GlobalizationBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol GlobalizationXML_Delegate<NSObject>

- (void)GlobalizationXML_Error:(GlobalizationXML*)parser encounteredError:(NSError *)error;
- (void)GlobalizationXML_Finished:(NSMutableArray*)parser;

@end
