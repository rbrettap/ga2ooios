#import "EventLocationXML.h"
#import "EventLocationBO.h"

@interface EventLocationXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation EventLocationXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize intEventID;

- (BOOL)parseWithLibXML2Parser{
	
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%@", Ga2ooEventLocation, intEventID];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblEventLocationElementName = "event";
 static NSUInteger ktblEventLocationElementNameLength = 17; 

static const char *kIdElementName = "id";
static NSUInteger kIdElementNameLength = 3; 

static const char *kLocationElementName = "location";
static NSUInteger kLocationElementNameLength = 9; 

static const char *kgeocodeElementName = "geocode";
static NSUInteger kgeocodeElementNameLength = 8; 

 static const char *kStateElementName = "state";
 static NSUInteger kStateElementNameLength = 6; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kLongitudeElementName = "Longitude";
 static NSUInteger kLongitudeElementNameLength = 10; 

 static const char *kLatitudeElementName = "Latitude";
 static NSUInteger kLatitudeElementNameLength = 9; 


 static const char *kGeoPointElementName = "zip";
 static NSUInteger kGeoPointElementNameLength = 4; 


 static const char *kEventIdElementName = "EventId";
 static NSUInteger kEventIdElementNameLength = 8; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 

 static const char *kCountryElementName = "Country";
 static NSUInteger kCountryElementNameLength = 8; 

 static const char *kCityElementName = "city";
 static NSUInteger kCityElementNameLength = 5; 

 static const char *kAddress2ElementName = "Address2";
 static NSUInteger kAddress2ElementNameLength = 9; 

 static const char *kAddress1ElementName = "Address1";
 static NSUInteger kAddress1ElementNameLength = 9; 

 static const char *kAddressElementName = "address";
 static NSUInteger kAddressElementNameLength = 8; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblEventLocationElementName, ktblEventLocationElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kLocationElementName, kLocationElementNameLength))
	{
		currentObject = [[EventLocationBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kStateElementName, kStateElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kLongitudeElementName, kLongitudeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kLatitudeElementName, kLatitudeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kGeoPointElementName, kGeoPointElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kCountryElementName, kCountryElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kCityElementName, kCityElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAddress2ElementName, kAddress2ElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAddress1ElementName, kAddress1ElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
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
	if(0 == strncmp((const char *)localname, kLocationElementName, kLocationElementNameLength))
	{
		[arrData addObject:currentObject];
		[currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		currentObject.Geocode = self.currentValue;
	}
	
	else if(0 == strncmp((const char *)localname, kStateElementName, kStateElementNameLength))
	{
		currentObject.State = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kLongitudeElementName, kLongitudeElementNameLength))
	{
		currentObject.Longitude = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kLatitudeElementName, kLatitudeElementNameLength))
	{
		currentObject.Latitude = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kIdElementName, kIdElementNameLength))
	{
		currentObject.Id = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kGeoPointElementName, kGeoPointElementNameLength))
	{
		currentObject.GeoPoint = self.currentValue;
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
	else if(0 == strncmp((const char *)localname, kCountryElementName, kCountryElementNameLength))
	{
		currentObject.Country = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCityElementName, kCityElementNameLength))
	{
		currentObject.City = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAddress2ElementName, kAddress2ElementNameLength))
	{
		currentObject.Address2 = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAddress1ElementName, kAddress1ElementNameLength))
	{
		currentObject.Address1 = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
	{
		currentObject.Address = self.currentValue;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventLocationXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventLocationXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] EventLocationXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end