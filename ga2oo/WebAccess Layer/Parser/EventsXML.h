#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"
#import "EventImagesBO.h"

@protocol EventsXML_Delegate;

@class EventsBO;

@interface EventsXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	EventsBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSDateFormatter *dtFormat;
	NSString *EventID;
    EventImagesBO *currentImageObj;
    NSMutableArray *arrImages;
    BOOL isBussiness ;
    BOOL isEventImage ;
    BOOL isEventId ;
}
@property(nonatomic, retain)EventImagesBO *currentImageObj;
@property(nonatomic, retain)    NSMutableArray *arrImages;
@property(nonatomic, retain) EventsBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic, retain) NSString *EventID;;

@end

@protocol EventsXML_Delegate<NSObject>

- (void)EventsXML_Error:(EventsXML*)parser encounteredError:(NSError *)error;
- (void)EventsXML_Finished:(NSMutableArray*)parser;

@end
