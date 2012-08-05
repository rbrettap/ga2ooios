//
//  BaseBusinessObject.h
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BaseBusinessObject;

@interface BaseCoreDataObject : NSManagedObject
{
    
}

-(void)CopyData:(BaseBusinessObject*)object;
+(NSString*)TableName;
+(NSString*)PrimarykeyColumnName;

@end
