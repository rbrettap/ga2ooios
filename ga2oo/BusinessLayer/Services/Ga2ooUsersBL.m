//
//  Ga2ooUsersBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Ga2ooUsersBL.h"
#import "Ga2ooUsersDA.h"
#import "Ga2ooUsersXML.h"


@implementation Ga2ooUsersBL
@synthesize delegate;

-(BOOL)Insert:(Ga2ooUserBO*)BaseBusinessObj withSave:(BOOL)Save
{
    Ga2ooUsersDA *dataAccessLayer = [[Ga2ooUsersDA alloc]init];
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

-(BOOL)Update:(Ga2ooUserBO*)BaseBusinessObj withSave:(BOOL)Save
{
    Ga2ooUsersDA *dataAccessLayer = [[Ga2ooUsersDA alloc]init];
    NSString *PrimarykeyColumnName = [Ga2ooUser PrimarykeyColumnName];
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
    for(Ga2ooUserBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Ga2ooUser PrimarykeyColumnName]];
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
    Ga2ooUsersDA *dataAccessLayer = [[Ga2ooUsersDA alloc]init];
    BaseCoreDataObject *FrindCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    Ga2ooUserBO *Frind = nil; 
    
    if(FrindCDO != nil)
    {
        Frind = [[Ga2ooUserBO alloc] init];
        [Frind CopyData:FrindCDO];
    }
    
    [dataAccessLayer release];
    return Frind;
}

-(NSMutableArray*)SelectAll
{
	
	Ga2ooUsersDA *dataAccessLayer = [[Ga2ooUsersDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(Ga2ooUser *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            Ga2ooUserBO *User1 = [[Ga2ooUserBO alloc] init];
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
    Ga2ooUsersDA *dataAccessLayer = [[Ga2ooUsersDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadGa2ooUser
{
    [self performSelectorOnMainThread:@selector(getGa2ooUsersXML) withObject:nil waitUntilDone:NO];
}

-(void)getGa2ooUsersXML
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    Ga2ooUsersXML *parser = [Ga2ooUsersXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)Ga2ooUsersXML_Error:(Ga2ooUsersXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(Ga2ooUsersLoadingCompleted:)])
	{
		[(id)[self delegate] Ga2ooUsersLoadingCompleted:nil];
	}
}

- (void)Ga2ooUsersXML_Finished:(NSMutableArray*)arrSchedule;
{
	
	[self InsertArray:arrSchedule];
	
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(Ga2ooUsersLoadingCompleted:)])
	{
		[(id)[self delegate] Ga2ooUsersLoadingCompleted:arrSchedule];
	}
}

-(void)Ga2ooUsersLoadingCompleted:(NSMutableArray *)arrGa2ooUser
{
    
}

@end
