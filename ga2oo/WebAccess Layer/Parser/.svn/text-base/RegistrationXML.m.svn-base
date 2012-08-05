#import "RegistrationXML.h"
#import "AuthenticateUserBO.h"
#import "RegisterObject.h"
#import "ServiceOutput.h"

@interface RegistrationXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;
@end

@implementation RegistrationXML
@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;
@synthesize strSoapMsg;
@synthesize regObj;

- (BOOL)parseWithLibXML2Parser
{
    NSString *newstr = [[NSString alloc] initWithFormat:@"%@", Ga200RegisterUser];
  	strSoapMsg = [[NSString alloc] initWithFormat:@
                  "<useraccount>\n"
                    "<email>%@</email>\n"
                    "<username>%@</username>\n"
                    "<firstname>%@</firstname>\n"
                    "<lastname>%@</lastname>\n"
                    "<currentzip>None</currentzip>\n"
                    "<gender>%@</gender>\n"
                    "<birthday>%@</birthday>\n"
                    "<password>%@</password>\n"
                    "<is_active>True</is_active>\n"
                    "<is_public>True</is_public>\n"
                    "<is_calendar_shared>True</is_calendar_shared>\n"
                    "<deviceid>None</deviceid>\n"
                    "<savedlocations>\n"
                        "<location>\n"
                            "<is_primary>True</is_primary>\n"
                            "<geocode>None</geocode>\n"
                            "<address>%@</address>\n"
                            "<city>%@</city>\n"
                            "<state>%@</state>\n"
                            "<zipcode>%@</zipcode>\n"
                            "<country>%@</country>\n"
                        "</location>\n"
                    "</savedlocations>\n"
                  "</useraccount>",regObj.strEmail,regObj.strUserName,regObj.strFirstName,regObj.strLastName,regObj.strGender,regObj.strBirthDay,regObj.strPaswd,regObj.address,regObj.city,regObj.state,regObj.zipcode,regObj.country];
    
	NSLog(@"%@",strSoapMsg);
	NSString *msgLength = [NSString stringWithFormat:@"%i", [strSoapMsg length]];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSDateFormatter *dtf = [[NSDateFormatter alloc]init];
    [dtf setDateFormat:@"EEE, dd MMM yyyy HH:MM:SS"];
    NSString *strdt = [dtf stringFromDate:[NSDate date]];
    [dtf release];
	
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	//[myRequest addValue:@"Fiddler" forHTTPHeaderField:@"User-Agent"];
	//[myRequest addValue:@"5.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"]; 
 	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [myRequest addValue:strdt forHTTPHeaderField:@"Date"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[myRequest setHTTPMethod:@"POST"];
    
    [myRequest setHTTPBody:[strSoapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	 NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	
	[con release];
	[myURL release];
	[newstr release];
	[strSoapMsg release];
    [myRequest release];
	return [self doParsing];
}

static const char *kmessageElementName = "message";
static NSUInteger kmessageElementNameLength = 8; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength))
    {
		currentObject = [[ServiceOutput alloc] init];
 		self.currentValue = [NSMutableString string];
    }
	else
		self.currentValue = [NSMutableString string];
 }

- (void)charactersFound:(const xmlChar *)characters length:(int)length
{
	NSString *value = [[NSString alloc] initWithBytes:(const void *)characters length:length encoding:NSUTF8StringEncoding];
	[self.currentValue appendString:value];
	[value release];
}

- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI
{
	if(0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength))
    {
		 currentObject.responseStringfromWeb = self.currentValue;
    }
	self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(RegistrationXML_Finished:)withObject:currentObject waitUntilDone:YES];
	[self autorelease];
}

- (void)RegistrationXML_Error:(RegistrationXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object
{
	[(id)[self delegate] RegistrationXML_Error:self encounteredError:error with:currentObject];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end