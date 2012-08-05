#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserNotificationTypesXML_Delegate;

@class UserNotificationTypesBO;

@interface UserNotificationTypesXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserNotificationTypesBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) UserNotificationTypesBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol UserNotificationTypesXML_Delegate<NSObject>

- (void)UserNotificationTypesXML_Error:(UserNotificationTypesXML*)parser encounteredError:(NSError *)error;
- (void)UserNotificationTypesXML_Finished:(NSMutableArray*)parser;

@end
