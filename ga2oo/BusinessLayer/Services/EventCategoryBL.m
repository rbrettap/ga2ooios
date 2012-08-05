//
//  EventCategoryBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventCategoryBL.h"


@implementation EventCategoryBL
@synthesize delegate;

-(BOOL)Insert:(EventCategoryBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventCategoryDA *dataAccessLayer = [[EventCategoryDA alloc]init];
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

-(BOOL)Update:(EventCategoryBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventCategoryDA *dataAccessLayer = [[EventCategoryDA alloc]init];
    NSString *PrimarykeyColumnName = [EventCategory PrimarykeyColumnName];
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
    for(EventCategoryBO *object in arrData)
    {
//NSString *key = [object valueForKey:[EventCategory PrimarykeyColumnName]];
       // BaseBusinessObject *object_business = [self SelectByKey:key withMode:NO];
       
        [self Insert:object withSave:NO];
/*
        if(object_business != nil)
        {
            [self Update:object withSave:NO];
        }
        else
        {
            [self Insert:object withSave:NO];
        }*/
    }
    
    [self Save];
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    EventCategoryDA *dataAccessLayer = [[EventCategoryDA alloc]init];
    BaseCoreDataObject *EventCatCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventCategoryBO *EventCat = nil; 
    
    if(EventCatCDO != nil)
    {
        EventCat = [[EventCategoryBO alloc] init];
        [EventCat CopyData:EventCatCDO];
    }
    
    [dataAccessLayer release];
    return EventCat;
}

-(NSMutableArray*)SelectAll
{
    EventCategoryDA *dataAccessLayer = [[EventCategoryDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    EventCategoryDA *dataAccessLayer = [[EventCategoryDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}


-(void)LoadEventsCategory
{
    [self performSelectorOnMainThread:@selector(EventsCategoryXml) withObject:nil waitUntilDone:NO];
}

-(void)EventsCategoryXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    EventCategoryXML *parser = [EventCategoryXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)EventCategoryXML_Error:(EventCategoryXML *)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsCategoryLoadingCompleted)])
	{
		[(id)[self delegate] EventsCategoryLoadingCompleted];
	}
}

- (void)EventCategoryXML_Finished:(NSMutableArray *)arrSchedule
{
   [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsCategoryLoadingCompleted)])
	{
		[(id)[self delegate] EventsCategoryLoadingCompleted];
	}
}

-(void)EventsCategoryLoadingCompleted
{
    
}

@end
