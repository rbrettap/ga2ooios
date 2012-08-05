//
//  GUserEventXML.m
//  Ga2oo
//
//  Created by Fahad on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GUserEventXML.h"

@interface GUserEventXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end


@implementation GUserEventXML

@synthesize currentValue;
@synthesize SelectedUserId;
@synthesize UserFavEventsObj;

- (BOOL)parseWithLibXML2Parser{
	
    appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%@",Ga2ooUserEventList,SelectedUserId];
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

static const char *keventsElementName = "events";
static NSUInteger keventsElementNameLength = 7; 

 

static const char *keventidElementName = "eventid";
static NSUInteger keventidElementNameLength = 8; 

static const char *keventElementName = "event";
static NSUInteger keventElementNameLength = 6;

static const char *kuseraddedeventidElementName = "useraddedeventid";
static NSUInteger kuseraddedeventidElementNameLength = 17;

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, keventsElementName, keventsElementNameLength))
	{
		[appDelegate.arr_FavoritesID removeAllObjects];
	}
    else if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
        self.UserFavEventsObj = [[UserFavEvents alloc] init];
        
	}
    else if(0 == strncmp((const char *)localname, kuseraddedeventidElementName, kuseraddedeventidElementNameLength))
	{
        self.currentValue = [NSMutableString string];
        
	}
    
    else if(0 == strncmp((const char *)localname, keventidElementName, keventidElementNameLength))
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
    
    if(0 == strncmp((const char *)localname, keventElementName, keventElementNameLength))
	{
        
        [appDelegate.arr_FavoritesID addObject:self.UserFavEventsObj];
        [self.UserFavEventsObj release];
        self.UserFavEventsObj = nil;
        
	}
    
    if(0 == strncmp((const char *)localname, keventidElementName, keventidElementNameLength))
    {
        

        self.UserFavEventsObj.strEventId = [NSString stringWithFormat:@"%@",self.currentValue];

        
    }
    
    else if(0 == strncmp((const char *)localname, kuseraddedeventidElementName, kuseraddedeventidElementNameLength))
	{
        self.UserFavEventsObj.strUserAddedEventId = [NSString stringWithFormat:@"%@",self.currentValue];
        
	}
}

-(void)endDocument
{
    
    [(id)[self delegate] performSelectorOnMainThread:@selector(GUserEventXML_Finished:)withObject:appDelegate.arr_FavoritesID waitUntilDone:YES];
		[self autorelease];
	
	
	
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] GUserEventXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end
