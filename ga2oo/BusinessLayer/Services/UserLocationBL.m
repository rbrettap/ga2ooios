//
//  UserLocationBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserLocationBL.h"
#import "ServiceOutput.h"
#import "ServiceRequestXML.h"
#import "HttpRequest.h"


@implementation UserLocationBL
@synthesize delegate;
@synthesize connection;

-(void)saveTheLocationInServerForLocation:(UserLocationBO *)savinObj{
	
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
 	 
	[self RequestTheServiceToAddLocations:savinObj];
	 
}

-(void)setTheLocatioAsPrimary:(UserLocationBO *)selObj{
	
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	NSString *strUrl = [NSString stringWithFormat:@"%@",Ga200UpdateUserPrimaryLocation];
	NSString *strSoapMsg =  [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<useraccount>\n"
							 "<id>%@</id>\n"
  							 "<locationid>%@</locationid>\n"
 							 "</useraccount>\n",appDelegate.currentUserID,selObj.LocationId];
	
	NSMutableArray *arrRequest = [[NSMutableArray alloc]init]	;
	[arrRequest addObject:strUrl];
	[arrRequest addObject:strSoapMsg];
	[self performSelectorOnMainThread:@selector(ServiceRequestXML:) withObject:arrRequest waitUntilDone:NO];
	
}
-(BOOL)deleteTheLocatioFromServer:(UserLocationBO *)selObj{
	
	appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	strLocIdToDelete=selObj.LocationId;
	 if(appDelegate.isNetAvail)
	{
		HttpRequest *request = [[HttpRequest alloc] init];
 		[request PostRequestToDelete:[NSString stringWithFormat:@"%@id/%@/deleteids/%@",Ga200SaveUserLocation,appDelegate.currentUserID,selObj.LocationId] Delegate:self Tag:0];
  		[request release];		
		return TRUE;
	}
	else {
 		return FALSE;
 	}
 
	 }
-(void)RequestTheServiceToAddLocations:(UserLocationBO *)savinObj
{
	
	//NSString *strUrl = [[NSString alloc] initWithFormat:@"%@",Ga200SaveUserLocation];
//	NSString *strSoapMsg =  [[NSString alloc] initWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 
	NSString *strUrl = [NSString stringWithFormat:@"%@",Ga200SaveUserLocation];
	NSString *strSoapMsg =  [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<useraccount>\n"
							 "<id>%@</id>\n"
							 "<savedlocations>\n"
							 "<location>\n"
							 "<is_primary>%@</is_primary>\n"
							 "<geocode>%@</geocode>\n"
							 "<address>%@</address>\n"
							 "<city>%@</city>\n"
							 "<state>%@</state>\n"
							 "<zipcode>%@</zipcode>\n"
							 "<country>%@</country>\n"
							 "</location>\n"
							 "</savedlocations>\n"
							 "</useraccount>\n",appDelegate.currentUserID,savinObj.IsPrimary,savinObj.GeoPoint,savinObj.Address,savinObj.City,savinObj.State,savinObj.Zipcode,savinObj.Country];
	
	NSLog(@"add location request %@",strSoapMsg);
	NSMutableArray *arrRequest = [[NSMutableArray alloc]init]	;
	[arrRequest addObject:strUrl];
	[arrRequest addObject:strSoapMsg];
	
	[self performSelectorOnMainThread:@selector(ServiceRequestXML:) withObject:arrRequest waitUntilDone:NO];
	
}

-(void)ServiceRequestXML:(NSMutableArray *)arrRequest
{
  	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	ServiceRequestXML *parser = [ServiceRequestXML saxParser];
 	parser.arrRequest = arrRequest;
    parser.delegate = self; 
    [parser getData];
    [pool release];
}

- (void)ServiceRequestXML_Error:(ServiceRequestXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object
{
     if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompleted:)])
	{
		[(id)[self delegate] ServiceRequestCompleted:Object];
	}
}


- (void)ServiceRequestXML_Finished:(ServiceOutput *)parser1
{    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompleted:)])
	{
		[(id)[self delegate] ServiceRequestCompleted:parser1];
	}
 }

-(void)ServiceRequestCompleted:(RegisterObject *)Object
{
    
}

-(BOOL)Insert:(UserLocationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer NewRecord];
    BOOL saved = TRUE;
    
    [baseBusinessObject CopyData:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(BOOL)Update:(UserLocationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];
    NSString *PrimarykeyColumnName = [UserLocation PrimarykeyColumnName];
    NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:primarykey withMode:YES];
    BOOL saved = TRUE;
    
    [baseBusinessObject CopyData:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(void)InsertArray:(NSMutableArray *)arrData
{
    for(UserLocationBO *object in arrData)
    {
        NSString *key = [object valueForKey:[UserLocation PrimarykeyColumnName]];
        BaseBusinessObject *object_business = [self SelectByKey:key withMode:YES];
        if(object_business != nil)
        {
            [self Update:object withSave:NO];
        }
        else
        {
            [self Insert:object withSave:NO];
        }
    }
    
    [self Save];
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];
    BaseCoreDataObject *UserLocCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserLocationBO *UserLoc = nil; 
    
    if(UserLocCDO != nil)
    {
        UserLoc = [[UserLocationBO alloc] init];
        [UserLoc CopyData:UserLocCDO];
    }
    
    [dataAccessLayer release];
    if (UserLoc) {
        return [UserLoc autorelease];

    }
    else{
        return nil;

    }
}


-(void)DeleteObject:(UserLocationBO *)BaseBusinessObj
{
	UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];

	BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:BaseBusinessObj.LocationId withMode:YES];
	if (baseBusinessObject!=nil) {
		[dataAccessLayer DeleteObject:baseBusinessObject];
		[self Save];

	}
    [dataAccessLayer release];

}


-(NSMutableArray*)SelectAll
{
	UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(UserLocation *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            UserLocationBO *EventLoc = [[UserLocationBO alloc] init];
            [EventLoc CopyData:EventsCDO];
            [ArrCopyObjects addObject:EventLoc];
            [EventLoc release];
            EventLoc=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(void)deleteAll
{
    UserLocationDA *dataAccessLayer = [[UserLocationDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUserLocation
{
    [self performSelectorOnMainThread:@selector(NewUserLocationXml) withObject:nil waitUntilDone:NO];
}

-(void)NewUserLocationXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    UserLocationXML *parser = [UserLocationXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)UserLocationXML_Error:(UserLocationXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserLocationLoadingCompleted)])
	{
		[(id)[self delegate] UserLocationLoadingCompleted];
	}
}

- (void)UserLocationXML_Finished:(NSMutableArray*)arrSchedule;
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserLocationLoadingCompleted)])
	{
		[(id)[self delegate] UserLocationLoadingCompleted];
	}
}

-(void)UserLocationLoadingCompleted
{
    
}


-(void)httpResponseReceived:(WebResponse *)response
{
	
	NSString *responseString = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
	NSLog(@"%@",responseString);
	NSString *opstr = [self flattenHTML:responseString];
	opstr=[opstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if ([strLocIdToDelete isEqualToString:opstr]) {
		if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompleted:)])
		{
			[(id)[self delegate] ServiceRequestCompleted:[ServiceOutput stringWithTheResponseString:@"Success"]];
		}
		
	}
	else {
		if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompleted:)])
		{
			[(id)[self delegate] ServiceRequestCompleted:[ServiceOutput stringWithTheResponseString:opstr]];
		}
		
	}

	
	

}


- (NSString *)flattenHTML:(NSString *)html {
	
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
		
	}  
	
	return html;
	
}


@end
