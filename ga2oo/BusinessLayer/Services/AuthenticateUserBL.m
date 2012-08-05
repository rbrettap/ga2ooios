//
//  AuthenticateUserBL.m
//  Ga2oo
//
//  Created by Fakhre Alam on 30/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthenticateUserBL.h"


@implementation AuthenticateUserBL
@synthesize delegate;


-(void)LoadAuthenticateUserWith:(NSString *)soapMsg
{
 
    [self performSelectorOnMainThread:@selector(AuthenticateUserXML:) withObject:soapMsg waitUntilDone:NO];
}

-(void)AuthenticateUserXML:(NSString *)soapMsg
{
	CompletedParser = NO;
	parser =nil;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
     parser = [AuthenticateUserXML saxParser];
 	parser.strSoapMsg = soapMsg;
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)AuthenticateUserXML_Error:(AuthenticateUserXML*)parser encounteredError:(NSError *)error with:(AuthenticateUserBO *)Object
{
	CompletedParser =YES;
	NSString *strError = [error description];
	
	if(strError)
	{
		NSRange range;
		range = [strError rangeOfString: @"Timed out"
								options: NSCaseInsensitiveSearch];
		if(range.length == 9)
		{
			Object.Response = @"Timed out";
		}
	}

	if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(AuthenticateUserCompleted:)])
	{
		[(id)[self delegate] AuthenticateUserCompleted:Object];
	}
}

- (void)AuthenticateUserXML_Finished:(AuthenticateUserBO*)Object;
{    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(AuthenticateUserCompleted:)])
	{
		[(id)[self delegate] AuthenticateUserCompleted:Object];
	}
	CompletedParser =YES;
}

-(void)AuthenticateUserCompleted:(AuthenticateUserBO *)Object
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
