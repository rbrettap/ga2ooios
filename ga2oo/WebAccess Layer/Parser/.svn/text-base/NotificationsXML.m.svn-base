#import "NotificationsXML.h"
#import "NotificationsBO.h"

@interface NotificationsXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation NotificationsXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSString *newstr = [[NSString alloc] initWithFormat:tblNotifications];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblNotificationsElementName = "tblNotifications";
 static NSUInteger ktblNotificationsElementNameLength = 17; 

 static const char *kNotificationsElementName = "Notifications";
 static NSUInteger kNotificationsElementNameLength = 14; 

 static const char *kNotificationbyElementName = "Notificationby";
 static NSUInteger kNotificationbyElementNameLength = 15; 

 static const char *kNotificationTypeIdElementName = "NotificationTypeId";
 static NSUInteger kNotificationTypeIdElementNameLength = 19; 

 static const char *kNotificationTextElementName = "NotificationText";
 static NSUInteger kNotificationTextElementNameLength = 17; 

 static const char *kNotificationIdElementName = "NotificationId";
 static NSUInteger kNotificationIdElementNameLength = 15; 

 static const char *kNotificationForElementName = "NotificationFor";
 static NSUInteger kNotificationForElementNameLength = 16; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kIsReadElementName = "IsRead";
 static NSUInteger kIsReadElementNameLength = 7; 

 static const char *kEventIdElementName = "EventId";
 static NSUInteger kEventIdElementNameLength = 8; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblNotificationsElementName, ktblNotificationsElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kNotificationsElementName, kNotificationsElementNameLength))
	{
		currentObject = [[NotificationsBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kNotificationbyElementName, kNotificationbyElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kNotificationTypeIdElementName, kNotificationTypeIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kNotificationTextElementName, kNotificationTextElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kNotificationIdElementName, kNotificationIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kNotificationForElementName, kNotificationForElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
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
	if(0 == strncmp((const char *)localname, kNotificationsElementName, kNotificationsElementNameLength))
	{
        [arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kNotificationbyElementName, kNotificationbyElementNameLength))
	{
		currentObject.Notificationby = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kNotificationTypeIdElementName, kNotificationTypeIdElementNameLength))
	{
		//currentObject.NotificationTypeId = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kNotificationTextElementName, kNotificationTextElementNameLength))
	{
		currentObject.NotificationText = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kNotificationIdElementName, kNotificationIdElementNameLength))
	{
		currentObject.NotificationId = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kNotificationForElementName, kNotificationForElementNameLength))
	{
		currentObject.NotificationFor = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		currentObject.ModifiedBy = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
	{
		//currentObject.IsRead = self.currentValue;
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
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(NotificationsXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(NotificationsXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] NotificationsXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end