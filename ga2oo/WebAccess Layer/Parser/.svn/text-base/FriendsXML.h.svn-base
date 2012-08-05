#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol FriendsXML_Delegate;

@class FriendsBO;

@interface FriendsXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	FriendsBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) FriendsBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol FriendsXML_Delegate<NSObject>

- (void)FriendsXML_Error:(FriendsXML*)parser encounteredError:(NSError *)error;
- (void)FriendsXML_Finished:(NSMutableArray*)parser;

@end
