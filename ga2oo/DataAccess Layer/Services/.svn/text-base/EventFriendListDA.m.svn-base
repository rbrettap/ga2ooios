//
//  EventFriendListDA.m
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendListDA.h"


@implementation EventFriendListDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[EventFriendList TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[EventFriendList TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[EventFriendList TableName] WithPrimaryKey:[EventFriendList PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[EventFriendList TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:Filter_text];
    NSMutableArray *arr_fetch = [self fetchAllRecords:[EventFriendList TableName] byPredicate:predicate];
    return arr_fetch;
}


@end
