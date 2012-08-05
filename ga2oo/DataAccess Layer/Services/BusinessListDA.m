//
//  BusinessListDA.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessListDA.h"


@implementation BusinessListDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[BusinessList TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[BusinessList TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[BusinessList TableName] WithPrimaryKey:[BusinessList PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[BusinessList TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:Filter_text];
    NSMutableArray *arr_fetch = [self fetchAllRecords:[BusinessList TableName] byPredicate:predicate];
    return arr_fetch;
}

@end
