



#import "EventsXML.h"
#import "EventsBO.h"


@interface EventsXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation EventsXML

 

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize EventID;
@synthesize currentImageObj;
@synthesize arrImages;



- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	arrData = [[NSMutableArray alloc]init];
	dtFormat = [[NSDateFormatter alloc] init];
	[dtFormat setDateFormat:dateFormatXMLEvent];
    arrImages= [[NSMutableArray alloc]init];

    isBussiness = NO;
    isEventImage = NO;
    isEventId = YES;
    
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%@",Ga2ooEvent,EventID];
    
    NSLog(@"%@",newstr);
    
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}



 static const char *keventElementName = "event";
 static NSUInteger keventElementNameLength = 6; 

static const char *kEventIdElementName = "id";
static NSUInteger kEventIdElementNameLength = 3;

static const char *kEventNameElementName = "name";
static NSUInteger kEventNameElementNameLength = 5; 
 
static const char *kDescriptionElementName = "description";
static NSUInteger kDescriptionElementNameLength = 12; 

 static const char *kTicketsElementName = "tickets";
 static NSUInteger kTicketsElementNameLength = 8; 

static const char *ksupportemailElementName = "supportemail";
static NSUInteger ksupportemailElementNameLength = 13; 

static const char *ksupportphoneElementName = "supportphone";
static NSUInteger ksupportphoneElementNameLength = 13; 


static const char *kEventStartDateElementName = "event_start_date";
static NSUInteger kEventStartDateElementNameLength = 17; 

static const char *kEventEndDateElementName = "event_end_date";
static NSUInteger kEventEndDateElementNameLength = 15; 

static const char *kEventStartTimeElementName = "event_start_time";
static NSUInteger kEventStartTimeElementNameLength = 17; 

static const char *kEventEndTimeElementName = "event_end_time";
static NSUInteger kEventEndTimeElementNameLength = 15; 

static const char *kEventExpirationElementName = "event_expiration";
static NSUInteger kEventExpirationElementNameLength = 17; 

static const char *kIsFeaturedElementName = "is_featured";
static NSUInteger kIsFeaturedElementNameLength = 12; 

 static const char *kPriceElementName = "price";
 static NSUInteger kPriceElementNameLength = 6; 

 static const char *kLikeCountElementName = "likecount";
 static NSUInteger kLikeCountElementNameLength = 10; 

static const char *kga2oometerElementName = "ga2oometer";
static NSUInteger kga2oometerElementNameLength = 11; 
 
static const char *kBusinessIdElementName = "business";
static NSUInteger kBusinessIdElementNameLength = 9; 

static const char *kIsActiveElementName = "status";
static NSUInteger kIsActiveElementNameLength = 7; 

static const char *kImagesElementName = "images";
static NSUInteger kImagesElementNameLength = 7; 

static const char *kImageElementName = "image";
static NSUInteger kImageElementNameLength = 6; 

static const char *kimgElementName = "img";
static NSUInteger kimgElementNameLength = 4; 
 
static const char *klocationElementName = "location";
static NSUInteger klocationElementNameLength = 9; 


static const char *kgeocodeElementName = "geocode";
static NSUInteger kgeocodeElementNameLength = 8; 

static const char *kAddressElementName = "address";
static NSUInteger kAddressElementNameLength = 8; 

static const char *kcityElementName = "city";
static NSUInteger kcityElementNameLength = 5; 

static const char *kstateElementName = "state";
static NSUInteger kstateElementNameLength = 6; 

static const char *kzipElementName = "zipcode";
static NSUInteger kzipElementNameLength = 8; 

