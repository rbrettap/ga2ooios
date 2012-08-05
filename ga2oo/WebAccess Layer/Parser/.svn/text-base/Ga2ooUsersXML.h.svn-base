#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol Ga2ooUsersXML_Delegate;

@class Ga2ooUserBO;

@interface Ga2ooUsersXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	Ga2ooUserBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) Ga2ooUserBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol Ga2ooUsersXML_Delegate<NSObject>

 
- (void)Ga2ooUsersXML_Error:(Ga2ooUsersXML*)parser encounteredError:(NSError *)error;
- (void)Ga2ooUsersXML_Finished:(NSMutableArray*)arrSchedule;
@end
