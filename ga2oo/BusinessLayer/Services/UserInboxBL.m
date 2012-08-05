//
//  UserInboxBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserInboxBL.h"


@implementation UserInboxBL
@synthesize delegate;

-(BOOL)Insert:(UserInboxBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserInboxDA *dataAccessLayer = [[UserInboxDA alloc]init];
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

-(BOOL)Update:(UserInboxBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserInboxDA *dataAccessLayer = [[UserInboxDA alloc]init];
    NSString *PrimarykeyColumnName = [UserInbox PrimarykeyColumnName];
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
    for(UserInboxBO *object in arrData)
    {
        NSString *key = [object valueForKey:[UserInbox PrimarykeyColumnName]];
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
    UserInboxDA *dataAccessLayer = [[UserInboxDA alloc]init];
    BaseCoreDataObject *UserInbCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserInboxBO *UserInb = nil; 
    
    if(UserInbCDO != nil)
    {
        UserInb = [[UserInboxBO alloc] init];
        [UserInb CopyData:UserInbCDO];
    }
    
    [dataAccessLayer release];
    return UserInb;
}

-(NSMutableArray*)SelectAll
{
    UserInboxDA *dataAccessLayer = [[UserInboxDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    UserInboxDA *dataAccessLayer = [[UserInboxDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUserInbox
{
    [self performSelectorOnMainThread:@selector(NewUserInboxXml) withObject:nil waitUntilDone:NO];
}

-(void)NewUserInboxXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    UserInboxXML *parser = [UserInboxXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)UserInboxXML_Error:(UserInboxXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserInboxLoadingCompleted)])
	{
		[(id)[self delegate] UserInboxLoadingCompleted];
	}
}

- (void)UserInboxXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserInboxLoadingCompleted)])
	{
		[(id)[self delegate] UserInboxLoadingCompleted];
	}
}

-(void)UserInboxLoadingCompleted
{
    
}

@end
