//
//  BaseBussinessLayer.m
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseBussinessLayer.h"


@implementation BaseBussinessLayer


-(BOOL)Insert:(BaseBusinessObject*)BaseBusinessObj withSave:(BOOL)Save
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"Insert method has not been implemented by the base class."] userInfo:nil];
    
    return NO;
}

-(BOOL)Update:(BaseBusinessObject*)BaseBusinessObj withSave:(BOOL)Save
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"Update method has not been implemented by the base class."] userInfo:nil];
    
    return NO;
}


-(void)InsertArray:(NSMutableArray*)arrData
{
   @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"InsertArray method has not been implemented by the base class."] userInfo:nil]; 
}

-(NSMutableArray*)FilerDataUsing:(NSString*)strPredicate
{
     @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"FilerDataUsing method has not been implemented by the base class."] userInfo:nil]; 
}

-(NSMutableArray*)SelectAll
{
    DataAccessLayer *dataAccessLayer = [[DataAccessLayer alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    [dataAccessLayer release];
    
    return arrData;
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
	@throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"SelectByKey method has not been implemented by the base class."] userInfo:nil]; 

}


-(BOOL)Save
{
    DataAccessLayer *dataAccessLayer = [[DataAccessLayer alloc]init];
    BOOL saved = TRUE;
    
    saved = [dataAccessLayer Save];
    
    [dataAccessLayer release];
    return saved;
}

-(void)deleteAll
{
   
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
		
    } // while //
    
    return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
}




@end
