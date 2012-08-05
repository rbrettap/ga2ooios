//
//  tblUserDA.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserDA.h"


@implementation UserDA

 
-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[User TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[User TableName]];
}
  
-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
	return [self fetchSingleRecord:[User TableName] WithPrimaryKey:[User PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[User TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:Filter_text];
    NSMutableArray *arr_fetch = [self fetchAllRecords:[User TableName] byPredicate:predicate];
    return arr_fetch;
}


@end
