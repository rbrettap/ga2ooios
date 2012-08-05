#import "UserInboxXML.h"
#import "UserInboxBO.h"

@interface UserInboxXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UserInboxXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSString *newstr = [[NSString alloc] initWithFormat:tblUserInbox];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblUserInboxElementName = "tblUserInbox";
 static NSUInteger ktblUserInboxElementNameLength = 13; 

 static const char *kUserInboxElementName = "UserInbox";
 static NSUInteger kUserInboxElementNameLength = 10; 

 static const char *kThreadidElementName = "Threadid";
 static NSUInteger kThreadidElementNameLength = 9; 

 static const char *kSubjectElementName = "Subject";
 static NSUInteger kSubjectElementNameLength = 8; 

 static const char *kSenderElementName = "Sender";
 static NSUInteger kSenderElementNameLength = 7; 

 static const char *kReceiverElementName = "Receiver";
 static NSUInteger kReceiverElementNameLength = 9; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kMessageElementName = "Message";
 static NSUInteger kMessageElementNameLength = 8; 

 static const char *kIsReadElementName = "IsRead";
 static NSUInteger kIsReadElementNameLength = 7; 

 static const char *kIdElementName = "Id";
 static NSUInteger kIdElementNameLength = 3; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblUserInboxElementName, ktblUserInboxElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kUserInboxElementName, kUserInboxElementNameLength))
	{
		currentObject = [[UserInboxBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kThreadidElementName, kThreadidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kSubjectElementName, kSubjectElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kSenderElementName, kSenderElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kReceiverElementName, kReceiverElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kMessageElementName, kMessageElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
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
	if(0 == strncmp((const char *)localname, kUserInboxElementName, kUserInboxElementNameLength))
	{
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kThreadidElementName, kThreadidElementNameLength))
	{
		currentObject.Threadid = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kSubjectElementName, kSubjectElementNameLength))
	{
		currentObject.Subject = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kSenderElementName, kSenderElementNameLength))
	{
		currentObject.Sender = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kReceiverElementName, kReceiverElementNameLength))
	{
		currentObject.Receiver = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kMessageElementName, kMessageElementNameLength))
	{
		currentObject.Message = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
	{
		currentObject.IsRead = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		currentObject.Id = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		//currentObject.CreatedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		currentObject.CreatedBy = [self.currentValue integerValue];
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserInboxXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserInboxXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserInboxXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end