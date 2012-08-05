//
//  UserAssociationBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserAssociationBL.h"


@implementation UserAssociationBL
@synthesize delegate;

-(BOOL)Insert:(UserAssociationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserAssociationDA *dataAccessLayer = [[UserAssociationDA alloc]init];
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

-(BOOL)Update:(UserAssociationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserAssociationDA *dataAccessLayer = [[UserAssociationDA alloc]init];
    NSString *PrimarykeyColumnName = [UserAssociation PrimarykeyColumnName];
    NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:primarykey withMode:YES];
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
    for(UserAssociationBO *object in arrData)
    {
        NSString *key = [object valueForKey:[UserAssociation PrimarykeyColumnName]];
        BaseBusinessObject *object_business = [self SelectByKey:key withMode:YES];
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
    UserAssociationDA *dataAccessLayer = [[UserAssociationDA alloc]init];
    BaseCoreDataObject *UserAssCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserAssociationBO *UserAss = nil; 
    
    if(UserAssCDO != nil)
    {
        UserAss = [[UserAssociationBO alloc] init];
        [UserAss CopyData:UserAssCDO];
    }
    
    [dataAccessLayer release];
    
        return UserAss;
     
    
}

-(NSMutableArray*)SelectAll
{
    UserAssociationDA *dataAccessLayer = [[UserAssociationDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    UserAssociationDA *dataAccessLayer = [[UserAssociationDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadUserAssociation:(NSInteger)userId
{
    [self performSelectorOnMainThread:@selector(NewUserAssociationXml:) withObject:[NSNumber numberWithInteger:userId] waitUntilDone:NO];
}

-(void)NewUserAssociationXml:(NSNumber *)userId
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [UserAssociationXML saxParser];
	parser.userId = [userId integerValue];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)UserAssociationXML_Error:(UserAssociationXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserAssociationLoadingCompleted)])
	{
		[(id)[self delegate] UserAssociationLoadingCompleted];
	}
}

- (void)UserAssociationXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserAssociationLoadingCompleted)])
	{
		[(id)[self delegate] UserAssociationLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)UserAssociationLoadingCompleted
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
