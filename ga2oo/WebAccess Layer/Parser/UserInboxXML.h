#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserInboxXML_Delegate;

@class UserInboxBO;

@interface UserInboxXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserInboxBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) UserInboxBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol UserInboxXML_Delegate<NSObject>

- (void)UserInboxXML_Error:(UserInboxXML*)parser encounteredError:(NSError *)error;
- (void)UserInboxXML_Finished:(NSMutableArray*)parser;

@end
