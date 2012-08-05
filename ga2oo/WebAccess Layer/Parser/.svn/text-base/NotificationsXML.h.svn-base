#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol NotificationsXML_Delegate;

@class NotificationsBO;

@interface NotificationsXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	NotificationsBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) NotificationsBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol NotificationsXML_Delegate<NSObject>

- (void)NotificationsXML_Error:(NotificationsXML*)parser encounteredError:(NSError *)error;
- (void)NotificationsXML_Finished:(NSMutableArray*)parser;

@end
