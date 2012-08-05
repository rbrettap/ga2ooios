//
//  BaseBusinessObject.m
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseBusinessObject.h"


@implementation BaseBusinessObject

-(void)CopyData:(BaseCoreDataObject*)object
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"CopyData method has not been implemented by the base class."] userInfo:nil];
}

@end
