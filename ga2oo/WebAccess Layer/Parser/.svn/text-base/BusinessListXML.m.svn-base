#import "BusinessListXML.h"
#import "BusinessListBO.h"

@interface BusinessListXML(LibXMLParserMethods)

- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes;
- (void)endElement:(const xmlChar *)localname prefix:(const xmlChar *)prefix uri:(const xmlChar *)URI;
- (void)charactersFound:(const xmlChar *)characters length:(int)length;
- (void)parsingError:(const char *)msg, ...;
- (void)endDocument;

@end

@implementation BusinessListXML

@synthesize currentValue;
@synthesize _currentParentElement;
@synthesize currentObject;
@synthesize arrData;


- (BOOL)parseWithLibXML2Parser{
	
	NSString *newstr = [[NSString alloc] initWithFormat:Ga2ooBusineList];
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	[con release];
	[myURL release];
	[newstr release];
	return [self doParsing];
}


 static const char *kzipElementName = "zipcode";
 static NSUInteger kzipElementNameLength = 8; 

 static const char *kurlElementName = "url";
 static NSUInteger kurlElementNameLength = 4; 

 static const char *ksupportemailElementName = "supportemail";
 static NSUInteger ksupportemailElementNameLength = 13; 

 static const char *kstateElementName = "state";
 static NSUInteger kstateElementNameLength = 6; 

 static const char *kphoneElementName = "phone";
 static NSUInteger kphoneElementNameLength = 6; 

 static const char *klocationElementName = "location";
 static NSUInteger klocationElementNameLength = 9; 

 static const char *kis_activeElementName = "is_active";
 static NSUInteger kis_activeElementNameLength = 10; 

 static const char *kidElementName = "id";
 static NSUInteger kidElementNameLength = 3; 

 static const char *kgeocodeElementName = "geocode";
 static NSUInteger kgeocodeElementNameLength = 8; 

 static const char *kfaxElementName = "fax";
 static NSUInteger kfaxElementNameLength = 4; 

 static const char *keinElementName = "ein";
 static NSUInteger keinElementNameLength = 4; 

 static const char *kcountryElementName = "country";
 static NSUInteger kcountryElementNameLength = 8; 

 static const char *kcontactnameElementName = "contactname";
 static NSUInteger kcontactnameElementNameLength = 12; 

 static const char *kcontactemailElementName = "contactemail";
 static NSUInteger kcontactemailElementNameLength = 13; 

 static const char *kcityElementName = "city";
 static NSUInteger kcityElementNameLength = 5; 

 static const char *kbusinesstypeElementName = "businesstype";
 static NSUInteger kbusinesstypeElementNameLength = 13; 

 static const char *kbusinessesElementName = "businesses";
 static NSUInteger kbusinessesElementNameLength = 11; 

 static const char *kbiznameElementName = "bizname";
 static NSUInteger kbiznameElementNameLength = 8; 

 static const char *kaddressElementName = "address";
 static NSUInteger kaddressElementNameLength = 8; 

 static const char *kaccountElementName = "account";
 static NSUInteger kaccountElementNameLength = 8; 


- (void)elementFound:(const xmlChar *)localname prefix:(const xmlChar *)prefix
uri:(const xmlChar *)URI namespaceCount:(int)namespaceCount
namespaces:(const xmlChar **)namespaces attributeCount:(int)attributeCount
defaultAttributeCount:(int)defaultAttributeCount attributes:(xmlSAX2Attributes *)attributes
{
	if(0 == strncmp((const char *)localname, kbusinessesElementName, kbusinessesElementNameLength))
	{
		arrData = [[NSMutableArray alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kaccountElementName, kaccountElementNameLength))
	{
		currentObject = [[BusinessListBO alloc] init];
	}
	else if(0 == strncmp((const char *)localname, kzipElementName, kzipElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kurlElementName, kurlElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, ksupportemailElementName, ksupportemailElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kstateElementName, kstateElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kphoneElementName, kphoneElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, klocationElementName, klocationElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kis_activeElementName, kis_activeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kfaxElementName, kfaxElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, keinElementName, keinElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcontactnameElementName, kcontactnameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcontactemailElementName, kcontactemailElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kcityElementName, kcityElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kbusinesstypeElementName, kbusinesstypeElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	
	else if(0 == strncmp((const char *)localname, kbiznameElementName, kbiznameElementNameLength))
	{
		self.currentValue = [NSMutableString string];
	}
	else if(0 == strncmp((const char *)localname, kaddressElementName, kaddressElementNameLength))
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
	if(0 == strncmp((const char *)localname, kaccountElementName, kaccountElementNameLength))
	{
		[arrData addObject:currentObject];
		[currentObject release];
		currentObject = nil;
	}
	else if(0 == strncmp((const char *)localname, kzipElementName, kzipElementNameLength))
	{
		currentObject.zipcode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kurlElementName, kurlElementNameLength))
	{
		currentObject.url = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, ksupportemailElementName, ksupportemailElementNameLength))
	{
		currentObject.supportemail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kstateElementName, kstateElementNameLength))
	{
		currentObject.state = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kphoneElementName, kphoneElementNameLength))
	{
		currentObject.phone = self.currentValue;
	}
	 	else if(0 == strncmp((const char *)localname, kis_activeElementName, kis_activeElementNameLength))
	{
		currentObject.is_active = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kidElementName, kidElementNameLength))
	{
		currentObject.bussinessId = self.currentValue ;
	}
	else if(0 == strncmp((const char *)localname, kgeocodeElementName, kgeocodeElementNameLength))
	{
		currentObject.geocode = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kfaxElementName, kfaxElementNameLength))
	{
		currentObject.fax = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, keinElementName, keinElementNameLength))
	{
		currentObject.ein = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcountryElementName, kcountryElementNameLength))
	{
		currentObject.country = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcontactnameElementName, kcontactnameElementNameLength))
	{
		currentObject.contactname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcontactemailElementName, kcontactemailElementNameLength))
	{
		currentObject.contactemail = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kcityElementName, kcityElementNameLength))
	{
		currentObject.city = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kbusinesstypeElementName, kbusinesstypeElementNameLength))
	{
		currentObject.businesstype = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kbiznameElementName, kbiznameElementNameLength))
	{
		currentObject.bizname = self.currentValue;
	}
	else if(0 == strncmp((const char *)localname, kaddressElementName, kaddressElementNameLength))
	{
		currentObject.address = self.currentValue;
	}
	self.currentValue = nil;
}

-(void)endDocument
{
	if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(BusinessListXML_Finished:)])
	{
		[(id)[self delegate] performSelectorOnMainThread:@selector(BusinessListXML_Finished:)withObject:arrData waitUntilDone:YES];
		[self autorelease];
	}
}

-(void)SaxXMLParserError:(SaxXMLParser *)parser EncounteredError:(NSError *)err
{
	[(id)[self delegate] BusinessListXML_Error:self encounteredError:err];
}

- (void)dealloc
{
	self.retrieverQueue = nil;
	self.delegate = nil;
	[super dealloc];
}

@end