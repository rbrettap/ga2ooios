#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"

@protocol AuthenticateUserXML_Delegate;

@class AuthenticateUserBO;

@interface AuthenticateUserXML : SaxXMLParser
{
	AuthenticateUserBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;

	NSString *strSoapMsg;
}

@property(nonatomic, retain) AuthenticateUserBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@property(nonatomic, retain) NSString *strSoapMsg;

@end

@protocol AuthenticateUserXML_Delegate<NSObject>

- (void)AuthenticateUserXML_Error:(AuthenticateUserXML*)parser encounteredError:(NSError *)error with:(AuthenticateUserBO *)Object;
- (void)AuthenticateUserXML_Finished:(AuthenticateUserBO*)parser;

@end
