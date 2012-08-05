#import "UpdateProfileXML.h"
#import "UpdateProfileBO.h"

@interface UpdateProfileXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UpdateProfileXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;
@synthesize strSoapMsg;

- (BOOL)parseWithLibXML2Parser{

	currentObject = [[UpdateProfileBO alloc] init];
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@",Ga200UpdateUSer];
	NSString *soapMsg = [[NSString alloc] initWithFormat:@"%@",self.strSoapMsg];
	NSString *msgLength = [NSString stringWithFormat:@"%i", [soapMsg length]];
	
	NSDateFormatter *dtf = [[NSDateFormatter alloc]init];
    [dtf setDateFormat:@"EEE, dd MMM yyyy HH:MM:SS"];
    NSString *strdt = [dtf stringFromDate:[NSDate date]];
    [dtf release];

	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	//[myRequest addValue:@"Fiddler" forHTTPHeaderField:@"User-Agent"];
	//[myRequest addValue:@"5.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"];
	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[myRequest addValue:strdt forHTTPHeaderField:@"Date"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	
	
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *dats = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	NSLog(@"The  error is  %@",[error description]);
	NSString *temstr = [[NSString alloc]initWithData:dats encoding:NSUTF8StringEncoding];
	NSLog(@"temstr --%@--",temstr);
	
	NSLog(@"newstr , %@",newstr);
    NSLog(@"temstr %@",soapMsg);
    NSLog(@"newstr , %@",msgLength);
	
	
	[temstr release];
	[con release];
	[myURL release];
	[newstr release];
	[soapMsg release];
    [myRequest release];
	return [self doParsing];
}

static const char *kcodeResponseElementName = "code";
static NSUInteger kcodeResponseElementNameLength = 5; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kcodeResponseElementName, kcodeResponseElementNameLength))
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
	if(0 == strncmp((const char *)localname, kcodeResponseElementName, kcodeResponseElementNameLength))
    {
		currentObject.Result = [self.currentValue integerValue];
    }
	self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(UpdateProfileXML_Finished:)withObject:currentObject waitUntilDone:YES];
	[self autorelease];
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UpdateProfileXML_Error:self encounteredError:err with:currentObject];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end