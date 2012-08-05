//
//  UserEventsBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserEventsBL.h"


@implementation UserEventsBL
@synthesize delegate;

-(BOOL)Insert:(UserEventsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserEventsDA *dataAccessLayer = [[UserEventsDA alloc]init];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer NewRecord];
    BOOL saved = TRUE;
    
    [baseBusinessObject CopyData:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(BOOL)Update:(UserEventsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserEventsDA *dataAccessLayer = [[UserEventsDA alloc]init];
    NSString *PrimarykeyColumnName = [UserEvents PrimarykeyColumnName];
    NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:primarykey withMode:NO];
    BOOL saved = TRUE;
    
    [baseBusinessObject CopyData:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(void)InsertArray:(NSMutableArray *)arrData
{
    for(UserEventsBO *object in arrData)
    {
        NSString *key = [object valueForKey:[UserEvents PrimarykeyColumnName]];
        BaseBusinessObject *object_business = [self SelectByKey:key withMode:NO];
        if(object_business != nil)
        {
            [self Update:object withSave:NO];
        }
        else
        {
            [self Insert:object withSave:NO];
        }
    }
    
    [self Save];
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    UserEventsDA *dataAccessLayer = [[UserEventsDA alloc]init];
    BaseCoreDataObject *UserEventCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserEventsBO *UserEven = nil; 
    
    if(UserEventCDO != nil)
    {
        UserEven = [[UserEventsBO alloc] init];
        [UserEven CopyData:UserEventCDO];
    }
    
    [dataAccessLayer release];
    return UserEven;
}

-(NSMutableArray*)SelectAll
{
    UserEventsDA *dataAccessLayer = [[UserEventsDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    UserEventsDA *dataAccessLayer = [[UserEventsDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUserEvents
{
    [self performSelectorOnMainThread:@selector(NewUserEventsXml) withObject:nil waitUntilDone:NO];
}

-(void)NewUserEventsXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    UserEventsXML *parser = [UserEventsXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)UserEventsXML_Error:(UserEventsXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserEventsLoadingCompleted)])
	{
		[(id)[self delegate] UserEventsLoadingCompleted];
	}
}

- (void)UserEventsXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserEventsLoadingCompleted)])
	{
		[(id)[self delegate] UserEventsLoadingCompleted];
	}
}

-(void)UserEventsLoadingCompleted
{
    
}


@end
