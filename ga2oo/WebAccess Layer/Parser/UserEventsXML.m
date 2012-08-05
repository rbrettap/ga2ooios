#import "UserEventsXML.h"
#import "UserEventsBO.h"


@interface UserEventsXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UserEventsXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;


- (BOOL)parseWithLibXML2Parser{
	
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *newstr = [[NSString alloc] initWithFormat:tblUserEvents];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblUserEventsElementName = "tblUserEvents";
 static NSUInteger ktblUserEventsElementNameLength = 14; 

 static const char *kUserIdElementName = "UserId";
 static NSUInteger kUserIdElementNameLength = 7; 

 static const char *kUserEventsElementName = "UserEvents";
 static NSUInteger kUserEventsElementNameLength = 11; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kIsPublicElementName = "IsPublic";
 static NSUInteger kIsPublicElementNameLength = 9; 

 static const char *kIsFavoriteElementName = "IsFavorite";
 static NSUInteger kIsFavoriteElementNameLength = 11; 

 static const char *kIsAttendingElementName = "IsAttending";
 static NSUInteger kIsAttendingElementNameLength = 12; 

 static const char *kIdElementName = "Id";
 static NSUInteger kIdElementNameLength = 3; 

 static const char *kEventIdElementName = "EventId";
 static NSUInteger kEventIdElementNameLength = 8; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 

 static const char *kBuyTicketsElementName = "BuyTickets";
 static NSUInteger kBuyTicketsElementNameLength = 11; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblUserEventsElementName, ktblUserEventsElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kUserEventsElementName, kUserEventsElementNameLength))
	{
		currentObject = [[UserEventsBO alloc] init];
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
	else if(0 == strncmp((const char *)localname, kIsPublicElementName, kIsPublicElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsFavoriteElementName, kIsFavoriteElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsAttendingElementName, kIsAttendingElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kEventIdElementName, kEventIdElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kBuyTicketsElementName, kBuyTicketsElementNameLength))
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
	if(0 == strncmp((const char *)localname, kUserEventsElementName, kUserEventsElementNameLength))
	{
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		currentObject.UserId = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kIsPublicElementName, kIsPublicElementNameLength))
	{
		//currentObject.IsPublic = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsFavoriteElementName, kIsFavoriteElementNameLength))
	{
		//currentObject.IsFavorite = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsAttendingElementName, kIsAttendingElementNameLength))
	{
		//currentObject.IsAttending = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		currentObject.Id = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kEventIdElementName, kEventIdElementNameLength))
	{
		currentObject.EventId = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		//currentObject.CreatedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		currentObject.CreatedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kBuyTicketsElementName, kBuyTicketsElementNameLength))
	{
		//currentObject.BuyTickets = self.currentValue;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserEventsXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserEventsXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserEventsXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end