static const char *kcountryElementName = "Country";
static NSUInteger kcountryElementNameLength = 8; 



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
		 currentObject = [[EventsBO alloc]init];
	}
	else if(0 == strncmp((const char *)localname, kTicketsElementName, kTicketsElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kPriceElementName, kPriceElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
    else if(0 == strncmp((const char *)localname, kImagesElementName, kImagesElementNameLength))
	{
 		self.currentValue = [NSMutableString string];
        isEventImage = YES;
	}
    else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
        if (isEventImage) {

        currentImageObj = [[EventImagesBO alloc]init];
        NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
		currentImageObj.isMain = [[dictAttributes valueForKey:@"main"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
	}
    else if(0 == strncmp((const char *)localname , kimgElementName, kimgElementNameLength))
	{
        if (isEventImage) {

		NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
		currentImageObj.imageUrl = [[dictAttributes valueForKey:@"src"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            currentImageObj.imageUrl = [currentImageObj.imageUrl stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];

        }
    }

 	else if(0 == strncmp((const char *)localname, kBusinessIdElementName, kBusinessIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
        isBussiness = YES;
	}
	else if(0 == strncmp((const char *)localname, klocationElementName, klocationElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kcityElementName, kcityElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kstateElementName, kstateElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kzipElementName, kzipElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
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
	if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
        self.currentObject.arrEventImages =  arrImages;
        [arrData addObject:self.currentObject];
        
        [currentObject release];
        currentObject = nil;
	}
    else if(0 == strncmp((const char *)localname, kEventIdElementName, kEventIdElementNameLength))
	{
        if (isBussiness) {
            currentObject.BusinessId = self.currentValue;
            isBussiness=NO;

         }
        else if(isEventId){
            currentObject.EventId = self.currentValue;
            isEventId=NO;
         }
	}
    

	else if(0 == strncmp((const char *)localname, kTicketsElementName, kTicketsElementNameLength))
	{
		currentObject.tickets = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kPriceElementName, kPriceElementNameLength))
	{
		currentObject.price = self.currentValue;
	}
 	else if(0 == strncmp((const char *)localname, kLikeCountElementName, kLikeCountElementNameLength))
	{
		currentObject.likecount = self.currentValue ;
	}
	else if(0 == strncmp((const char *)localname, kIsFeaturedElementName, kIsFeaturedElementNameLength))
	{
		currentObject.is_featured = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		 currentObject.status = self.currentValue;
	}
 
	else if(0 == strncmp((const char *)localname, kEventStartTimeElementName, kEventStartTimeElementNameLength))
	{
		
		NSArray *TempTime = [self.currentValue componentsSeparatedByString:@":"];
		
		if([TempTime count]>=2)
		{
			currentObject.event_start_time = [NSString stringWithFormat:@"%@:%@",[TempTime objectAtIndex:0],[TempTime objectAtIndex:1]];
		}
		
		
	}
	else if(0 == strncmp((const char *)localname, kEventStartDateElementName, kEventStartDateElementNameLength))
	{
		currentObject.event_start_date = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kEventExpirationElementName, kEventExpirationElementNameLength))
	{
		currentObject.event_expiration =self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEventEndTimeElementName, kEventEndTimeElementNameLength))
	{
		currentObject.event_end_time = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEventEndDateElementName, kEventEndDateElementNameLength))
	{
		currentObject.event_end_date = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEventNameElementName, kEventNameElementNameLength))
	{
		currentObject.name = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kDescriptionElementName, kDescriptionElementNameLength))
	{
		currentObject.Description = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kga2oometerElementName, kga2oometerElementNameLength))
	{
		currentObject.ga2oometer = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, ksupportemailElementName, ksupportemailElementNameLength))
	{
		currentObject.supportemail = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, ksupportphoneElementName, ksupportphoneElementNameLength))
	{
		currentObject.supportphone = self.currentValue;
	}
    else if(0 == strncmp((const char *)localname, kImagesElementName, kImagesElementNameLength))
	{
        isEventImage = NO;
 	}
    else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
        if (isEventImage) {
            currentImageObj.eventId = currentObject.EventId;
             [arrImages addObject:self.currentImageObj];
            [currentImageObj release];
            currentImageObj = nil;
        }
 	}
	
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		currentObject.strGeocode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAddressElementName, kAddressElementNameLength))
	{
		currentObject.strAddress = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcityElementName, kcityElementNameLength))
	{
		currentObject.strcity = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kstateElementName, kstateElementNameLength))
	{
		currentObject.strState = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kzipElementName, kzipElementNameLength))
	{
		currentObject.strZipcode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
	{
		currentObject.strCountry = self.currentValue;
	}
	
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventsXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventsXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	if([[self delegate]retainCount])
	{
		[(id)[self delegate] EventsXML_Error:self encounteredError:err];
	}
}

- (void)dealloc
{
	[dtFormat release];
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end