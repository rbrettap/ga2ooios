//
//  UserNotificationsXML.m
//  Ga2oo
//
//  Created by Gopinath PUPPALA on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserNotificationsXML.h"



@interface UserNotificationsXML(LibXMLParserMethods)



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end



@implementation UserNotificationsXML

@synthesize currentObject;
@synthesize arrData;
@synthesize currentValue;
@synthesize _currentParentElement;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	arrData = [[NSMutableArray alloc]init];
    
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@/%@",Ga2ooNotificationList,appDelegate.currentUserID];
    
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


static const char *kUserElementName = "useraccount";
static NSUInteger kUserElementNameLength = 12; 

static const char *kUserIdElementName = "id";
static NSUInteger kUserIdElementNameLength = 3;

static const char *knotificationsElementName = "notifications";
static NSUInteger knotificationsElementNameLength = 14; 

static const char *knotificationElementName = "notification";
static NSUInteger knotificationElementNameLength = 13; 

static const char *knotificationidElementName = "notificationid";
static NSUInteger knotificationidElementNameLength = 15; 

static const char *knotificationtypeElementName = "notificationtype";
static NSUInteger knotificationtypeElementNameLength = 17; 

static const char *ksenderElementName = "sender";
static NSUInteger ksenderElementNameLength = 7; 


static const char *ksenderNameElementName = "sendername";
static NSUInteger ksenderNameElementNameLength = 11; 

static const char *kuseraddedfriendidElementName = "useraddedfriendid";
static NSUInteger kuseraddedfriendidElementNameLength = 18; 

static const char *kEventIdElementName = "eventid";
static NSUInteger kEventIdElementNameLength = 8; 

static const char *kEventNameElementName = "eventname";
static NSUInteger kEventNameElementNameLength = 10; 

static const char *kTextElementName = "text";
static NSUInteger kTextElementNameLength = 5; 

static const char *kIsReadElementName = "is_read";
static NSUInteger kIsReadElementNameLength = 8; 

static const char *kDateCreatedElementName = "date_created";
static NSUInteger kDateCreatedElementNameLength = 12; 







- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes

{
	if(0 == strncmp((const char *)localname, kUserElementName, kUserElementNameLength))
	{
		arrData =[[NSMutableArray alloc]init];
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		
		
	}
	else if(0 == strncmp((const char *)localname, knotificationsElementName, knotificationsElementNameLength))
	{
	}
	else if(0 == strncmp((const char *)localname, knotificationElementName, knotificationElementNameLength))
	{
		currentObject = [[EventNotificationsBO alloc] init];
		self.currentValue = [NSMutableString string];

	}
	else if(0 == strncmp((const char *)localname, knotificationidElementName, knotificationidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, knotificationtypeElementName, knotificationtypeElementNameLength))
	{
		
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, ksenderElementName, ksenderElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, ksenderNameElementName, ksenderNameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kuseraddedfriendidElementName, kuseraddedfriendidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kEventIdElementName, kEventIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kEventNameElementName, kEventNameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kTextElementName, kTextElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kDateCreatedElementName, kDateCreatedElementNameLength))
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
	if(0 == strncmp((const char *)localname, kUserElementName, kUserElementNameLength))
	{

	}
	if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{

	}
	else if(0 == strncmp((const char *)localname, knotificationElementName, knotificationElementNameLength))
    {
		if([currentObject.stris_read isEqualToString:@"False"])
		{
		  [arrData addObject:currentObject];
		}
		[currentObject release];
		currentObject = nil;
		
	}
	else if(0 == strncmp((const char *)localname, knotificationidElementName, knotificationidElementNameLength))
	{
		currentObject.strNotificationID = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, knotificationtypeElementName, knotificationtypeElementNameLength))
	{
		currentObject.strNotificationTye = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, ksenderElementName, ksenderElementNameLength))
	{
		currentObject.strsender = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, ksenderNameElementName, ksenderNameElementNameLength))
	{
		currentObject.strsenderName = self.currentValue;
	}
	
	else if(0 == strncmp((const char *)localname, kuseraddedfriendidElementName, kuseraddedfriendidElementNameLength))
	{
		currentObject.strfriendRequest = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEventIdElementName, kEventIdElementNameLength))
	{
		currentObject.strEventId = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEventNameElementName, kEventNameElementNameLength))
	{
		currentObject.strEventName = self.currentValue ;
	}
	else if(0 == strncmp((const char *)localname, kTextElementName, kTextElementNameLength))
	{
		currentObject.strText = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsReadElementName, kIsReadElementNameLength))
	{
		currentObject.stris_read = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kDateCreatedElementName, kDateCreatedElementNameLength))
	{
		
		NSArray *TempTime = [self.currentValue componentsSeparatedByString:@":"];
		
		if([TempTime count]>=2)
		{
			currentObject.strdate_Created = [NSString stringWithFormat:@"%@:%@",[TempTime objectAtIndex:0],[TempTime objectAtIndex:1]];
		}
		
	}
	///

	self.currentValue = nil;
}


-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(UserNotificationsXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(UserNotificationsXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] UserNotificationsXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	[super dealloc];
}


@end
