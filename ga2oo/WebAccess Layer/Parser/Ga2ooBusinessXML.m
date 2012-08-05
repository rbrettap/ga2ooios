//
//  Ga2ooBusinessXML.m
//  Ga2oo
//
//  Created by WINIT on 27/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ga2ooBusinessXML.h"
#import "Ga2ooAppDelegate.h"
#import "BusinessDetailBO.h"



@interface Ga2ooBusinessXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation Ga2ooBusinessXML

@synthesize currentValue;
@synthesize  BusinessId;
@synthesize currentObject;


- (BOOL)parseWithLibXML2Parser{
	
    appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@%i",@"http://5.ga2ootesting.appspot.com/rest/v1/business/id/",BusinessId];
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



static const char *kidElementName = "id";
static NSUInteger kidElementNameLength = 3; 

static const char *kbiznameElementName = "bizname";
static NSUInteger kbiznameElementNameLength = 8; 

static const char *kcontactemailElementName = "contactemail";
static NSUInteger kcontactemailElementNameLength = 13; 

static const char *kcontactnameElementName = "contactname";
static NSUInteger kcontactnameElementNameLength = 12;

static const char *kphoneElementName = "phone";
static NSUInteger kphoneElementNameLength = 6;


static const char *kimgElementName = "img";
static NSUInteger kimgElementNameLength = 4;


static const char *kurlElementName = "url";
static NSUInteger kurlElementNameLength = 4;


static const char *ksupportemailElementName = "supportemail";
static NSUInteger ksupportemailElementNameLength = 13;



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	
	if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
			currentObject = [[BusinessDetailBO alloc]init];
          self.currentValue = [NSMutableString string];
        
	}
	else if(0 == strncmp((const char *)localname, kbiznameElementName, kbiznameElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcontactemailElementName, kcontactemailElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcontactnameElementName, kcontactnameElementNameLength))
	{
        self.currentValue = [NSMutableString string];
		
	}
	else if(0 == strncmp((const char *)localname, kphoneElementName, kphoneElementNameLength))
	{
        self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kimgElementName, kimgElementNameLength))
	{
        NSMutableDictionary *dictAttributes = [self parseAttrtibutes:(xmlChar **)attributes Count:attributeCount]; 
        currentObject.Strimage = [dictAttributes valueForKey:@"src"];
	}
    else if(0 == strncmp((const char *)localname, kurlElementName, kurlElementNameLength))
	{
        self.currentValue = [NSMutableString string];
		
	}
	else if(0 == strncmp((const char *)localname, ksupportemailElementName, ksupportemailElementNameLength))
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
    if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
        currentObject.businessid = self.currentValue;
                
	}
	else if(0 == strncmp((const char *)localname, kbiznameElementName, kbiznameElementNameLength))
	{
        currentObject.businessname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcontactemailElementName, kcontactemailElementNameLength))
	{
        currentObject.Strcontactemail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcontactnameElementName, kcontactnameElementNameLength))
	{
        currentObject.Strcontactname = self.currentValue;
		
	}
	else if(0 == strncmp((const char *)localname, kphoneElementName, kphoneElementNameLength))
	{
        currentObject.Strphone = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kimgElementName, kimgElementNameLength))
	{
        
	}
    
    else if(0 == strncmp((const char *)localname, kurlElementName, kurlElementNameLength))
	{
        currentObject.Strurl = self.currentValue;
		
	}
	else if(0 == strncmp((const char *)localname, ksupportemailElementName, ksupportemailElementNameLength))
	{
        currentObject.Strsupportemail = self.currentValue;
	}

	else
		self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(Ga2ooBusinessXMLFinished:)])
	{
        [(id)[self delegate] performSelectorOnMainThread:@selector(Ga2ooBusinessXMLFinished:)withObject:currentObject waitUntilDone:YES];
        [self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	if([[self delegate]retainCount])
	{
    	[(id)[self delegate] Ga2ooBusinessXML_Error:self encounteredError:err];
	}
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}





@end
