//
//  EventImagesBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventImagesBL.h"


@implementation EventImagesBL
@synthesize delegate;

-(BOOL)Insert:(EventImagesBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventImagesDA *dataAccessLayer = [[EventImagesDA alloc]init];
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

-(BOOL)Update:(EventImagesBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventImagesDA *dataAccessLayer = [[EventImagesDA alloc]init];
    NSString *PrimarykeyColumnName = [EventImages PrimarykeyColumnName];
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
    for(EventImagesBO *object in arrData)
    {
        //NSString *key = [object valueForKey:[EventImages PrimarykeyColumnName]];
       // BaseBusinessObject *object_business = [self SelectByKey:key withMode:NO];
       
        [self Insert:object withSave:NO];

//        if(object_business != nil)
//        {
//            [self Update:object withSave:NO];
//        }
//        else
//        {
//            [self Insert:object withSave:NO];
//        }
    }
    
   // [self Save];
}

-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString
{
    EventImagesDA *dataAccessLayer = [[EventImagesDA alloc]init];
    BaseCoreDataObject *EventImgCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventImagesBO *EventImg = nil; 
    
    if(EventImgCDO != nil)
    {
        EventImg = [[EventImagesBO alloc] init];
        [EventImg CopyData:EventImgCDO];
    }
    
    [dataAccessLayer release];
    return EventImg;
}

-(NSMutableArray*)SelectAll
{
    
    EventImagesDA *dataAccessLayer = [[EventImagesDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventImages *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            EventImagesBO *Events1 = [[EventImagesBO alloc] init];
            [Events1 CopyData:EventsCDO];
            [ArrCopyObjects addObject:Events1];
            [Events1 release];
            Events1=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
 
}

-(void)deleteAll
{
    EventImagesDA *dataAccessLayer = [[EventImagesDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}
 

@end
