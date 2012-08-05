#import "UserXML.h"
#import "UserBO.h"
#import "UserAssociationBO.h"


@interface UserXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation UserXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;
@synthesize currentLocationObject;
@synthesize currentAssociationObject;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	arrData = [[NSMutableArray alloc] init];
	dtFormat = [[NSDateFormatter alloc] init];
	[dtFormat setDateFormat:Ga2ooDateFormatXML];
   
	NSString *newstr = [NSString stringWithFormat:@"%@%i", Ga2ooUserXML, userId];
    NSLog(@"useinfourl %@",newstr);
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	return [self doParsing];
}


//static const char *kZipcodeElementName = "currentzip";
//static NSUInteger kZipcodeElementNameLength = 10; 

static const char *kUsernameElementName = "username";
static NSUInteger kUsernameElementNameLength = 9; 

static const char *kUserIdElementName = "id";
static NSUInteger kUserIdElementNameLength = 3; 

static const char *kUserElementName = "useraccount";
static NSUInteger kUserElementNameLength = 12; 

static const char *kPasswordElementName = "password";
static NSUInteger kPasswordElementNameLength = 9; 

static const char *kModifiedOnElementName = "ModifiedOn";
static NSUInteger kModifiedOnElementNameLength = 11; 

static const char *kModifiedByElementName = "ModifiedBy";
static NSUInteger kModifiedByElementNameLength = 11; 

static const char *kLastnameElementName = "lastname";
static NSUInteger kLastnameElementNameLength = 9; 

static const char *kIsPublicElementName = "is_public";
static NSUInteger kIsPublicElementNameLength = 10; 

static const char *kIsCalenderSharedElementName = "is_calendar_shared";
static NSUInteger kIsCalenderSharedElementNameLength = 19; 

static const char *kIsActiveElementName = "is_active";
static NSUInteger kIsActiveElementNameLength = 10; 

static const char *kInvisiblemodeElementName = "Invisiblemode";
static NSUInteger kInvisiblemodeElementNameLength = 14; 

static const char *kImageElementName = "img";
static NSUInteger kImageElementNameLength = 4; 

static const char *kGenderElementName = "gender";
static NSUInteger kGenderElementNameLength = 7; 

static const char *kFirstnameElementName = "firstname";
static NSUInteger kFirstnameElementNameLength = 10; 

static const char *kEmailElementName = "email";
static NSUInteger kEmailElementNameLength = 6; 

static const char *kDeviceIdElementName = "deviceid";
static NSUInteger kDeviceIdElementNameLength = 9; 

static const char *kCreatedOnElementName = "CreatedOn";
static NSUInteger kCreatedOnElementNameLength = 10; 

static const char *kCreatedByElementName = "CreatedBy";
static NSUInteger kCreatedByElementNameLength = 10; 

static const char *kBirthdayElementName = "birthday";
static NSUInteger kBirthdayElementNameLength = 9;

////////////////////


static const char *kLocationElementName = "location";
static NSUInteger kLocationElementNameLength = 9; 
 
static const char *kStateElementName = "state";
static NSUInteger kStateElementNameLength = 6; 

 
static const char *kIsPrimaryElementName = "is_primary";
static NSUInteger kIsPrimaryElementNameLength = 10; 

static const char *kGeoPointElementName = "geocode";
static NSUInteger kGeoPointElementNameLength = 9; 
  

static const char *kCountryElementName = "country";
static NSUInteger kCountryElementNameLength = 8; 

static const char *kCityElementName = "city";
static NSUInteger kCityElementNameLength = 5; 

static const char *kAddressElementName = "address";
static NSUInteger kAddressElementNameLength = 8; 

static const char *kZipcodeElementName = "zipcode";
static NSUInteger kZipcodeElementNameLength = 8; 
 

static const char *kassociationElementName = "association";
static NSUInteger kassociationElementNameLength = 12; 

static const char *kassociationtypeElementName = "associationtype";
static NSUInteger kassociationtypeElementNameLength = 16; 

