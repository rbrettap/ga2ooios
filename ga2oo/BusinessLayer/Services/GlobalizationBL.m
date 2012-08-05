//
//  GlobalizationBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "GlobalizationBL.h"
#import "GlobalizationXML.h"

@implementation GlobalizationBL
@synthesize delegate;

-(BOOL)Insert:(GlobalizationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    GlobalizationDA *dataAccessLayer = [[GlobalizationDA alloc]init];
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

-(BOOL)Update:(GlobalizationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    GlobalizationDA *dataAccessLayer = [[GlobalizationDA alloc]init];
    NSString *PrimarykeyColumnName = [Globalization PrimarykeyColumnName];
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
    for(GlobalizationBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Globalization PrimarykeyColumnName]];
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
    GlobalizationDA *dataAccessLayer = [[GlobalizationDA alloc]init];
    BaseCoreDataObject *GlobCDO = [dataAccessLayer SelectByKey:Key withMode:NO];
    
    GlobalizationBO *Glob = nil; 
    
    if(GlobCDO != nil)
    {
        Glob = [[GlobalizationBO alloc] init];
        [Glob CopyData:GlobCDO];
    }
    
    [dataAccessLayer release];
    return Glob;
}

-(NSMutableArray*)SelectAll
{
    GlobalizationDA *dataAccessLayer = [[GlobalizationDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}


-(void)deleteAll
{
    GlobalizationDA *dataAccessLayer = [[GlobalizationDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadGlobalization
{
    [self performSelectorOnMainThread:@selector(GlobalizationXml) withObject:nil waitUntilDone:NO];
}

-(void)GlobalizationXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    GlobalizationXML *parser = [GlobalizationXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)GlobalizationXML_Error:(GlobalizationXML *)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(GlobalizationLoadingCompleted)])
	{
		[(id)[self delegate] GlobalizationLoadingCompleted];
	}
}

- (void)GlobalizationXML_Finished:(NSMutableArray*)arrSchedule;
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(GlobalizationLoadingCompleted)])
	{
		[(id)[self delegate] GlobalizationLoadingCompleted];
	}
}

-(void)GlobalizationLoadingCompleted
{
    
}


@end
