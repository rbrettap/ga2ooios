//
//  SaxXMLParser.m
//  
//
//  Created by Prashanth on 20/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SaxXMLParser.h"

// Forward reference. The structure is defined in full at the end of the file.
static xmlSAXHandler simpleSAXHandlerStruct;  

@implementation SaxXMLParser

@synthesize connection;
@synthesize error = _error;
@synthesize retrieverQueue = _retrieverQueue;
@synthesize delegate;


+(id)saxParser
{
	// analyzer reports this as a potential leak
	// but self is released when the parsing is done
	// so it will be a leak if parsing never finishes
	// but if the parsing is finished then it won't be
	return [[[self class]alloc]init];	
}

- (NSOperationQueue *)retrieverQueue 
{
	if(nil == _retrieverQueue) 
	{
		// lazy creation of the queue for retrieving the earthquake data
		_retrieverQueue = [[NSOperationQueue alloc] init];
		_retrieverQueue.maxConcurrentOperationCount = 6;
	}
	return _retrieverQueue;
}

-(BOOL)doParsing
{
	BOOL success = NO;
	
	//This creates a context for "push" parsing in which chunks of data that are 
	//not "well balanced" can be passed to the context for streaming parsing. 
	//The handler structure defined above will be used for all the parsing. The
	//second argument, self, will be passed as user data to each of the SAX
	//handlers. The last three arguments are left blank to avoid creating a tree
	//in memory.
	
	_xmlParserContext = xmlCreatePushParserCtxt(&simpleSAXHandlerStruct, self, NULL, 0, NULL);
	
	if(self.connection != nil) 
	{  
		do 
		{
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
			
		}while (!_done && !self.error);	
    }
	
	if(self.error) 
	{
		[self.delegate SaxXMLParserError:self EncounteredError:nil];
	}
	else 
	{
		success = YES;
	}
	
	return success;
}

-(void)getData
{
	SEL method = @selector(parseForData);
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:method object:nil];
	[self.retrieverQueue addOperation:op];
	[op release];	
}

- (BOOL)parseForData
{
	BOOL success = NO;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	success = [self parseWithLibXML2Parser];
	[pool drain];
	return success;
}

- (BOOL)parseWithLibXML2Parser
{
	return FALSE;
}

- (NSString *) getDocumentsPath
{	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return documentsDir;
}

-(NSMutableDictionary *)parseAttrtibutes:(xmlChar **)attributes Count:(NSInteger)count
{
	NSMutableDictionary *dictAttributes = [NSMutableDictionary dictionaryWithCapacity:count];
	for (int i=0; i<count; i++)
	{
		NSString* key = [NSString stringWithCString:(const char*)attributes[0] encoding:NSUTF8StringEncoding]; 
		NSString* val = [[NSString alloc] initWithBytes:(const void*)attributes[3] length:(attributes[4] - attributes[3]) encoding:NSUTF8StringEncoding]; 
		[dictAttributes setObject:val forKey:key];
		[val release];
		attributes += 5;
	}
	return dictAttributes;
}

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix 
                 uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
          namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount 
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes 
{
}

- (void)charactersFound:(const xmlChar *)characters length:(int)length 
{
}

- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI 
{
}

-(void)endDocument
{

}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
}

- (void)parsingError:(const char *)msg, ...
{
	NSString *format = [[NSString alloc] initWithBytes:msg length:strlen(msg) encoding:NSUTF8StringEncoding];
	CFStringRef resultString = NULL;
	va_list argList;
	va_start(argList, msg);
	resultString = CFStringCreateWithFormatAndArguments(NULL, NULL,(CFStringRef)format,argList);
	va_end(argList);
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:(NSString*)resultString forKey:@"error_message"];
	NSError *error = [NSError errorWithDomain:@"ParsingDomain" code:101 userInfo:userInfo];

	SEL selector = @selector(SaxXMLParserError:EncounteredError:);
	NSMethodSignature *sig = [self methodSignatureForSelector:selector];
	
	if(nil != sig && [self respondsToSelector:selector])
	{
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
		[invocation retainArguments];
		[invocation setTarget:self];
		[invocation setSelector:selector];
		[invocation setArgument:&self atIndex:2];
		[invocation setArgument:&error atIndex:3];
		[invocation performSelectorOnMainThread:@selector(invoke) withObject:NULL waitUntilDone:NO];
	}
	[(NSString*)resultString release];
	[format release];
	_done = YES;
}


