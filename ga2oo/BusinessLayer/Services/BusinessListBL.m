//
//  BusinessListBL.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "BusinessListBL.h"


@implementation BusinessListBL
@synthesize delegate;

-(BOOL)Insert:(BusinessListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
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

-(BOOL)Update:(BusinessListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
    NSString *PrimarykeyColumnName = [BusinessList PrimarykeyColumnName];
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
    for(BusinessListBO *object in arrData)
    {
        NSString *key = [object valueForKey:[BusinessList PrimarykeyColumnName]];
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
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
    BaseCoreDataObject *BusinessListCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    BusinessListBO *Usr = nil; 
    if(BusinessListCDO != nil)
    {
        Usr = [[BusinessListBO alloc] init];
        [Usr CopyData:BusinessListCDO];
    }
    
    [dataAccessLayer release];
    return Usr;
}

-(NSMutableArray*)SelectAll
{
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(BusinessList *BusinessListCDO in arrData)
    {
        if(BusinessListCDO != nil)
        {
            BusinessListBO *BusinessList1 = [[BusinessListBO alloc] init];
            [BusinessList1 CopyData:BusinessListCDO];
            [ArrCopyObjects addObject:BusinessList1];
            [BusinessList1 release];
            BusinessList1=nil;
        }
    }
	
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)FilerDataUsing:(NSString*)strPredicate
{
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
    NSMutableArray *arr_filtered = [dataAccessLayer FilterArrayUsingSort:strPredicate];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(BusinessList *BusinessListCDO in arr_filtered)
    {
        if(BusinessListCDO != nil)
        {
			BusinessListBO *BusinessList1 = [[BusinessListBO alloc] init];
            [BusinessList1 CopyData:BusinessListCDO];
            [ArrCopyObjects addObject:BusinessList1];
            [BusinessList1 release];
            BusinessList1=nil;
			
        }
    }
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(void)deleteAll
{
    BusinessListDA *dataAccessLayer = [[BusinessListDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadBusinessList
{
    [self performSelectorOnMainThread:@selector(NewBusinessListXml) withObject:nil waitUntilDone:NO];
}

-(void)NewBusinessListXml
{
	CompletedParser = NO;
	parser =nil;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [BusinessListXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)BusinessListXML_Error:(BusinessListXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessListLoadingCompleted)])
	{
		[(id)[self delegate] BusinessListLoadingCompleted];
	}
}

- (void)BusinessListXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(BusinessListLoadingCompleted)])
	{
		[(id)[self delegate] BusinessListLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)BusinessListLoadingCompleted
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
