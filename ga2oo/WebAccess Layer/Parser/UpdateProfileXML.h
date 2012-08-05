#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"

@protocol UpdateProfileXML_Delegate;

@class UpdateProfileBO;
@class Ga2ooAppDelegate;
@interface UpdateProfileXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	UpdateProfileBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;
}

@property(nonatomic, retain) UpdateProfileBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

@end

@protocol UpdateProfileXML_Delegate<NSObject>

- (void)UpdateProfileXML_Error:(UpdateProfileXML*)parser encounteredError:(NSError *)error with:(UpdateProfileBO *)Object;
- (void)UpdateProfileXML_Finished:(UpdateProfileBO *)parser;

@end
