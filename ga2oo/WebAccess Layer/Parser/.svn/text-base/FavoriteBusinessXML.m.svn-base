#import "FavoriteBusinessXML.h"
#import "FavoriteBusinessBO.h"


@interface FavoriteBusinessXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation FavoriteBusinessXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;


- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%@", Ga2ooFavBusiness, appDelegate.currentUserID];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	[newstr release];
	return [self doParsing];
}



 static const char *kidElementName = "id";
 static NSUInteger kidElementNameLength = 3; 

 static const char *kfav_businessesElementName = "fav_businesses";
 static NSUInteger kfav_businessesElementNameLength = 15; 

 static const char *kbusinessElementName = "business";
 static NSUInteger kbusinessElementNameLength = 9; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kfav_businessesElementName, kfav_businessesElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		currentObject = [[FavoriteBusinessBO alloc] init];
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
	if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		currentObject.id = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(FavoriteBusinessXML_Finished:)withObject:arrData waitUntilDone:YES];
	[self autorelease];
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] FavoriteBusinessXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end