static const char *kassociationidElementName = "associationid";
static NSUInteger kassociationidElementNameLength = 14; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kUserElementName, kUserElementNameLength))
	{
		currentObject = [[UserBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kUsernameElementName, kUsernameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kPasswordElementName, kPasswordElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kLastnameElementName, kLastnameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsPublicElementName, kIsPublicElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsCalenderSharedElementName, kIsCalenderSharedElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kInvisiblemodeElementName, kInvisiblemodeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
		self.currentValue = [NSMutableString string];
		NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
		currentObject.UserImage = [dictAttributes valueForKey:@"src"];
	}
	else if(0 == strncmp((const char *)localname, kGenderElementName, kGenderElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kFirstnameElementName, kFirstnameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kEmailElementName, kEmailElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kDeviceIdElementName, kDeviceIdElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kBirthdayElementName, kBirthdayElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kLocationElementName, kLocationElementNameLength))
	{
		self.currentLocationObject = [[UserLocationBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kassociationElementName, kassociationElementNameLength))
	{
		self.currentAssociationObject = [[UserAssociationBO alloc] init];
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
	if(0 == strncmp((const char *)localname, kUserElementName, kUserElementNameLength))
	{
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	//else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
//	{
//		currentObject.Zipcode = self.currentValue;
//	}
	else if(0 == strncmp((const char *)localname, kUsernameElementName, kUsernameElementNameLength))
	{
		currentObject.Username = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		if (currentLocationObject) {
			currentLocationObject.LocationId=self.currentValue;
		}
		else if(currentAssociationObject){
			currentAssociationObject.AssociationUserId =self.currentValue;
 		}
		else {
			currentObject.UserId = self.currentValue;
 		}


	}
	else if(0 == strncmp((const char *)localname, kPasswordElementName, kPasswordElementNameLength))
	{
		currentObject.Password = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		currentObject.ModifiedOn = [dtFormat dateFromString:self.currentValue];
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kLastnameElementName, kLastnameElementNameLength))
	{
		currentObject.Lastname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsPublicElementName, kIsPublicElementNameLength))
	{
		currentObject.IsPublic = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsCalenderSharedElementName, kIsCalenderSharedElementNameLength))
	{
		currentObject.IsCalenderShared = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		currentObject.IsActive = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kInvisiblemodeElementName, kInvisiblemodeElementNameLength))
	{
		currentObject.Invisiblemode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kGenderElementName, kGenderElementNameLength))
	{
		currentObject.Gender = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kFirstnameElementName, kFirstnameElementNameLength))
	{
		currentObject.Firstname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEmailElementName, kEmailElementNameLength))
	{
		currentObject.Email = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kDeviceIdElementName, kDeviceIdElementNameLength))
	{
		currentObject.DeviceId = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		currentObject.CreatedOn = [dtFormat dateFromString:self.currentValue];
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		currentObject.CreatedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kBirthdayElementName, kBirthdayElementNameLength))
	{
		currentObject.Birthday = [dtFormat dateFromString:self.currentValue];
	}
	
	/////////
	else if(0 == strncmp((const char *)localname, kLocationElementName, kLocationElementNameLength))
	{
		currentLocationObject.UserId = currentObject.UserId;
		[currentObject.arrUserLocations addObject:currentLocationObject];
		[currentLocationObject release];
		currentLocationObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
	{
		currentLocationObject.Zipcode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kStateElementName, kStateElementNameLength))
	{
		currentLocationObject.State = self.currentValue;
	}
 	else if(0 == strncmp((const char *)localname, kIsPrimaryElementName, kIsPrimaryElementNameLength))
	{
		currentLocationObject.IsPrimary = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kGeoPointElementName, kGeoPointElementNameLength))
	{
		currentLocationObject.GeoPoint = self.currentValue;
	}
 	else if(0 == strncmp((const char *)localname, kCountryElementName, kCountryElementNameLength))
	{
		currentLocationObject.Country = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCityElementName, kCityElementNameLength))
	{
		currentLocationObject.City = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
	{
		currentLocationObject.Address = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kassociationElementName, kassociationElementNameLength))
	{
		currentAssociationObject.UserId = currentObject.UserId;
  		[currentObject.arrUserAssociations addObject:currentAssociationObject];
		[currentAssociationObject release];
		currentAssociationObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kassociationtypeElementName, kassociationtypeElementNameLength))
	{
		currentAssociationObject.AssociationType = self.currentValue;

	}
	else if(0 == strncmp((const char *)localname, kassociationidElementName, kassociationidElementNameLength))
	{
		currentAssociationObject.AssociationId = self.currentValue;

	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	[dtFormat release];
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end
