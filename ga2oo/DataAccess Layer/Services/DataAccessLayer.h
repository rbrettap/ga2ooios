//
//  DataAccessLayer.h
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCoreDataObject.h"

@interface DataAccessLayer : NSObject 
{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(BaseCoreDataObject *)NewRecord;
-(BOOL)Save;
-(NSMutableArray*)SelectAll;
-(BaseCoreDataObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString;
-(NSMutableArray*)FilterArrayUsingSort:(NSString*)Filter_text;
-(void)DeleteAll;

- (NSMutableArray*)fetchAllRecords:(NSString *)tableName;
- (NSMutableArray*)fetchAllRecords:(NSString *)tableName byPredicate:(NSPredicate *)predicate;
- (BaseCoreDataObject *)fetchSingleRecord:(NSString*)tableName WithPrimaryKey:(NSString *)primaryKey AndValue:(NSString*)value withTypecast:(BOOL)ModeString;

@end
