//
//  RegistrationBL.m
//  Ga2oo
//
//  Created by AJIT MISHRA on 6/4/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import "RegistrationBL.h"


@implementation RegistrationBL

@synthesize delegate;
@synthesize connection;

-(void)RegisterTheUserwith:(RegisterObject *)regObj
{
       [self performSelectorOnMainThread:@selector(RegistrationXML:) withObject:regObj waitUntilDone:NO];
	 
}

-(void)RegistrationXML:(RegisterObject *)regObj
{
	CompletedParser = NO;
	parser =nil;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
     parser = [RegistrationXML saxParser];
 	parser.regObj = regObj;
    parser.delegate = self; 
    [parser getData];
    [pool release];
}

- (void)RegistrationXML_Error:(RegistrationXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(RegistrationCompleted:)])
	{
		[(id)[self delegate] RegistrationCompleted:Object];
	}
}

- (void)RegistrationXML_Finished:(ServiceOutput *)parser1
{    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(RegistrationCompleted:)])
	{
		[(id)[self delegate] RegistrationCompleted:parser1];
	}
	CompletedParser =YES;
}

-(void)RegistrationCompleted:(RegisterObject *)Object
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
