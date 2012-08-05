//
//  EventsDA.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "EventsDA.h"


@implementation EventsDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[Events TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[Events TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[Events TableName] WithPrimaryKey:[Events PrimarykeyColumnName] AndValue:Key  withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[Events TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:Filter_text];
    NSMutableArray *arr_fetch = [self fetchAllRecords:[Events TableName] byPredicate:predicate];
    return arr_fetch;
}

@end
