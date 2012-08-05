//
//  EventListDA.m
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventListDA.h"


@implementation EventListDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[EventList TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[EventList TableName]];
}


-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[EventList TableName] WithPrimaryKey:[EventList PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[EventList TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

@end
