#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserEventsXML_Delegate;

@class UserEventsBO;

@interface UserEventsXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserEventsBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) UserEventsBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol UserEventsXML_Delegate<NSObject>

- (void)UserEventsXML_Error:(UserEventsXML*)parser encounteredError:(NSError *)error;
- (void)UserEventsXML_Finished:(NSMutableArray*)parser;

@end
