//
//  BusinessBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessBL.h"


@implementation BusinessBL
@synthesize delegate;

-(BOOL)Insert:(BusinessBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessDA *dataAccessLayer = [[BusinessDA alloc]init];
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

-(BOOL)Update:(BusinessBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessDA *dataAccessLayer = [[BusinessDA alloc]init];
    NSString *PrimarykeyColumnName = [Business PrimarykeyColumnName];
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
    for(BusinessBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Business PrimarykeyColumnName]];
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
    BusinessDA *dataAccessLayer = [[BusinessDA alloc]init];
    BaseCoreDataObject *BusinessCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    BusinessBO *Busines = nil; 
    
    if(BusinessCDO != nil)
    {
        Busines = [[BusinessBO alloc] init];
        [Busines CopyData:BusinessCDO];
    }
    
    [dataAccessLayer release];
    return Busines;
}

-(NSMutableArray*)SelectAll
{
    BusinessDA *dataAccessLayer = [[BusinessDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    BusinessDA *dataAccessLayer = [[BusinessDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadBusiness
{
    [self performSelectorOnMainThread:@selector(BusinessXml) withObject:nil waitUntilDone:NO];
}

-(void)BusinessXml
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [BusinessXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)BusinessXML_Error:(BusinessXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessLoadingCompleted)])
	{
		[(id)[self delegate] BusinessLoadingCompleted];
	}
}

- (void)BusinessXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessLoadingCompleted)])
	{
		[(id)[self delegate] BusinessLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)BusinessLoadingCompleted
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
