//
//  CategoryBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "CategoryBL.h"


@implementation CategoryBL
@synthesize delegate;

-(BOOL)Insert:(CategoryBO*)BaseBusinessObj withSave:(BOOL)Save
{
    CategoryDA *dataAccessLayer = [[CategoryDA alloc]init];
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

-(BOOL)Update:(CategoryBO*)BaseBusinessObj withSave:(BOOL)Save
{
    CategoryDA *dataAccessLayer = [[CategoryDA alloc]init];
    NSString *PrimarykeyColumnName = [Category PrimarykeyColumnName];
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
    for(CategoryBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Category PrimarykeyColumnName]];
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
    CategoryDA *dataAccessLayer = [[CategoryDA alloc]init];
    BaseCoreDataObject *catCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    CategoryBO *Category = nil; 
    
    if(catCDO != nil)
    {
        Category = [[CategoryBO alloc] init];
        [Category CopyData:catCDO];
    }
    
    [dataAccessLayer release];
    return Category;
}

-(NSMutableArray*)SelectAll
{
    CategoryDA *dataAccessLayer = [[CategoryDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}


-(void)deleteAll
{
    CategoryDA *dataAccessLayer = [[CategoryDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadCategory
{
    [self performSelectorOnMainThread:@selector(CategoryXml) withObject:nil waitUntilDone:NO];
}

-(void)CategoryXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    CategoryXML *parser = [CategoryXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)CategoryXML_Error:(CategoryXML *)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(CategoryLoadingCompleted)])
	{
		[(id)[self delegate] CategoryLoadingCompleted];
	}
}

- (void)CategoryXML_Finished:(NSMutableArray*)arrSchedule
{
	
	

	
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(CategoryLoadingCompleted)])
	{
		[(id)[self delegate] CategoryLoadingCompleted];
	}
}

-(void)CategoryLoadingCompleted
{
    
}

@end
