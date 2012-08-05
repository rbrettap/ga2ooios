//
//  FavoriteBusinessEventDA.m
//  Ga2oo
//
//  Created by Suresh on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoriteBusinessEventDA.h"


@implementation FavoriteBusinessEventDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[FavoriteBusinessEvent TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[FavoriteBusinessEvent TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[FavoriteBusinessEvent TableName] WithPrimaryKey:[FavoriteBusinessEvent PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[FavoriteBusinessEvent TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}


@end
