//
//  SaxXMLParser.h
//  
//
//  Created by Prashanth on 20/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebserConsts.h"

struct _xmlSAX2Attributes
{
	const xmlChar* localname;
	const xmlChar* prefix;
	const xmlChar* uri;
	const xmlChar* value;
	const xmlChar* end;
};
typedef struct _xmlSAX2Attributes xmlSAX2Attributes;

@interface SaxXMLParser : NSObject
{
	BOOL _error;
	NSURLConnection *connection;
	xmlParserCtxtPtr _xmlParserContext;
	NSOperationQueue *_retrieverQueue;
	id delegate;
	BOOL _done;
	
	BOOL ErrorShown;
}

@property(nonatomic, assign) BOOL error;
@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSOperationQueue *retrieverQueue;
@property(nonatomic, assign) id delegate;

+(id)saxParser;
-(void)getData;
- (BOOL)parseForData;
- (BOOL)parseWithLibXML2Parser;
-(BOOL)doParsing;

-(NSMutableDictionary *)parseAttrtibutes:(xmlChar **)attributes Count:(NSInteger)count;
-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err;

@end