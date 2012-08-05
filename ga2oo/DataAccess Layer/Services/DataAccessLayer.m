//
//  DataAccessLayer.m
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataAccessLayer.h"

@implementation DataAccessLayer
@synthesize managedObjectContext;

-(id)init
{
    if((self = [super init]))
    {
        Ga2ooAppDelegate *appDelegate = (Ga2ooAppDelegate*)[[UIApplication sharedApplication]delegate];
        managedObjectContext = [appDelegate managedObjectContext];
    }
    return self;
}

-(NSMutableArray*)SelectAll
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"SelectAll method has not been implemented by the base class."] userInfo:nil];
    return nil;
}

-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"SelectByKey method has not been implemented by the base class."] userInfo:nil];
    return nil;
}

-(BaseCoreDataObject *)NewRecord
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"NewRecord method has not been implemented by the base class."] userInfo:nil];
    return nil;
}

-(void)DeleteAll
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"DeleteAll method has not been implemented by the base class."] userInfo:nil];
}

-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text
{
    @throw [[NSException alloc] initWithName:[NSString stringWithString:@"MethodNotImplemented."] reason:[NSString stringWithString:@"FilterArrayUsingSort method has not been implemented by the base class."] userInfo:nil];
}

-(BOOL)Save
{
    BOOL returnValue = TRUE;
    
    NSError *error;
    if ([managedObjectContext hasChanges])
    {
        if([managedObjectContext save:&error])
        {
            
        }
        else
        {
            // This is a serious error saying the record could not be saved.
            // Advise the user to restart the application
            
             @throw [[NSException alloc] initWithName:[NSString stringWithString:@"CoreDataError"] reason:[NSString stringWithString:@"Core data cannot be accessed. Please restart the application."] userInfo:nil];
            
            returnValue = FALSE;
        }
    }
    
    return returnValue;
}

- (NSMutableArray*)fetchAllRecords:(NSString *)tableName
{
	// Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:managedObjectContext];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	if (!mutableFetchResults)
    {
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
	}
	
	// Save our fetched data to an array
	//[mutableFetchResults release];
	[request release];
    
    return [mutableFetchResults autorelease];
}

- (NSMutableArray*)fetchAllRecords:(NSString *)tableName byPredicate:(NSPredicate *)predicate
{
	NSMutableArray *mutableFetchResults = [self fetchAllRecords: tableName];
    // apply predicate arrData
	if (mutableFetchResults)
    {
        [mutableFetchResults filterUsingPredicate:predicate];
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
	}
    
    return mutableFetchResults;
}

- (BaseCoreDataObject *)fetchSingleRecord:(NSString*)tableName WithPrimaryKey:(NSString *)primaryKey AndValue:(NSString*)value withTypecast:(BOOL)ModeString
{

    NSManagedObject *obj = nil;
	
    NSString *strPredicate;

	if(ModeString)
	{
		strPredicate = [NSString stringWithFormat:@"%@='%@'", primaryKey, value];
	}
	else 
	{
		strPredicate = [NSString stringWithFormat:@"%@=%@", primaryKey, value];
	}

    NSPredicate *predicate = [NSPredicate predicateWithFormat:strPredicate];
	NSMutableArray *mutableFetchResults = [self fetchAllRecords: tableName byPredicate:predicate];
	
    // apply predicate arrData
    
	if (mutableFetchResults)
    {
        if([mutableFetchResults count])
        {
            obj = [mutableFetchResults objectAtIndex:0];
        }
    }
    else
    {
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
	}
    
    return (BaseCoreDataObject*)obj;
}


@end
