//
//  NotificationsBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "NotificationsBL.h"


@implementation NotificationsBL
@synthesize delegate;

-(BOOL)Insert:(EventNotificationsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
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

-(BOOL)Update:(EventNotificationsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
    NSString *PrimarykeyColumnName = [EventNotifications PrimarykeyColumnName];
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
    for(EventNotificationsBO *object in arrData)
    {
        NSString *key = [object valueForKey:[EventNotifications PrimarykeyColumnName]];
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
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
    BaseCoreDataObject *NotificCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventNotificationsBO *Notific = nil; 
    
    if(NotificCDO != nil)
    {
        Notific = [[EventNotificationsBO alloc] init];
        [Notific CopyData:NotificCDO];
    }
    
    [dataAccessLayer release];
    return Notific;
}

-(NSMutableArray*)SelectAll
{
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventNotifications *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            EventNotificationsBO *User1 = [[EventNotificationsBO alloc] init];
            [User1 CopyData:UserCDO];
            [ArrCopyObjects addObject:User1];
            [User1 release];
            User1=nil;
        }
    }
	
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
	
}

-(void)deleteAll
{
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)deleteObjectForKey:(EventNotificationsBO  *)baseNotification
{
	
	
    NotificationsDA *dataAccessLayer = [[NotificationsDA alloc]init];
	BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:baseNotification.strsender withMode:YES];
    
    [dataAccessLayer DeleteObject:baseBusinessObject];
    [dataAccessLayer release];
}

-(void)LoadNotifications
{
    [self performSelectorOnMainThread:@selector(NewNotificationsXml) withObject:nil waitUntilDone:NO];
}

-(void)NewNotificationsXml
{
	CompletedParser = NO;
	parser = nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	parser = [UserNotificationsXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)UserNotificationsXML_Error:(UserNotificationsXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(NotificationsLoadingCompleted)])
	{
		[(id)[self delegate] NotificationsLoadingCompleted];
	}
}

- (void)UserNotificationsXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(NotificationsLoadingCompleted)])
	{
		[(id)[self delegate] NotificationsLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)NotificationsLoadingCompleted
{
}

-(void)dealloc
{
	if(!CompletedParser)
		parser.delegate = nil;
	
	parser = nil;
	
	[super dealloc];
}

@end
