#import "UserLocationXML.h"
#import "UserLocationBO.h"


@interface UserLocationXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UserLocationXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;


- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSString *newstr = [NSString stringWithFormat:@"%@%@", Ga2ooUserLocation, appDelegate.currentUserID];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	return [self doParsing];
}


 static const char *kZipcodeElementName = "zip";
 static NSUInteger kZipcodeElementNameLength = 4; 

 static const char *kUserLocationElementName = "useraccount";
 static NSUInteger kUserLocationElementNameLength = 12; 

static const char *kSavedLocationsElementName = "savedlocations";
static NSUInteger kSavedLocationsElementNameLength = 15; 

static const char *kLocationElementName = "location";
static NSUInteger kLocationElementNameLength = 9; 

 static const char *kUserIdElementName = "id";
 static NSUInteger kUserIdElementNameLength = 3; 

 static const char *kStateElementName = "state";
 static NSUInteger kStateElementNameLength = 6; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kIsPrimaryElementName = "is_primary";
 static NSUInteger kIsPrimaryElementNameLength = 10; 

 static const char *kGeoPointElementName = "geocode";
 static NSUInteger kGeoPointElementNameLength = 9; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 

 static const char *kCountryElementName = "country";
 static NSUInteger kCountryElementNameLength = 8; 

 static const char *kCityElementName = "city";
 static NSUInteger kCityElementNameLength = 5; 

 static const char *kAddressElementName = "address";
 static NSUInteger kAddressElementNameLength = 8; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kUserLocationElementName, kUserLocationElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	
	else if(0 == strncmp((const char *)localname, kSavedLocationsElementName, kSavedLocationsElementNameLength))
	{
	}
	else if(0 == strncmp((const char *)localname, kLocationElementName, kLocationElementNameLength))
	{
		currentObject = [[UserLocationBO alloc] init];
	}
	
	else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kStateElementName, kStateElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kIsPrimaryElementName, kIsPrimaryElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kGeoPointElementName, kGeoPointElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
	{
		currentObject.Zipcode = self.currentValue;
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
	else if(0 == strncmp((const char *)localname, kIsPrimaryElementName, kIsPrimaryElementNameLength))
	{
		currentObject.IsPrimary = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kGeoPointElementName, kGeoPointElementNameLength))
	{
		currentObject.GeoPoint = self.currentValue;
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
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
	{
		currentObject.Address = self.currentValue;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserLocationXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserLocationXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserLocationXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end