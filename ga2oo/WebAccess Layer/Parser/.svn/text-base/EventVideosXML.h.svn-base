#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol EventVideosXML_Delegate;

@class EventVideosBO;

@interface EventVideosXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	EventVideosBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) EventVideosBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol EventVideosXML_Delegate<NSObject>

- (void)EventVideosXML_Error:(EventVideosXML*)parser encounteredError:(NSError *)error;
- (void)EventVideosXML_Finished:(NSMutableArray*)parser;

@end
