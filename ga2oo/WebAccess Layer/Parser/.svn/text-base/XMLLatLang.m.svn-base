//
//  XMLLatLang.m
//  MobileSurroundings
//
//  Created by narender on 3/3/10.
//  Copyright 2010 Winitsoftware. All rights reserved.
//

#import "XMLLatLang.h"

@implementation XMLLatLang
@synthesize contentOfCurrentComment;
@synthesize location;

- (UserLocationBO*)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
   
    NSString *str_dat = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"zip code data %@",str_dat);
    
    [str_dat release];
    [data release];
    
    location = [[UserLocationBO alloc]init];
    
	[parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    NSError *parseError = [parser parserError];
    
    if (parseError && error)
    {
        *error = parseError;
		NSLog(@"%@",[parseError description]);
    }
    
    [parser release];

    if(![location.Address length])
	{
		location.Address = [NSString stringWithFormat:@"None"];
    }
	
	if(![location.City length])
    {
		//location.City = [NSString stringWithFormat:@"None"];
    }
	
	if(![location.Country length])
    {
		//location.Country = [NSString stringWithFormat:@"None"];
    }
	
	if(![location.Zipcode length])
    {
		//location.Zipcode = [NSString stringWithFormat:@"None"];
    }

	if(![location.State length])
    {
		//location.State = [NSString stringWithFormat:@"None"];
    }
	if(![location.GeoPoint length])
    {
		location.GeoPoint = [NSString stringWithFormat:@"None"];
    }
    
    return [location autorelease];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName)
    {
        elementName = qName;
    }
	
    self.contentOfCurrentComment = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName)
    {
        elementName = qName;
    }
	
    if([elementName isEqualToString:@"address"])
    {
        location.Address = self.contentOfCurrentComment ;
    }
    else if([elementName isEqualToString:@"CountryName"])
    {
        location.Country = self.contentOfCurrentComment ;
    }
    else if([elementName isEqualToString:@"PostalCodeNumber"])
    {
        location.Zipcode  = self.contentOfCurrentComment;
    }
    else if([elementName isEqualToString:@"LocalityName"])
    {
        location.City  = self.contentOfCurrentComment;
    }
    else if([elementName isEqualToString:@"AdministrativeAreaName"])
    {
        location.State  = self.contentOfCurrentComment;
    }
	else if([elementName isEqualToString:@"coordinates"])
    {
        location.GeoPoint  = self.contentOfCurrentComment;
    }
	
	self.contentOfCurrentComment = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	
	if (self.contentOfCurrentComment)
    {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [self.contentOfCurrentComment appendString:string];
		
    }
   	
}
- (void) dealloc
{
	
	[super dealloc];
}

@end
