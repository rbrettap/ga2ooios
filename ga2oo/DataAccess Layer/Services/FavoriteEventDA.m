//
//  FavoriteEventDA.m
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoriteEventDA.h"


@implementation FavoriteEventDA


-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[AddFavEvent TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[AddFavEvent TableName]];
}


-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[AddFavEvent TableName] WithPrimaryKey:[AddFavEvent PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[AddFavEvent TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}


@end
