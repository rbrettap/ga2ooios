//
//  UserNotificationTypesBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserNotificationTypesBL.h"


@implementation UserNotificationTypesBL
@synthesize delegate;

-(BOOL)Insert:(UserNotificationTypesBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserNotificationTypesDA *dataAccessLayer = [[UserNotificationTypesDA alloc]init];
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

-(BOOL)Update:(UserNotificationTypesBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserNotificationTypesDA *dataAccessLayer = [[UserNotificationTypesDA alloc]init];
    NSString *PrimarykeyColumnName = [UserNotificationTypes PrimarykeyColumnName];
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
    for(UserNotificationTypesBO *object in arrData)
    {
        NSString *key = [object valueForKey:[UserNotificationTypes PrimarykeyColumnName]];
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
    UserNotificationTypesDA *dataAccessLayer = [[UserNotificationTypesDA alloc]init];
    BaseCoreDataObject *UserNotiCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserNotificationTypesBO *UserNoti = nil; 
    
    if(UserNotiCDO != nil)
    {
        UserNoti = [[UserNotificationTypesBO alloc] init];
        [UserNoti CopyData:UserNotiCDO];
    }
    
    [dataAccessLayer release];
    return UserNoti;
}

-(NSMutableArray*)SelectAll
{
    UserNotificationTypesDA *dataAccessLayer = [[UserNotificationTypesDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    UserNotificationTypesDA *dataAccessLayer = [[UserNotificationTypesDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUserNotificationTypes
{
    [self performSelectorOnMainThread:@selector(NewUserNotificationTypesXml) withObject:nil waitUntilDone:NO];
}

-(void)NewUserNotificationTypesXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    UserNotificationTypesXML *parser = [UserNotificationTypesXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)UserNotificationTypesXML_Error:(UserNotificationTypesXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserNotificationTypesLoadingCompleted)])
	{
		[(id)[self delegate] UserNotificationTypesLoadingCompleted];
	}
}

- (void)UserNotificationTypesXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserNotificationTypesLoadingCompleted)])
	{
		[(id)[self delegate] UserNotificationTypesLoadingCompleted];
	}
}

-(void)UserNotificationTypesLoadingCompleted
{
    
}

@end
