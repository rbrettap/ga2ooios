#import "EventCategoryXML.h"
#import "CategoryBO.h"

@interface EventCategoryXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation EventCategoryXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];

	NSString *newstr = [[NSString alloc] initWithFormat:Ga2ooEventCategories];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *kcategoriesElementName = "categories";
 static NSUInteger kcategoriesElementNameLength = 11; 

 static const char *kcategoryElementName = "category";
 static NSUInteger kcategoryElementNameLength = 9; 

 static const char *kmaincategoryidElementName = "maincategoryid";
 static NSUInteger kmaincategoryidElementNameLength = 15; 

 static const char *kmaincategorynameElementName = "maincategoryname";
 static NSUInteger kmaincategorynameElementNameLength = 17; 

 static const char *kdate_updatedElementName = "date_updated";
 static NSUInteger kdate_updatedElementNameLength = 13; 

 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kcategoriesElementName, kcategoriesElementNameLength))
	{
		arrData = [[NSMutableArray alloc]init];
	}
	else if(0 == strncmp((const char *)localname, kcategoryElementName, kcategoryElementNameLength))
	{
		currentObject = [[CategoryBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kmaincategoryidElementName, kmaincategoryidElementNameLength))
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
	if(0 == strncmp((const char *)localname, kcategoryElementName, kcategoryElementNameLength))
	{
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kmaincategoryidElementName, kmaincategoryidElementNameLength))
	{
		 currentObject.maincategoryid = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kmaincategorynameElementName, kmaincategorynameElementNameLength))
	{
		currentObject.maincategoryname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kdate_updatedElementName, kdate_updatedElementNameLength))
	{
		currentObject.date_updated = self.currentValue;
	}
    self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventCategoryXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventCategoryXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] EventCategoryXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end