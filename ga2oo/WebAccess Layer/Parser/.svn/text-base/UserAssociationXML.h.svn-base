#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserAssociationXML_Delegate;

@class UserAssociationBO;

@interface UserAssociationXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserAssociationBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
}

@property(nonatomic, retain) UserAssociationBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic, assign) NSInteger userId;
@end

@protocol UserAssociationXML_Delegate<NSObject>

- (void)UserAssociationXML_Error:(UserAssociationXML*)parser encounteredError:(NSError *)error;
- (void)UserAssociationXML_Finished:(NSMutableArray*)parser;

@end
