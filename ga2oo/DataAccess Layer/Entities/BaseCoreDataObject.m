//
//  BaseBusinessObject.m
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseCoreDataObject.h"

@implementation BaseCoreDataObject

-(void)CopyData:(BaseBusinessObject*)object
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"CopyData method has not been implemented by the base class."] userInfo:nil];
}

+(NSString*)TableName
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"TableName method has not been implemented by the base class."] userInfo:nil];
    
    return nil;
}

+(NSString*)PrimarykeyColumnName
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"PrimarykeyColumnName method has not been implemented by the base class."] userInfo:nil];
    
    return nil;
}

@end
