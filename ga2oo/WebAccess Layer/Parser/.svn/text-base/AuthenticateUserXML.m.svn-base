#import "AuthenticateUserXML.h"
#import "AuthenticateUserBO.h"


@interface AuthenticateUserXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation AuthenticateUserXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

@synthesize strSoapMsg;


- (BOOL)parseWithLibXML2Parser{
	
	currentObject = [[AuthenticateUserBO alloc] init];
	//currentObject.Result = -1;
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@",Ga200AuthUser];
	NSString *soapMsg = [[NSString alloc] initWithFormat:@"%@",self.strSoapMsg];
	NSString *msgLength = [NSString stringWithFormat:@"%i", [soapMsg length]];
	
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	[myRequest addValue:@"Fiddler" forHTTPHeaderField:@"User-Agent"];
	[myRequest addValue:@"3.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"];// 
	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	
	///////////////////////////////
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *dats = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	NSLog(@"The  error is  %@",[error description]);
	NSString *temstr = [[NSString alloc]initWithData:dats encoding:NSUTF8StringEncoding];
	NSLog(@"temstr %@",temstr);
	
	
	//////////////////////
	[con release];
	[myURL release];
	[newstr release];
	[soapMsg release];
    [temstr release];
    [myRequest release];
	return [self doParsing];
	

	
}

static const char *kUpdateTokenResponseElementName = "result";
static NSUInteger kUpdateTokenResponseElementNameLength = 7; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kUpdateTokenResponseElementName, kUpdateTokenResponseElementNameLength))
    {
		self.currentValue = [NSMutableString string];
    }
	else
 		 self.currentValue = nil;
}

- (void)charactersFound:(const xmlChar *)characters length:(int)length
{
	NSString *value = [[NSString alloc] initWithBytes:(const void *)characters length:length encoding:NSUTF8StringEncoding];
	[self.currentValue appendString:value];
	[value release];
}

- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI
{
	if(0 == strncmp((const char *)localname, kUpdateTokenResponseElementName, kUpdateTokenResponseElementNameLength))
    {
		if ([self.currentValue isEqualToString:[NSString stringWithFormat:@"%i",[self.currentValue integerValue]]]) {
			
			if ([self.currentValue isEqualToString:@"-1"] || [self.currentValue isEqualToString:@"-2"]) {
				currentObject.Response = self.currentValue;
 			}
			else {
				currentObject.UserId = self.currentValue ;
 			}
   		}
		else {
			currentObject.Response = @"Invalid";
		}
      }
	self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(AuthenticateUserXML_Finished:)withObject:currentObject waitUntilDone:YES];
	[self autorelease];
}

- (void)AuthenticateUserXML_Error:(AuthenticateUserXML*)parser encounteredError:(NSError *)error with:(AuthenticateUserBO *)Object
{
  	[(id)[self delegate] AuthenticateUserXML_Error:self encounteredError:error with:currentObject];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end