//
//  EventRecommendateXML.m
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventRecommendateXML.h"



@interface EventRecommendateXML(LibXMLParserMethods)



- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end



@implementation EventRecommendateXML


@synthesize currentObject;
@synthesize arrData;
@synthesize currentValue;
@synthesize _currentParentElement;

static ObjectMessage = 0;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
	arrData = [[NSMutableArray alloc]init];
    ObjectMessage = 0;
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@/%@",Ga2oRecommendateList,appDelegate.currentUserID];
    
    NSLog(@"%@",newstr);
    
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
    [newstr release];
	[myURL release];
    //[myRequest release];
	return [self doParsing];
}


static const char *kUserElementName = "useraccount";
static NSUInteger kUserElementNameLength = 12; 

static const char *kUserIdElementName = "id";
static NSUInteger kUserIdElementNameLength = 3;

static const char *kmessagesElementName = "messages";
static NSUInteger kmessagesElementNameLength = 9; 

static const char *kmessageElementName = "message";
static NSUInteger kmessageElementNameLength = 8; 

static const char *kfromidElementName = "fromid";
static NSUInteger kfromidElementNameLength = 7; 

static const char *kfromnameElementName = "fromname";
static NSUInteger kfromnameElementNameLength = 9; 

static const char *kthreadidElementName = "thread_id";
static NSUInteger kthreadidElementNameLength = 10; 


static const char *ksubjectElementName = "subject";
static NSUInteger ksubjectElementNameLength = 8; 

static const char *kisreadElementName = "is_read";
static NSUInteger kisreadElementNameLength = 8; 

static const char *kgaeventidElementName = "gaeventid";
static NSUInteger kgaeventidElementNameLength = 10; 

static const char *kgaeventnameElementName = "gaeventname";
static NSUInteger kgaeventnameElementNameLength = 12; 

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
	else if(0 == strncmp((const char *)localname, kmessagesElementName, kmessagesElementNameLength))
	{
	}
	else if((0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength)) && (!ObjectMessage))
	{
        ObjectMessage = 1;
		currentObject = [[EventRecommendateBO alloc] init];
		self.currentValue = [NSMutableString string];
        
	}
    else if(0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength))
	{
        self.currentValue = [NSMutableString string];
    }
    
	else if(0 == strncmp((const char *)localname, kfromidElementName, kfromidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kfromnameElementName, kfromnameElementNameLength))
	{
		
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kthreadidElementName, kthreadidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, ksubjectElementName, ksubjectElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kisreadElementName, kisreadElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kgaeventidElementName, kgaeventidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kgaeventnameElementName, kgaeventnameElementNameLength))
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
	else if((0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength)) && (!ObjectMessage))
	{
		if([currentObject.stris_read isEqualToString:@"False"])
		{
            [arrData addObject:currentObject];
		}
		
		[currentObject release];
		currentObject = nil;
		
	}
	else if(0 == strncmp((const char *)localname, kfromidElementName, kfromidElementNameLength))
	{
		currentObject.strfromid = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kfromnameElementName, kfromnameElementNameLength))
	{
		currentObject.strfromname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kthreadidElementName, kthreadidElementNameLength))
	{
		currentObject.strthread_id = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, ksubjectElementName, ksubjectElementNameLength))
	{
		currentObject.strsubject = self.currentValue;
	}
	
	else if((0 == strncmp((const char *)localname, kmessageElementName, kmessageElementNameLength)) && (ObjectMessage))
	{
         ObjectMessage = 0;
		currentObject.strmessage = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kisreadElementName, kisreadElementNameLength))
	{
		currentObject.stris_read = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kgaeventidElementName, kgaeventidElementNameLength))
	{
		currentObject.strgaeventid = self.currentValue ;
	}
	else if(0 == strncmp((const char *)localname, kgaeventnameElementName, kgaeventnameElementNameLength))
	{
		currentObject.strgaeventname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kDateCreatedElementName, kDateCreatedElementNameLength))
	{
		currentObject.strdate_Created = self.currentValue;
	}
	///
    
	self.currentValue = nil;
}


-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(EventRecommendateXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(EventRecommendateXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] EventRecommendateXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	[super dealloc];
}





@end