// Called when a chunk of data has been downloaded.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	// Process the downloaded chunk of data.
    NSString *temstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data received in saxParser : %@",temstr);
	xmlParseChunk(_xmlParserContext, (const char *)[data bytes], [data length], 0);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self SaxXMLParserError:self EncounteredError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	// Signal the context that parsing is complete by passing "1" as the last parameter.
	xmlParseChunk(_xmlParserContext, NULL, 0, 1);
	_done = YES;
}

-(void) dealloc
{
	[super dealloc];
	xmlFreeParserCtxt(_xmlParserContext);
	_xmlParserContext = NULL;
}

#pragma mark SAX Parsing Callbacks

static void startElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix,
                            const xmlChar *URI, int nb_namespaces, const xmlChar **namespaces,
                            int nb_attributes, int nb_defaulted, const xmlChar **attributes) 
{
	[((SaxXMLParser *)ctx) elementFound:localname prefix:prefix uri:URI 
							  namespaceCount:nb_namespaces namespaces:namespaces
							  attributeCount:nb_attributes defaultAttributeCount:nb_defaulted
								  attributes:(xmlSAX2Attributes*)attributes];
}

static void	endElementSAX(void *ctx, const xmlChar *localname, const xmlChar *prefix,
                          const xmlChar *URI) {    
	[((SaxXMLParser *)ctx) endElement:localname prefix:prefix uri:URI];
}

static void	charactersFoundSAX(void *ctx, const xmlChar *ch, int len) {
	[((SaxXMLParser *)ctx) charactersFound:ch length:len];
}

static void errorEncounteredSAX(void *ctx, const char *msg, ...) {
	va_list argList;
	va_start(argList, msg);
	[((SaxXMLParser *)ctx) parsingError:msg, argList];
}

static void endDocumentSAX(void *ctx) {
	[((SaxXMLParser *)ctx) endDocument];
}

static xmlSAXHandler simpleSAXHandlerStruct = {
	NULL,                       /* internalSubset */
	NULL,                       /* isStandalone   */
	NULL,                       /* hasInternalSubset */
	NULL,                       /* hasExternalSubset */
	NULL,                       /* resolveEntity */
	NULL,                       /* getEntity */
	NULL,                       /* entityDecl */
	NULL,                       /* notationDecl */
	NULL,                       /* attributeDecl */
	NULL,                       /* elementDecl */
	NULL,                       /* unparsedEntityDecl */
	NULL,                       /* setDocumentLocator */
	NULL,                       /* startDocument */
	endDocumentSAX,             /* endDocument */
	NULL,                       /* startElement*/
	NULL,                       /* endElement */
	NULL,                       /* reference */
	charactersFoundSAX,         /* characters */
	NULL,                       /* ignorableWhitespace */
	NULL,                       /* processingInstruction */
	NULL,                       /* comment */
	NULL,                       /* warning */
	errorEncounteredSAX,        /* error */
	NULL,                       /* fatalError //: unused error() get all the errors */
	NULL,                       /* getParameterEntity */
	NULL,                       /* cdataBlock */
	NULL,                       /* externalSubset */
	XML_SAX2_MAGIC,             // initialized? not sure what it means just do it
	NULL,                       // private
	startElementSAX,            /* startElementNs */
	endElementSAX,              /* endElementNs */
	NULL,                       /* serror */
};

@end
