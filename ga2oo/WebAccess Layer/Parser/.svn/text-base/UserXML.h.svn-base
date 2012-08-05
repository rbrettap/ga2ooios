#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol UserXML_Delegate;

@class UserBO;
@class UserLocationBO;
@class UserAssociationBO;

@interface UserXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UserBO *currentObject;
		UserLocationBO *currentLocationObject;
			UserAssociationBO *currentAssociationObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSDateFormatter *dtFormat;
	NSInteger userId;
}

@property(nonatomic, retain) UserBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic, retain)UserLocationBO *currentLocationObject;
@property(nonatomic, retain)UserAssociationBO *currentAssociationObject;


@property(nonatomic, assign) NSInteger userId;
@end

@protocol UserXML_Delegate<NSObject>

- (void)UserXML_Error:(UserXML*)parser encounteredError:(NSError *)error;
- (void)UserXML_Finished:(NSMutableArray*)parser;

@end
