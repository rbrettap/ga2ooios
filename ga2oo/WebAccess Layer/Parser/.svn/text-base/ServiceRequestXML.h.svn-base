#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"

@protocol ServiceRequestXML_Delegate;

@class ServiceOutput;
@class RegisterObject;
@interface ServiceRequestXML : SaxXMLParser
{
	NSMutableArray *arrRequest;
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
@property(nonatomic, retain) NSMutableArray *arrRequest;
@end

@protocol RegistrationXML_Delegate<NSObject>

- (void)ServiceRequestXML_Error:(ServiceRequestXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object;
- (void)ServiceRequestXML_Finished:(ServiceOutput*)parser;

@end
