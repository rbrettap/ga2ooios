#import "EventListXML.h"
#import "EventListBO.h"

@interface EventListXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation EventListXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize currentEventCatObject;
@synthesize strID;
@synthesize ModeType;
@synthesize Str_date;
@synthesize str_category;
@synthesize str_type;

- (BOOL)parseWithLibXML2Parser
{
	
	 isEventImage = NO;
	arrCats = [[NSMutableArray alloc]init];
	self.strID =  [[[NSString alloc] initWithFormat:@""] retain];
    
    NSString *newstr =  [[NSString alloc] initWithFormat:@""];
    
    if(ModeType==GetEventList)
    {
        newstr = [[NSString alloc] initWithFormat:Ga2ooEventList];
    }
    else if(ModeType==GetBydate)
    {
        newstr = [[NSString alloc] initWithFormat:Ga2ooEventFilterBydate,Str_date];
    }
    else if(ModeType==GetBycategory)
    {
        newstr = [[NSString alloc] initWithFormat:Ga2ooEventFilterBycategory,str_category];
    }
    else if(ModeType==GetBydate_Category)
    {
        newstr = [[NSString alloc] initWithFormat:Ga2ooEventFilterBydate_Category,Str_date,str_category];
    }
    else if(ModeType==GetBycategory_dateBysortOption)
    {
        newstr = [[NSString alloc] initWithFormat:Ga2ooEventFilterBycategory_dateBysortOption,str_category,Str_date,str_type];
    }
    
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


 static const char *kuserElementName = "user";
 static NSUInteger kuserElementNameLength = 5; 

 static const char *kstatusElementName = "status";
 static NSUInteger kstatusElementNameLength = 7; 

 static const char *kpriceElementName = "price";
 static NSUInteger kpriceElementNameLength = 6; 

 static const char *knameElementName = "name";
 static NSUInteger knameElementNameLength = 5; 

 static const char *klikecountElementName = "likecount";
 static NSUInteger klikecountElementNameLength = 10; 

 static const char *kis_featuredElementName = "is_featured";
 static NSUInteger kis_featuredElementNameLength = 12; 

 static const char *kidElementName = "id";
 static NSUInteger kidElementNameLength = 3; 

static const char *keventidElementName = "eventid";
static NSUInteger keventidElementNameLength = 8;


 static const char *keventsElementName = "events";
 static NSUInteger keventsElementNameLength = 7; 

 static const char *kevent_start_timeElementName = "event_start_time";
 static NSUInteger kevent_start_timeElementNameLength = 17; 

 static const char *kevent_start_dateElementName = "event_start_date";
 static NSUInteger kevent_start_dateElementNameLength = 17; 

 static const char *kevent_expirationElementName = "event_expiration";
 static NSUInteger kevent_expirationElementNameLength = 17; 

 static const char *keventElementName = "event";
 static NSUInteger keventElementNameLength = 6; 

 static const char *kdate_updatedElementName = "date_updated";
 static NSUInteger kdate_updatedElementNameLength = 13; 

 static const char *kbusinessElementName = "business";
 static NSUInteger kbusinessElementNameLength = 9; 

static const char *klocationElementName = "location";
static NSUInteger klocationElementNameLength = 9; 



static const char *kImagesElementName = "images";
static NSUInteger kImagesElementNameLength = 7; 

static const char *kImageElementName = "image";
static NSUInteger kImageElementNameLength = 6; 

static const char *kimgElementName = "img";
static NSUInteger kimgElementNameLength = 4; 


static const char *kmaincategoryElementName = "maincategory";
static NSUInteger kmaincategoryElementNameLength = 13; 

static const char *kAttendingElementName = "attending";
static NSUInteger kAttendingElementNameLength = 10; 


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



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, keventsElementName, keventsElementNameLength))
	{
		arrData = [[NSMutableArray alloc]init];
	}
	else if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
			idCount = 1;
		 currentObject = [[EventListBO alloc]init];
        [arrCats removeAllObjects];

	}
	
    else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
			NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
			currentObject.isMain = [[dictAttributes valueForKey:@"main"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
    else if(0 == strncmp((const char *)localname , kimgElementName, kimgElementNameLength))
	{
        if ([currentObject.isMain isEqualToString:@"True"] || [currentObject.isMain isEqualToString:@"False"]) {
			
			NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
			 currentObject.EventImage = [[dictAttributes valueForKey:@"src"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
             currentObject.EventImage = [currentObject.EventImage stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            
            if(ModeType==GetEventList)
            {
                
                if(!currentObject.EventImage || [currentObject.EventImage isEqual:[NSNull null]])
                {
                    currentObject.imageEvent = [[UIImage imageNamed:@"NoImageEvent.png"] retain];
                }
                else 
                {
                    
                    
                    //[NSThread detachNewThreadSelector:@selector(downloadImageFor:) toTarget:self withObject:currentObject];
                    [self downloadImageFor:currentObject];
                                       
                }
            }
            
            
			
        }
		
		
    }
	
	
	/*
    if(0 == strncmp((const char *)localname, kimageElementName, kimageElementNameLength))
    {
		if(currentObject.EventImage==nil)
		{
        NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
        currentObject.EventImage = [dictAttributes valueForKey:@"src"];
      }
	}*/
 	else if(0 == strncmp((const char *)localname, kuserElementName, kuserElementNameLength))
	{
		idCount = 3;
 		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, klocationElementName, klocationElementNameLength))
	{
		idCount = 2;
		self.currentValue = [NSMutableString string];
	}
 	//else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
//	{
//		self.currentValue = [NSMutableString string];
//	}
 	else if(0 == strncmp((const char *)localname, kstatusElementName, kstatusElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kpriceElementName, kpriceElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, knameElementName, knameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, klikecountElementName, klikecountElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kis_featuredElementName, kis_featuredElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	
	else if(0 == strncmp((const char *)localname, keventidElementName, keventidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kevent_start_timeElementName, kevent_start_timeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kevent_start_dateElementName, kevent_start_dateElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kevent_expirationElementName, kevent_expirationElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kdate_updatedElementName, kdate_updatedElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
 
    else if(0 == strncmp((const char *)localname, kmaincategoryElementName, kmaincategoryElementNameLength))
	{
 		self.currentEventCatObject = [[EventCategoryBO alloc] init];
        self.currentValue = [NSMutableString string];

	}
	else if(0 == strncmp((const char *)localname, kAttendingElementName, kAttendingElementNameLength))
	{
		
		self.currentValue = [NSMutableString string];
	}
	
	
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
        self.currentValue = [NSMutableString string];
		
	}
	else if(0 == strncmp((const char *)localname, kaddressElementName, kaddressElementNameLength))
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
	
	else if(0 == strncmp((const char *)localname, kzipcodeElementName, kzipcodeElementNameLength))
	{
        self.currentValue = [NSMutableString string];
		
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
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
	if(0 == strncmp((const char *)localname, kuserElementName, kuserElementNameLength))
	{
	}
	
	//else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
//	{
//		strID= [strID stringByAppendingFormat:@"%@ ",self.currentValue];
//		currentObject.UserID = strID;
//	}
	
	else if(0 == strncmp((const char *)localname, kstatusElementName, kstatusElementNameLength))
	{
		currentObject.status = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kpriceElementName, kpriceElementNameLength))
	{
		currentObject.price = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, knameElementName, knameElementNameLength))
	{
		currentObject.name = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, klikecountElementName, klikecountElementNameLength))
	{
		currentObject.likecount = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kis_featuredElementName, kis_featuredElementNameLength))
	{
		currentObject.is_featured = self.currentValue;
	}
	
	else if(0 == strncmp((const char *)localname, keventidElementName, keventidElementNameLength))
	{
		if (idCount==1) {
			currentObject.Eventid = self.currentValue;
			idCount=0;
 		}
	
	}
	
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		 if(idCount == 2){
			idCount=0;
 		}
		else if(idCount == 3){
			NSString *TempId = [NSString stringWithFormat:@"%@",self.strID];
			//strID= [NSString stringWithFormat:@"%@,%@",strID,self.currentValue];
            self.strID= [TempId stringByAppendingFormat:@"%@,",self.currentValue];
 		}
 	}
	else if(0 == strncmp((const char *)localname, keventsElementName, keventsElementNameLength))
	{
		//currentObject.events = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kevent_start_timeElementName, kevent_start_timeElementNameLength))
	{
		NSArray *TempTime = [self.currentValue componentsSeparatedByString:@":"];
		
		if([TempTime count]>=2)
		{
		  currentObject.event_start_time = [NSString stringWithFormat:@"%@:%@",[TempTime objectAtIndex:0],[TempTime objectAtIndex:1]];
		}
	}
	else if(0 == strncmp((const char *)localname, kevent_start_dateElementName, kevent_start_dateElementNameLength))
	{
		currentObject.event_start_date = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kevent_expirationElementName, kevent_expirationElementNameLength))
	{
		currentObject.event_expiration = self.currentValue;
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
	
	else if(0 == strncmp((const char *)localname, kzipcodeElementName, kzipcodeElementNameLength))
	{
        currentObject.zipcode = self.currentValue;
		
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
	{
		
		currentObject.country = self.currentValue;
	}
	
	else if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
        currentObject.UserID = [NSString stringWithFormat:@"%@",self.strID] ;
        NSLog(@"self.strID %@",self.strID);

        [self.currentObject.arrCategories addObjectsFromArray:arrCats];
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
        //strID=@"";
		self.strID=[NSString stringWithFormat:@""];
		
	}
    else if(0 == strncmp((const char *)localname, kmaincategoryElementName, kmaincategoryElementNameLength))
	{
         self.currentEventCatObject.maincategoryid = self.currentValue;
        self.currentEventCatObject.eventId = self.currentObject.Eventid;
        self.currentEventCatObject.eventName = self.currentObject.name;
        [arrCats addObject:currentEventCatObject ];
        [currentEventCatObject release];
        currentEventCatObject=nil;
	}
	else if(0 == strncmp((const char *)localname, kImagesElementName, kImagesElementNameLength))
	{
        isEventImage = NO;
 	}
	
	else if(0 == strncmp((const char *)localname, kdate_updatedElementName, kdate_updatedElementNameLength))
	{
		currentObject.date_updated = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		currentObject.business = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kAttendingElementName, kAttendingElementNameLength))
	{
		idCount=0;
		currentObject.favEventUserId =  self.strID;
		//self.strID = @"";
	}
 
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventListXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventListXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
	
	
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] EventListXML_Error:self encounteredError:err];
}
- (void)downloadImageFor:(EventListBO *)event{
    NSError *error = nil;
    NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, currentObject.EventImage];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    
    NSLog(@"Image url%@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    if(url)
    {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
        if(!error){
            currentObject.imageEvent = [[UIImage alloc]initWithData:imageData];
        }
        else
            currentObject.imageEvent = [UIImage imageNamed:@"NoImageEvent.png"];
        [imageData release];
        
    }
    else
    {
        currentObject.imageEvent = [UIImage imageNamed:@"NoImageEvent.png"];
    }
    


}
- (void)dealloc
{
    [Str_date release];
    [str_category release];
    [str_type release];
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end