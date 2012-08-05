//
//  HttpRequest.m
//  Plants411
//
//  Created by WINIT on 25/06/10.
//  Copyright 2010 WINIT. All rights reserved.
//

#import "HttpRequest.h"
//#import "GlobalStringConstant.h"

@implementation HttpRequest

@synthesize _delegate;
@synthesize _tag;
@synthesize data;
@synthesize _moduleName;

-(void)PostRequest:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag
{	
	self._delegate = delegate;
	self._tag = tag;
	
	NSURL *myURL = [NSURL URLWithString:url];
	
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL];
	
	NSString *myContent = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
	[myRequest setValue:myContent forHTTPHeaderField:@"Content-type"];
	[myRequest setHTTPMethod:@"POST"];
	
	[[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
}
-(void)PostRequestToDelete:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag
{	
	self._delegate = delegate;
	self._tag = tag;
	
    NSLog(@"delete url %@",url);
	NSURL *myURL = [NSURL URLWithString:url];
	
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL];
	
	NSString *myContent = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
	[myRequest setValue:myContent forHTTPHeaderField:@"Content-type"];
	[myRequest setHTTPMethod:@"DELETE"];
	
	[[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
}
-(void)PostRequest:(NSString *)url PostData:(NSDictionary *)myPostDictionary Delegate:(id)delegate Tag:(NSInteger)tag
{	
	self._delegate = delegate;
	self._tag = tag;
	NSMutableData *myReturn = [[NSMutableData alloc] initWithCapacity:10];
	
	NSArray *formKeys = [myPostDictionary allKeys];
	NSArray *formValues = [myPostDictionary allValues];
	for (int i = 0; i < [formKeys count]; i++) 
	{
		if (i>0) {
			[myReturn appendData:[@"&" dataUsingEncoding:NSASCIIStringEncoding]];
		}
		NSString *str = [NSString stringWithFormat:@"%@=%@",[formKeys objectAtIndex:i],[formValues objectAtIndex:i]];
		[myReturn appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	NSURL *myURL = [NSURL URLWithString:url];
	
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL];
	NSString *myContent = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
	[myRequest setValue:myContent forHTTPHeaderField:@"Content-type"];
	[myRequest setHTTPMethod:@"POST"];
	[myRequest setHTTPBody:myReturn];
	
	NSMutableString *str = [[NSMutableString alloc] initWithData:myReturn encoding:NSUTF8StringEncoding];
	NSLog(@"%@", str);
	[str release];
	//NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
	[myReturn release];
}

-(void)GetRequest:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag ModuleName:(NSString *)moduleName
{
	self._delegate = delegate;  
	self._tag = tag;
	self._moduleName =moduleName;
	NSString *urlString = [NSString stringWithFormat:@"%@",url];
	NSURLRequest *request= [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]] autorelease];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSLog(@"aa", connection);
}


- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) 
	{ 
		data = [[NSMutableData alloc] initWithCapacity:2048]; 
	} 
	[data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self UpdateCaller:nil isError:TRUE];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection 
{	
	[self UpdateCaller:data isError:FALSE];
	
	[data release]; 
	data=nil;
	[connection release];
	connection=nil;
}

-(void)UpdateCaller:(id)responseData isError:(BOOL)isError
{
	WebResponse *response = [[WebResponse alloc] init];
	response.data = responseData;
	response.moduleName =self._moduleName;
	response.isError = isError;
	response.tag = _tag;
	id delegate = self._delegate;
	[delegate performSelectorOnMainThread:@selector(httpResponseReceived:) withObject:response waitUntilDone:YES];
	self._delegate =nil;
	[response autorelease];
}

+ (NSString *)flattenHTML:(NSString *)html {
	
    NSScanner *theScanner;
    NSString *text = nil;
	
    theScanner = [NSScanner scannerWithString:html];
	
    while ([theScanner isAtEnd] == NO) {
		
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
		
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
		
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@>", text]
											   withString:@" "];
		
    } // while //
    
    return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
}

-(void)dealloc
{
	_moduleName =nil;
	[_moduleName release];
	[data release];
	[super dealloc];
}

@end
