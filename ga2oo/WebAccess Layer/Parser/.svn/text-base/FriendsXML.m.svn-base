#import "FriendsXML.h"
#import "FriendsBO.h"


@interface FriendsXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation FriendsXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

static int ShouldAdd;


- (BOOL)parseWithLibXML2Parser{
	 
 
  	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *newstr = [NSString stringWithFormat:@"%@%@", Ga2ooFriendsList, appDelegate.currentUserID];
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


//static const char *kParentElementNameElementName="";
 
static const char *kfriendshipsElementName = "friendships";
static NSUInteger kfriendshipsElementNameLength = 11; 

static const char *kfriendElementName = "friend";
static NSUInteger kfriendElementNameLength = 7; 

static const char *kidElementName = "useraddedfriendid";
static NSUInteger kidElementNameLength = 18; 

static const char *kfriendidElementName = "friendid";
static NSUInteger kfriendidElementNameLength = 9; 

static const char *kfirstnameElementName = "firstname";
static NSUInteger kfirstnameElementNameLength = 10; 

static const char *klastnameElementName = "lastname";
static NSUInteger klastnameElementNameLength = 9; 

static const char *kimgElementName = "img";
static NSUInteger kimgElementNameLength = 4; 

static const char *kemailElementName = "email";
static NSUInteger kemailElementNameLength = 6; 

static const char *kgeocodeElementName = "geocode";
static NSUInteger kgeocodeElementNameLength = 8; 

static const char *kaddressElementName = "address";
static NSUInteger kaddressElementNameLength = 8; 

static const char *kcityElementName = "city";
static NSUInteger kcityElementNameLength = 5; 

static const char *kstateElementName = "state";
static NSUInteger kstateElementNameLength = 6; 

static const char *kzipcodeElementName = "zipcode";
static NSUInteger kzipcodeElementNameLength = 8; 

static const char *kcountryElementName = "country";
static NSUInteger kcountryElementNameLength = 8; 

static const char *kstatusElementName = "status";
static NSUInteger kstatusElementNameLength = 6; 


static const char *kis_calendar_sharedElementName = "is_calendar_shared";
static NSUInteger kis_calendar_sharedElementNameLength = 19;



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kfriendshipsElementName, kfriendshipsElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kfriendElementName, kfriendElementNameLength))
	{
		currentObject = [[FriendsBO alloc] init];
		ShouldAdd = 1;
	}
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kfriendidElementName, kfriendidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kstatusElementName, kstatusElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
    else if(0 == strncmp((const char *)localname, kis_calendar_sharedElementName, kis_calendar_sharedElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
    
    if(0 == strncmp((const char *)localname, kimgElementName, kimgElementNameLength))
    {
         NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
        currentObject.imageUrl = [dictAttributes valueForKey:@"src"];
         
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
	if(0 == strncmp((const char *)localname, kfriendElementName, kfriendElementNameLength))
	{
		currentObject.UserId = appDelegate.currentUserID;
		if(ShouldAdd == 1)
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		currentObject.addedFriendId = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kfriendidElementName, kfriendidElementNameLength))
	{
		currentObject.FriendId = self.currentValue;
	}
	
	else if(0 == strncmp((const char *)localname, kstatusElementName, kstatusElementNameLength))
	{
		ShouldAdd = [self.currentValue integerValue] ;
	}
    else if(0 == strncmp((const char *)localname, kis_calendar_sharedElementName, kis_calendar_sharedElementNameLength))
	{
		currentObject.is_calendar_shared = self.currentValue;
	}
    
	
	else if(0 == strncmp((const char *)localname, kfirstnameElementName, kfirstnameElementNameLength))
	{
		currentObject.firstName = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, klastnameElementName, klastnameElementNameLength))
	{
		currentObject.lastName = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kemailElementName, kemailElementNameLength))
	{
		currentObject.email = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		currentObject.geocode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kaddressElementName, kaddressElementNameLength))
	{
		currentObject.address = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcityElementName, kcityElementNameLength))
	{
		currentObject.city = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kstateElementName, kstateElementNameLength))
	{
		currentObject.state = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
	{
		currentObject.country = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kzipcodeElementName, kzipcodeElementNameLength))
	{
		currentObject.zipcode = self.currentValue;
	}
	
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(FriendsXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(FriendsXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] FriendsXML_Error:self encounteredError:err];
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
