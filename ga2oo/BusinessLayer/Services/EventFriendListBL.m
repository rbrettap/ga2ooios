//
//  EventFriendListBL.m
//  Ga2oo
//
//  Created by Mayank goyal on 12/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventFriendListBL.h"


@implementation EventFriendListBL
@synthesize delegate;

-(BOOL)Insert:(EventFriendListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventFriendListDA *dataAccessLayer = [[EventFriendListDA alloc]init];
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

-(BOOL)Update:(EventFriendListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventFriendListDA *dataAccessLayer = [[EventFriendListDA alloc]init];
    NSString *PrimarykeyColumnName = [EventFriendList PrimarykeyColumnName];
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
    for(EventFriendListBO *object in arrData)
    {
		NSString *key = nil;
		if([[object valueForKey:[EventFriendList PrimarykeyColumnName]] isKindOfClass:[NSString class]])
		{
			key = [object valueForKey:[EventFriendList PrimarykeyColumnName]];
		}
		else if([[object valueForKey:[EventFriendList PrimarykeyColumnName]] isKindOfClass:[NSNumber class]])
		{
		 	key = [NSString stringWithFormat:@"%i",[[object valueForKey:[EventFriendList PrimarykeyColumnName]] integerValue]];
		}
        
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
    EventFriendListDA *dataAccessLayer = [[EventFriendListDA alloc]init];
    BaseCoreDataObject *UserCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventFriendListBO *Usr = nil; 
    if(UserCDO != nil)
    {
        Usr = [[EventFriendListBO alloc] init];
        [Usr CopyData:UserCDO];
    }
    
    [dataAccessLayer release];
    return Usr;
}

-(NSMutableArray*)SelectAll
{
    EventFriendListDA *dataAccessLayer = [[EventFriendListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventFriendList *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            EventFriendListBO *User1 = [[EventFriendListBO alloc] init];
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
    EventFriendListDA *dataAccessLayer = [[EventFriendListDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUser:(NSString *)userId
{
    [self performSelectorOnMainThread:@selector(NewUserXml:) withObject:userId waitUntilDone:NO];
}

-(void)NewUserXml:(NSString *)userId
{
	CompletedParser = NO;
	parser =nil;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	//[userId retain];
    parser = [EventFriendListXML saxParser];
	parser.strUser = userId;
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)EventFriendListXML_Error:(EventFriendListXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(LoadEventFriendLoadingCompleted)])
	{
		[(id)[self delegate] LoadEventFriendLoadingCompleted];
	}
}

- (void)EventFriendListXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(LoadEventFriendLoadingCompleted)])
	{
		[(id)[self delegate] LoadEventFriendLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)LoadEventFriendLoadingCompleted
{
    
}

-(void)dealloc
{
	if(!CompletedParser)
	{
		parser.delegate =nil;
	}
	parser =nil;
	
	[super dealloc];
}


@end
