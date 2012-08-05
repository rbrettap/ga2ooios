#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"

@protocol RegistrationXML_Delegate;

@class ServiceOutput;
@class RegisterObject;
@interface RegistrationXML : SaxXMLParser
{
	ServiceOutput *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSInteger userId;
	NSString *strSoapMsg;
	RegisterObject *regObj;
}
@property(nonatomic, retain)	RegisterObject *regObj;
@property(nonatomic, retain) ServiceOutput *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic) NSInteger userId;
@property(nonatomic, retain) NSString *strSoapMsg;

@end

@protocol RegistrationXML_Delegate<NSObject>

- (void)RegistrationXML_Error:(RegistrationXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object;
- (void)RegistrationXML_Finished:(ServiceOutput*)parser;

@end
