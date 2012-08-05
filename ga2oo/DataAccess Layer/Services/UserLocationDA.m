//
//  UserLocationDA.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserLocationDA.h"


@implementation UserLocationDA

-(BaseCoreDataObject *)NewRecord
{
    return [NSEntityDescription insertNewObjectForEntityForName:[UserLocation TableName] inManagedObjectContext:managedObjectContext]; 
}

-(NSMutableArray*)SelectAll
{
    return [self fetchAllRecords:[UserLocation TableName]];
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    return [self fetchSingleRecord:[UserLocation TableName] WithPrimaryKey:[UserLocation PrimarykeyColumnName] AndValue:Key withTypecast:ModeString];
}

-(void)DeleteObject:(BaseCoreDataObject*)object
{
	/*
	NSMutableArray *arrData = [self fetchAllRecords:[UserLocation TableName]];
    
	for(UserLocation *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            UserLocationBO *EventLoc = [[UserLocationBO alloc] init];
            [EventLoc CopyData:EventsCDO];
			if ([EventLoc.LocationId isEqualToString:<#(NSString *)aString#>]) {
				<#statements#>
			}
			
             [EventLoc release];
            EventLoc=nil;
        }
    }
	
    for(BaseCoreDataObject *object in arrData)
    {
		 
        [managedObjectContext deleteObject:object];
    }
	 */
    [managedObjectContext deleteObject:object];
}

-(void)DeleteAll
{
    NSMutableArray *arrData = [self fetchAllRecords:[UserLocation TableName]];
    
    for(BaseCoreDataObject *object in arrData)
    {
        [managedObjectContext deleteObject:object];
    }
}

@end

