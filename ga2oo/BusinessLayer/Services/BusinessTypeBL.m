//
//  BusinessTypeBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessTypeBL.h"


@implementation BusinessTypeBL
@synthesize delegate;

-(BOOL)Insert:(BusinessTypeBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessTypeDA *dataAccessLayer = [[BusinessTypeDA alloc]init];
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

-(BOOL)Update:(BusinessTypeBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessTypeDA *dataAccessLayer = [[BusinessTypeDA alloc]init];
    NSString *PrimarykeyColumnName = [BusinessType PrimarykeyColumnName];
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
    for(BusinessTypeBO *object in arrData)
    {
        NSString *key = [object valueForKey:[BusinessType PrimarykeyColumnName]];
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
    BusinessTypeDA *dataAccessLayer = [[BusinessTypeDA alloc]init];
    BaseCoreDataObject *BusTypeCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    BusinessTypeBO *BusType = nil; 
    
    if(BusTypeCDO != nil)
    {
        BusType = [[BusinessTypeBO alloc] init];
        [BusType CopyData:BusTypeCDO];
    }
    
    [dataAccessLayer release];
    return BusType;
}

-(NSMutableArray*)SelectAll
{
    BusinessTypeDA *dataAccessLayer = [[BusinessTypeDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}


-(void)deleteAll
{
    BusinessTypeDA *dataAccessLayer = [[BusinessTypeDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}


-(void)LoadBusinessType
{
    [self performSelectorOnMainThread:@selector(BusinessTypeXml) withObject:nil waitUntilDone:NO];
}

-(void)BusinessTypeXml
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [BusinessTypeXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)BusinessTypeXML_Error:(BusinessTypeXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessTypeLoadingCompleted)])
	{
		[(id)[self delegate] BusinessTypeLoadingCompleted];
	}
}

- (void)BusinessTypeXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessTypeLoadingCompleted)])
	{
		[(id)[self delegate] BusinessTypeLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)BusinessTypeLoadingCompleted
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
