#import "UserAssociationXML.h"
#import "UserAssociationBO.h"


@interface UserAssociationXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UserAssociationXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%i",Ga2ooUserXML, self.userId];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblUserAssociationElementName = "useraccount";
 static NSUInteger ktblUserAssociationElementNameLength = 12; 

 static const char *kUserIdElementName = "UserId";
 static NSUInteger kUserIdElementNameLength = 7; 

 static const char *kUserAssociationssElementName = "associations";
 static NSUInteger kUserAssociationssElementNameLength = 13; 

static const char *kUserAssociationElementName = "association";
static NSUInteger kUserAssociationElementNameLength = 12; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 

 static const char *kAssociationTypeElementName = "associationtype";
 static NSUInteger kAssociationTypeElementNameLength = 16; 

 static const char *kAssociationIdElementName = "associationid";
 static NSUInteger kAssociationIdElementNameLength = 14; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblUserAssociationElementName, ktblUserAssociationElementNameLength))
	{
		
	}
	else if(0 == strncmp((const char *)localname, kUserAssociationssElementName, kUserAssociationssElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kUserAssociationElementName, kUserAssociationElementNameLength))
	{
		currentObject = [[UserAssociationBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAssociationTypeElementName, kAssociationTypeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAssociationIdElementName, kAssociationIdElementNameLength))
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
	if(0 == strncmp((const char *)localname, kUserAssociationElementName, kUserAssociationElementNameLength))
	{
		[arrData addObject:currentObject];
		[currentObject release];
		currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		//currentObject.CreatedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		currentObject.CreatedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kAssociationTypeElementName, kAssociationTypeElementNameLength))
	{
		currentObject.AssociationType = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAssociationIdElementName, kAssociationIdElementNameLength))
	{
		currentObject.AssociationId = self.currentValue;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserAssociationXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserAssociationXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserAssociationXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end