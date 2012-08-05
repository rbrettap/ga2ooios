//
//  UpdateProfileBL.m
//  Ga2oo
//
//  Created by Mayank goyal on 30/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UpdateProfileBL.h"
#import "NSData+Base64+GZip.h"


@implementation UpdateProfileBL

@synthesize delegate;
@synthesize connection;

-(void)uploadProfileImageToServer:(UIImage *)profileImage{
	
	 appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSData * binData = UIImageJPEGRepresentation(profileImage, 0.8);
	//[binData encodeWithCoder:NSAS]
	//NSString *str = [[NSString alloc]initWithData:binData encoding:NSASCIIStringEncoding];
	
	NSString *str = [binData base64EncodedString];

	NSString *strSoapMsg =  [NSString stringWithFormat:@
							 "<useraccount>"
							 "<id>%@</id>"
							 "<image>%@</image>"
							 "</useraccount>",appDelegate.currentUserID,str];

 
	//strSoapMsg = [strSoapMsg stringByReplacingOccurrencesOfString:@"imageplace" withString:str];
	NSString *newstr = [[NSString alloc] initWithFormat:@"%@", Ga200UpdateUserProfileImage];
	NSString *soapMsg = [[NSString alloc] initWithFormat:@"%@",strSoapMsg];
	NSString *msgLength = [NSString stringWithFormat:@"%i", [soapMsg length]];
	
	NSDateFormatter *dtf = [[NSDateFormatter alloc]init];
	[dtf setDateFormat:@"yyyy-MMM-dd HH:mm:ss"];
	NSString *strdt = [dtf stringFromDate:[NSDate date]];
	[dtf release];
	
	NSURL *myURL = [[NSURL alloc] initWithString:[newstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL:myURL]; 
	[myRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[myRequest addValue:strdt forHTTPHeaderField:@"Date"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];

	
	NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:myRequest delegate:self];
	self.connection = con;
	
	///////////////////////////////
	
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *dats = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	NSLog(@"The  error is  %@",[error description]);
	NSString *temstr = [[NSString alloc]initWithData:dats encoding:NSUTF8StringEncoding];
	NSLog(@"temstr --%@--",temstr);
	[temstr release];
	NSLog(@"newstr , %@",newstr);
    NSLog(@"temstr %@",soapMsg);
    NSLog(@"newstr , %@",msgLength);
	NSLog(@"strdt , %@",strdt);
   
	 
	
	//////////////////////
	[con release];
	[myURL release];
	[newstr release];
	[soapMsg release];
    [myRequest release];
    
    [(id)[self delegate] uploadProfileImageToServerCompleted];
	
	
	
	
	
}

-(void)LoadUpdateProfilewith:(NSString *)soapMsg
{
      [self performSelectorOnMainThread:@selector(UpdateProfileXML:) withObject:soapMsg waitUntilDone:NO];
}

-(void)UpdateProfileXML:(NSString *)soapMsg
{
	CompletedParser = NO;
	parser =nil;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	//[userId retain];
    parser = [UpdateProfileXML saxParser];
 	parser.strSoapMsg = soapMsg;
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)UpdateProfileXML_Error:(UpdateProfileXML*)parser encounteredError:(NSError *)error with:(UpdateProfileBO *)Object
{
	CompletedParser =YES;
	
	NSLog(@"profiel update error %@",[error description]);
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UpdateProfileCompleted:)])
	{
		[(id)[self delegate] UpdateProfileCompleted:Object];
	}
}

- (void)UpdateProfileXML_Finished:(UpdateProfileBO *)parser1
{    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UpdateProfileCompleted:)])
	{
		[(id)[self delegate] UpdateProfileCompleted:parser1];
	}
	CompletedParser =YES;
}

-(void)UpdateProfileCompleted:(UpdateProfileBO *)Object
{
    
}

-(void)dealloc
{
	if(!CompletedParser)
	{
		parser.delegate =nil;
	}
	parser =nil;
	
	[super dealloc];
}


@end
