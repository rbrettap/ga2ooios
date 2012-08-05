//
//  UserBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "UserBL.h"
#import "UserAssociationBL.h"

@implementation UserBL
@synthesize delegate;

-(BOOL)Insert:(UserBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer NewRecord];
    BOOL saved = TRUE;
  	
    [baseBusinessObject CopyData:BaseBusinessObj];
	[self SaveUserLocations:BaseBusinessObj];
	[self SaveUserAssociations:BaseBusinessObj];

	
    Save = YES;
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(BOOL)Update:(UserBO*)BaseBusinessObj withSave:(BOOL)Save
{
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    NSString *PrimarykeyColumnName = [User PrimarykeyColumnName];
    NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:primarykey withMode:YES];
    BOOL saved = TRUE;
    
    [baseBusinessObject CopyData:BaseBusinessObj];
    [self SaveUserLocations:BaseBusinessObj];
	[self SaveUserAssociations:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(void)InsertArray:(NSMutableArray *)arrData
{
    for(UserBO *object in arrData)
    {
        NSString *key =[object valueForKey:[User PrimarykeyColumnName]];
		
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

-(void)Update:(UserBO *)object
{
    NSString *key = [object valueForKey:[User PrimarykeyColumnName]];
    BaseBusinessObject *object_business = [self SelectByKey:key withMode:YES];
    if(object_business != nil)
    {
        [self Update:object withSave:YES];
    }
    else
    {
        [self Insert:object withSave:YES];
    }
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    BaseCoreDataObject *UserCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    UserBO *Usr = nil; 
    if(UserCDO != nil)
    {
        Usr = [[UserBO alloc] init] ;
        [Usr CopyData:UserCDO];
    }
    
    [dataAccessLayer release];
  
        return Usr;

    
}

-(NSMutableArray*)SelectAll
{
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(User *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            UserBO *User1 = [[UserBO alloc] init];
            [User1 CopyData:UserCDO];
            [ArrCopyObjects addObject:User1];
            [User1 release];
            User1=nil;
        }
    }
	
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)FilerDataUsing:(NSString*)strPredicate
{
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    NSMutableArray *arr_filtered = [dataAccessLayer FilterArrayUsingSort:strPredicate];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(User *UserCDO in arr_filtered)
    {
        if(UserCDO != nil)
        {
			UserBO *User1 = [[UserBO alloc] init];
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
    UserDA *dataAccessLayer = [[UserDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}


-(void)SaveUserLocations:(UserBO*)BaseBusinessObj{

	UserLocationBL *locaionBl = [[UserLocationBL alloc]init];
	locaionBl.delegate = self;
	[locaionBl InsertArray:BaseBusinessObj.arrUserLocations];
	[locaionBl release];

}


-(void)SaveUserAssociations:(UserBO*)BaseBusinessObj{
	
	UserAssociationBL *AssBl = [[UserAssociationBL alloc]init];
	AssBl.delegate = self;
	[AssBl InsertArray:BaseBusinessObj.arrUserAssociations];
	[AssBl release];
	
}


-(void)LoadUser:(NSString *)userId
{
    [self performSelectorOnMainThread:@selector(NewUserXml:) withObject:userId waitUntilDone:NO];
}

-(void)NewUserXml:(NSString  *)userId
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	//[userId retain];
    UserXML *parser = [UserXML saxParser];
	parser.userId = [userId integerValue];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)UserXML_Error:(UserXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserLoadingCompleted)])
	{
		[(id)[self delegate] UserLoadingCompleted];
	}
}

- (void)UserXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(UserLoadingCompleted)])
	{
		[(id)[self delegate] UserLoadingCompleted];
	}
}


-(void)UserLoadingCompleted
{
    
}


@end
