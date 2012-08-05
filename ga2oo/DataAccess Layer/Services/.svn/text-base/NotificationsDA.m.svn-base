//
//  NotificationsDA.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "NotificationsDA.h"


@implementation NotificationsDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[EventNotifications TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[EventNotifications TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[EventNotifications TableName] WithPrimaryKey:[EventNotifications PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[EventNotifications TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

@end
