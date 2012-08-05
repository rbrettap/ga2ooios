//
//  EventVideosBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventVideosBL.h"


@implementation EventVideosBL
@synthesize delegate;

-(BOOL)Insert:(EventVideosBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventVideosDA *dataAccessLayer = [[EventVideosDA alloc]init];
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

-(BOOL)Update:(EventVideosBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventVideosDA *dataAccessLayer = [[EventVideosDA alloc]init];
    NSString *PrimarykeyColumnName = [EventVideos PrimarykeyColumnName];
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
    for(EventVideosBO *object in arrData)
    {
        NSString *key = [object valueForKey:[EventVideos PrimarykeyColumnName]];
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
    EventVideosDA *dataAccessLayer = [[EventVideosDA alloc]init];
    BaseCoreDataObject *EventVidCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventVideosBO *EventVid = nil; 
    
    if(EventVidCDO != nil)
    {
        EventVid = [[EventVideosBO alloc] init];
        [EventVid CopyData:EventVidCDO];
    }
    
    [dataAccessLayer release];
    return EventVid;
}

-(NSMutableArray*)SelectAll
{
    EventVideosDA *dataAccessLayer = [[EventVideosDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
    return arrData;
}

-(void)deleteAll
{
    EventVideosDA *dataAccessLayer = [[EventVideosDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadEventVideos
{
    [self performSelectorOnMainThread:@selector(NewEventVideosXml) withObject:nil waitUntilDone:NO];
}

-(void)NewEventVideosXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    EventVideosXML *parser = [EventVideosXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)EventVideosXML_Error:(EventVideosXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventVideosLoadingCompleted)])
	{
		[(id)[self delegate] EventVideosLoadingCompleted];
	}
}

- (void)EventVideosXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventVideosLoadingCompleted)])
	{
		[(id)[self delegate] EventVideosLoadingCompleted];
	}
}

-(void)EventVideosLoadingCompleted
{
    
}

@end
