//
//  EventFriendListXML.m
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendListXML.h"
#import "EventFriendListBO.h"

@interface EventFriendListXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation EventFriendListXML
@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize strUser;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	arrData = [[NSMutableArray alloc] init];
	dtFormat = [[NSDateFormatter alloc] init];
	[dtFormat setDateFormat:Ga2ooDateFormatXML];
	
	strUser = [strUser stringByReplacingOccurrencesOfString:@" " withString:@","];
	strUser = [strUser substringWithRange:NSMakeRange(0,[strUser length]-1)];;
	NSString *newstr = [NSString stringWithFormat:@"%@%@", Ga2ooEventFrienList, strUser];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	return [self doParsing];
}

static const char *kuseraccountsElementName = "useraccounts";
static NSUInteger kuseraccountsElementNameLength = 13; 

static const char *kZipcodeElementName = "currentzip";
static NSUInteger kZipcodeElementNameLength = 10; 

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

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kuseraccountsElementName, kuseraccountsElementNameLength))
	{
		
	}
	else if(0 == strncmp((const char *)localname, kUserElementName, kUserElementNameLength))
	{
		currentObject = [[EventFriendListBO alloc] init];
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
		[arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kZipcodeElementName, kZipcodeElementNameLength))
	{
		currentObject.Zipcode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kUsernameElementName, kUsernameElementNameLength))
	{
		currentObject.Username = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kUserIdElementName, kUserIdElementNameLength))
	{
		currentObject.UserId = [self.currentValue integerValue];
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
		//currentObject.IsPublic = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsCalenderSharedElementName, kIsCalenderSharedElementNameLength))
	{
		//currentObject.IsCalenderShared = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		//currentObject.IsActive = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kInvisiblemodeElementName, kInvisiblemodeElementNameLength))
	{
		//currentObject.Invisiblemode = [self.currentValue boolValue];
	}
	else if(0 == strncmp((const char *)localname, kGenderElementName, kGenderElementNameLength))
	{
		//currentObject.Gender = self.currentValue;
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
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventFriendListXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventFriendListXML_Finished:)withObject:arrData waitUntilDone:YES];
		//[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] EventFriendListXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	[dtFormat release];
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end
