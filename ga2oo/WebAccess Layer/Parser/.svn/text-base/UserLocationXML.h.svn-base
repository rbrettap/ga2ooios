#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserLocationXML_Delegate;

@class UserLocationBO;

@interface UserLocationXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserLocationBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) UserLocationBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol UserLocationXML_Delegate<NSObject>

- (void)UserLocationXML_Error:(UserLocationXML*)parser encounteredError:(NSError *)error;
- (void)UserLocationXML_Finished:(NSMutableArray*)parser;

@end
