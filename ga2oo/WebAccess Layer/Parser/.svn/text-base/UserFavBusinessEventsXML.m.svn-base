//
//  UserFavBusinessEventsXML.m
//  Ga2oo
//
//  Created by Suresh on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserFavBusinessEventsXML.h"
#import "DeleteFavouriteToEventBO.h"
#import "Ga2ooAppDelegate.h"

@interface UserFavBusinessEventsXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end


@implementation UserFavBusinessEventsXML

@synthesize currentValue;

- (BOOL)parseWithLibXML2Parser{
	
    appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%@",@"http://5.ga2ootesting.appspot.com/rest/v1/user/businesses/id/",appDelegate.currentUserID];
    NSLog(@"event url %@",newstr);
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	[newstr release];
	return [self doParsing];
}

static const char *kuseraccountElementName = "useraccount";
static NSUInteger kuseraccountElementNameLength = 12; 

static const char *kuserIdElementName = "id";
static NSUInteger kuserIdElementNameLength = 3; 

static const char *kfav_businessesElementName = "fav_businesses";
static NSUInteger kfav_businessesElementNameLength = 15;

static const char *kbusinessElementName = "business";
static NSUInteger kbusinessElementNameLength = 9;

static const char *kuseraddedbusinessidElementName = "useraddedbusinessid";
static NSUInteger kuseraddedbusinessidElementNameLength = 20;

static const char *kbusinessidElementName = "businessid";
static NSUInteger kbusinessidElementNameLength = 11;

static const char *kbusinessnameElementName = "businessname";
static NSUInteger kbusinessnameElementNameLength = 13;

static const char *kdate_updatedElementName = "date_updated";
static NSUInteger kdate_updatedElementNameLength = 13;

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	
	if(0 == strncmp((const char *)localname, kuseraccountElementName, kuseraccountElementNameLength))
	{
		[appDelegate.arrBusinessFav removeAllObjects];	
	}
	else if(0 == strncmp((const char *)localname, kuserIdElementName, kuserIdElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kfav_businessesElementName, kfav_businessesElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		currentObject = [[BusinessFavEventBO alloc]init];
	}
	else if(0 == strncmp((const char *)localname, kuseraddedbusinessidElementName, kuseraddedbusinessidElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kbusinessidElementName, kbusinessidElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kbusinessnameElementName, kbusinessnameElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kdate_updatedElementName, kdate_updatedElementNameLength))
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
	 if(0 == strncmp((const char *)localname, kbusinessElementName, kbusinessElementNameLength))
	{
		[appDelegate.arrBusinessFav addObject:currentObject];
	}
	else if(0 == strncmp((const char *)localname, kuseraddedbusinessidElementName, kuseraddedbusinessidElementNameLength))
	{
		currentObject.useraddedbusinessid = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kbusinessidElementName, kbusinessidElementNameLength))
	{
		currentObject.businessid = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kbusinessnameElementName, kbusinessnameElementNameLength))
	{
		currentObject.businessname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kdate_updatedElementName, kdate_updatedElementNameLength))
	{
		currentObject.date_updated = self.currentValue;
	}
	else
		self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(GUserFavBusinessEventsFinished:)])
	{
       [(id)[self delegate] performSelectorOnMainThread:@selector(GUserFavBusinessEventsFinished:)withObject:appDelegate.arrBusinessFav waitUntilDone:YES];
	   [self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	if([[self delegate]retainCount])
	{
    	[(id)[self delegate] GUserBusinessEventXML_Error:self encounteredError:err];
	}
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}


@end
