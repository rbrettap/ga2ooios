#import "BusinessXML.h"
#import "BusinessBO.h"

@interface BusinessXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation BusinessXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;

- (BOOL)parseWithLibXML2Parser{
	
	appDelegate  = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];

	NSString *newstr = [[NSString alloc] initWithFormat:tblBusiness];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
    [newstr release];
	return [self doParsing];
}


 static const char *ktblBusinessElementName = "tblBusiness";
 static NSUInteger ktblBusinessElementNameLength = 12; 

 static const char *kURLElementName = "URL";
 static NSUInteger kURLElementNameLength = 4; 

 static const char *kSupportEmailElementName = "SupportEmail";
 static NSUInteger kSupportEmailElementNameLength = 13; 

 static const char *kPhoneNumberElementName = "PhoneNumber";
 static NSUInteger kPhoneNumberElementNameLength = 12; 

 static const char *kModifiedOnElementName = "ModifiedOn";
 static NSUInteger kModifiedOnElementNameLength = 11; 

 static const char *kModifiedByElementName = "ModifiedBy";
 static NSUInteger kModifiedByElementNameLength = 11; 

 static const char *kIsActiveElementName = "IsActive";
 static NSUInteger kIsActiveElementNameLength = 9; 

 static const char *kImageDataElementName = "ImageData";
 static NSUInteger kImageDataElementNameLength = 10; 

 static const char *kImageElementName = "Image";
 static NSUInteger kImageElementNameLength = 6; 

 static const char *kFaxNumberElementName = "FaxNumber";
 static NSUInteger kFaxNumberElementNameLength = 10; 

 static const char *kExternal_biz_idElementName = "External_biz_id";
 static NSUInteger kExternal_biz_idElementNameLength = 16; 

 static const char *kEINElementName = "EIN";
 static NSUInteger kEINElementNameLength = 4; 

 static const char *kCreatedOnElementName = "CreatedOn";
 static NSUInteger kCreatedOnElementNameLength = 10; 

 static const char *kCreatedByElementName = "CreatedBy";
 static NSUInteger kCreatedByElementNameLength = 10; 

 static const char *kContactEmailElementName = "ContactEmail";
 static NSUInteger kContactEmailElementNameLength = 13; 

 static const char *kBusinessTypeIdElementName = "BusinessTypeId";
 static NSUInteger kBusinessTypeIdElementNameLength = 15; 

 static const char *kBusinessNameElementName = "BusinessName";
 static NSUInteger kBusinessNameElementNameLength = 13; 

 static const char *kBusinessIdElementName = "BusinessId";
 static NSUInteger kBusinessIdElementNameLength = 11; 

 static const char *kBusinessElementName = "Business";
 static NSUInteger kBusinessElementNameLength = 9; 

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, ktblBusinessElementName, ktblBusinessElementNameLength))
	{
		arrData = [[NSMutableArray alloc]init];
	}
	else if(0 == strncmp((const char *)localname, kURLElementName, kURLElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kSupportEmailElementName, kSupportEmailElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kPhoneNumberElementName, kPhoneNumberElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kImageDataElementName, kImageDataElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kFaxNumberElementName, kFaxNumberElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kExternal_biz_idElementName, kExternal_biz_idElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kEINElementName, kEINElementNameLength))
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
	else if(0 == strncmp((const char *)localname, kContactEmailElementName, kContactEmailElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kBusinessTypeIdElementName, kBusinessTypeIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kBusinessNameElementName, kBusinessNameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kBusinessIdElementName, kBusinessIdElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kBusinessElementName, kBusinessElementNameLength))
	{
		 currentObject = [[BusinessBO alloc]init];
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
	if(0 == strncmp((const char *)localname, kURLElementName, kURLElementNameLength))
	{
		currentObject.URL = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kSupportEmailElementName, kSupportEmailElementNameLength))
	{
		currentObject.SupportEmail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kPhoneNumberElementName, kPhoneNumberElementNameLength))
	{
		currentObject.PhoneNumber = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedOnElementName, kModifiedOnElementNameLength))
	{
		//currentObject.ModifiedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kModifiedByElementName, kModifiedByElementNameLength))
	{
		//currentObject.ModifiedBy = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kIsActiveElementName, kIsActiveElementNameLength))
	{
		//currentObject.IsActive = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kImageDataElementName, kImageDataElementNameLength))
	{
		currentObject.ImageData = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kImageElementName, kImageElementNameLength))
	{
		currentObject.Image = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kFaxNumberElementName, kFaxNumberElementNameLength))
	{
		currentObject.FaxNumber = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kExternal_biz_idElementName, kExternal_biz_idElementNameLength))
	{
		currentObject.External_biz_id = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kEINElementName, kEINElementNameLength))
	{
		currentObject.EIN = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedOnElementName, kCreatedOnElementNameLength))
	{
		//currentObject.CreatedOn = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kCreatedByElementName, kCreatedByElementNameLength))
	{
		//currentObject.CreatedBy = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kContactEmailElementName, kContactEmailElementNameLength))
	{
		currentObject.ContactEmail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kBusinessTypeIdElementName, kBusinessTypeIdElementNameLength))
	{
		//currentObject.BusinessTypeId = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kBusinessNameElementName, kBusinessNameElementNameLength))
	{
		currentObject.BusinessName = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kBusinessIdElementName, kBusinessIdElementNameLength))
	{
		currentObject.BusinessId = [self.currentValue integerValue];
	}
	else if(0 == strncmp((const char *)localname, kBusinessElementName, kBusinessElementNameLength))
	{
        [arrData addObject:self.currentObject];
        [currentObject release];
        currentObject = nil;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(BusinessXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(BusinessXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
[(id)[self delegate] BusinessXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end