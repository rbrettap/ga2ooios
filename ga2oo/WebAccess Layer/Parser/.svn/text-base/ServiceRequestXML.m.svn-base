#import "ServiceRequestXML.h"
#import "AuthenticateUserBO.h"
#import "RegisterObject.h"
#import "ServiceOutput.h"

@interface ServiceRequestXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation ServiceRequestXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;
@synthesize strSoapMsg;
@synthesize regObj;
@synthesize arrRequest;


- (BOOL)parseWithLibXML2Parser{
	
	/*NSString *strUrl = [arrRequest objectAtIndex:0];
 	strSoapMsg =  [arrRequest objectAtIndex:1];
  	NSString *msgLength = [NSString stringWithFormat:@"%i", [strSoapMsg length]];
 	NSURL *myURL = [[NSURL alloc] initWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	[myRequest addValue:@"2011.07.13" forHTTPHeaderField:@"Date"];
 	[myRequest addValue:@"Fiddler" forHTTPHeaderField:@"User-Agent"];
	[myRequest addValue:@"5.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"];// 
	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[strSoapMsg dataUsingEncoding:NSUTF8StringEncoding]];
 
	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	NSLog(@"url ; %@",strSoapMsg);
	[con release];
	[myURL release];
 	//[strSoapMsg release];
	return [self doParsing];
	*/
	
	
	NSString *strUrl = [arrRequest objectAtIndex:0];
 	strSoapMsg =  [arrRequest objectAtIndex:1];
  	NSString *msgLength = [NSString stringWithFormat:@"%i", [strSoapMsg length]];
 	NSURL *myURL = [[NSURL alloc] initWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSDateFormatter *dtf = [[NSDateFormatter alloc]init];
	[dtf setDateFormat:@"EEE, dd MMM yyyy HH:MM:SS"];
	NSString *strdt = [dtf stringFromDate:[NSDate date]];
	[dtf release];
	
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	[myRequest addValue:strdt forHTTPHeaderField:@"Date"];
 	[myRequest addValue:@"Fiddler" forHTTPHeaderField:@"User-Agent"];
	[myRequest addValue:@"5.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"];// 
	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[strSoapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	NSLog(@"url ; %@ , %@",strUrl, strSoapMsg);
	[con release];
	[myURL release];
    [myRequest release];
 	//[strSoapMsg release];
	return [self doParsing];
	
	
}

static const char *kresultElementName = "result";
static NSUInteger kresultElementNameLength = 7; 

static const char *kmessageElementName = "message";
static NSUInteger kmessageElementNameLength = 8; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kresultElementName, kresultElementNameLength))
    {
		currentObject = [[ServiceOutput alloc] init];
 		self.currentValue = [NSMutableString string];
    }
	else if(0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength))
	{
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
	if(0 == strncmp((const char *)localname, kresultElementName, kresultElementNameLength))
    {
		 //currentObject.responseStringfromWeb = self.currentValue;
		if([currentObject.responseStringfromWeb length]<3)
		{
			
		  currentObject.responseStringfromWeb = self.currentValue;
		}
    }
	
	else if(0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength))
	{
		 currentObject.responseStringfromWeb = self.currentValue;
	}
	
	self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(ServiceRequestXML_Finished:)withObject:currentObject waitUntilDone:YES];
	[self autorelease];
}

- (void)ServiceRequestXML_Error:(ServiceRequestXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object
{
	[(id)[self delegate] ServiceRequestXML_Error:self encounteredError:error with:currentObject];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end
