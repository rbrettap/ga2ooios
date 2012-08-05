#import "Ga2ooUsersXML.h"
#import "Ga2ooUserBO.h"


@interface Ga2ooUsersXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation Ga2ooUsersXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;


- (BOOL)parseWithLibXML2Parser{
	 
 
  	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *newstr = [NSString stringWithFormat:@"%@", Ga2ooAllUsersList];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
 
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	
	///////////////////////////////
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *dats = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	NSLog(@"The  error is  %@",[error description]);
	NSString *temstr = [[NSString alloc]initWithData:dats encoding:NSUTF8StringEncoding];
	NSLog(@"temstr %@",temstr);
	   
    [temstr release];
	[con release];
	[myURL release];
	return [self doParsing];
}


  
static const char *kuseraccountsElementName = "useraccounts";
static NSUInteger kuseraccountsElementNameLength = 13; 

static const char *kuseraccountElementName = "useraccount";
static NSUInteger kuseraccountElementNameLength = 12; 

static const char *kidElementName = "id";
static NSUInteger kidElementNameLength = 3; 

static const char *kusernameElementName = "username";
static NSUInteger kusernameElementNameLength = 9; 

static const char *kemailElementName = "email";
static NSUInteger kemailElementNameLength = 6; 


 static const char *kfirstnameElementName = "firstname";
static NSUInteger kfirstnameElementNameLength = 10; 

static const char *klastnameElementName = "lastname";
static NSUInteger klastnameElementNameLength = 9; 



static const char *kisactiveElementName = "is_active";
static NSUInteger kisactiveElementNameLength = 10; 

static const char *kispublicElementName = "is_public";
static NSUInteger kispublicElementNameLength = 10; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kuseraccountsElementName, kuseraccountsElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kuseraccountElementName, kuseraccountElementNameLength))
	{
		currentObject = [[Ga2ooUserBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
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
	if(0 == strncmp((const char *)localname, kuseraccountElementName, kuseraccountElementNameLength))
	{
 		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
 
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		currentObject.ga2ooUserId = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kusernameElementName, kusernameElementNameLength))
	{
		currentObject.ga2ooUserName = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kemailElementName, kemailElementNameLength))
	{
		currentObject.ga2ooUserEmail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kfirstnameElementName, kfirstnameElementNameLength))
	{
		currentObject.ga2ooUserFirstName = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, klastnameElementName, klastnameElementNameLength))
	{
		currentObject.ga2ooUserLastName = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kisactiveElementName, kisactiveElementNameLength))
	{
		currentObject.ga2ooUserIs_active = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kispublicElementName, kispublicElementNameLength))
	{
		currentObject.ga2ooUserIs_public = self.currentValue;
	}
    
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(Ga2ooUsersXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(Ga2ooUsersXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] Ga2ooUsersXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[arrData release];
	arrData = nil;
	[super dealloc];
}

@end
