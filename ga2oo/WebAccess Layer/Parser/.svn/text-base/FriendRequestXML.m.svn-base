//
//  FriendRequestXML.m
//  Ga2oo
//
//  Created by Fahad on 23/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendRequestXML.h"
#import "FriendRequestBO.h"


@interface FriendRequestXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end


@implementation FriendRequestXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;
@synthesize userId;
@synthesize strSoapMsg;


- (BOOL)parseWithLibXML2Parser{
	
	currentObject = [[FriendRequestBO alloc] init];
	currentObject.Result = @"error";
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSString *newstr = [[NSString alloc] initWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/friendresponse"];
	NSString *soapMsg = [[NSString alloc] initWithFormat:@"%@",self.strSoapMsg];
	NSString *msgLength = [NSString stringWithFormat:@"%i", [soapMsg length]];
	
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSDateFormatter *dtf = [[NSDateFormatter alloc]init];
	[dtf setDateFormat:@"EEE, dd MMM yyyy HH:MM:SS"];
	NSString *strdt = [dtf stringFromDate:[NSDate date]];
	[dtf release];
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL];
	[myRequest setValue:@"5.ga2ootesting.appspot.com" forHTTPHeaderField:@"Host"];
	[myRequest addValue:strdt forHTTPHeaderField:@"Date"];
	[myRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
    
    NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *dats = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	NSLog(@"The  error is  %@",[error description]);
	NSString *temstr = [[NSString alloc]initWithData:dats encoding:NSUTF8StringEncoding];
	NSLog(@"temstr %@",temstr);
    NSLog(@"newstr , %@",newstr);
    NSLog(@"temstr %@",soapMsg);
    NSLog(@"newstr , %@",msgLength);
    NSLog(@"newstr , %@",strdt);
    
	[con release];
	[myURL release];
	[newstr release];
	[soapMsg release];
    [temstr release];
    [myRequest release];
	return [self doParsing];
}


static const char *kUpdateTokenResponseElementName = "result";
static NSUInteger kUpdateTokenResponseElementNameLength = 7; 

static const char *kmessageElementsName = "message";
static NSUInteger kmessageElementsNameLength = 8; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
				 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
		  namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kUpdateTokenResponseElementName, kUpdateTokenResponseElementNameLength))
    {
		self.currentValue = [NSMutableString string];
    }
	else if(0 == strncmp((const char *)localname, kmessageElementsName, kmessageElementsNameLength))
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
	if(0 == strncmp((const char *)localname, kUpdateTokenResponseElementName, kUpdateTokenResponseElementNameLength))
    {
		currentObject.Result = self.currentValue;
    }
	else if(0 == strncmp((const char *)localname, kmessageElementsName, kmessageElementsNameLength))
    {
		currentObject.Result = self.currentValue;
    }
	else 
		self.currentValue = nil;
}

-(void)endDocument
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(FriendRequestXML_Finished:)withObject:currentObject waitUntilDone:YES];
	[self autorelease];
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] FriendRequestXML_Error:self encounteredError:err with:currentObject];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}





@end
