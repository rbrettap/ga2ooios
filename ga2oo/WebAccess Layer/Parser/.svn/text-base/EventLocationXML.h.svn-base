#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol EventLocationXML_Delegate;

@class EventLocationBO;

@interface EventLocationXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	EventLocationBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSString *intEventID;
}

@property(nonatomic, retain) EventLocationBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic,retain) NSString *intEventID;

@end

@protocol EventLocationXML_Delegate<NSObject>

- (void)EventLocationXML_Error:(EventLocationXML*)parser encounteredError:(NSError *)error;
- (void)EventLocationXML_Finished:(NSMutableArray*)parser;

@end
