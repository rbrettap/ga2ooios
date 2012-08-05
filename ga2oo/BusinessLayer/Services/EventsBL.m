//
//  EventsBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventsBL.h"
#import "EventImagesBL.h"

@implementation EventsBL
@synthesize delegate;

-(BOOL)Insert:(EventsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer NewRecord];
    BOOL saved = TRUE;
    
    if ([BaseBusinessObj.arrEventImages count]) {
        EventImagesBL *imageBl = [[EventImagesBL alloc]init];
        [imageBl InsertArray:BaseBusinessObj.arrEventImages];
        [imageBl release];
     }
        
    [baseBusinessObject CopyData:BaseBusinessObj];
    
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(BOOL)Update:(EventsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    NSString *PrimarykeyColumnName = [Events PrimarykeyColumnName];
    NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
	
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:primarykey withMode:NO];
    BOOL saved = TRUE;
    
    if ([BaseBusinessObj.arrEventImages count]) {
        EventImagesBL *imageBl = [[EventImagesBL alloc]init];
        [imageBl InsertArray:BaseBusinessObj.arrEventImages];
        [imageBl release];
    }
    
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
	NSLog(@"%i", [arrData count]);
    for(EventsBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Events PrimarykeyColumnName]];
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
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    BaseCoreDataObject *EventsCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventsBO *Events1 = nil; 
    
    if(EventsCDO != nil)
    {
        Events1 = [[EventsBO alloc] init];
        [Events1 CopyData:EventsCDO];
    }
    
    [dataAccessLayer release];
    return Events1;
}

-(NSMutableArray*)SelectAll
{
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(Events *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            EventsBO *Events1 = [[EventsBO alloc] init];
            [Events1 CopyData:EventsCDO];
            [ArrCopyObjects addObject:Events1];
            [Events1 release];
            Events1=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)FilerDataUsing:(NSString*)strPredicate
{
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    NSMutableArray *arr_filtered = [dataAccessLayer FilterArrayUsingSort:strPredicate];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(Events *EventsCDO in arr_filtered)
    {
        if(EventsCDO != nil)
        {
            EventsBO *Events = [[EventsBO alloc] init];
            [Events CopyData:EventsCDO];
            [ArrCopyObjects addObject:Events];
            [Events release];
            Events=nil;
        }
    }
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}


-(void)deleteAll
{
    EventsDA *dataAccessLayer = [[EventsDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadEvents:(NSString *)eventId
{
    [self performSelectorOnMainThread:@selector(NewEventsXml:) withObject:eventId waitUntilDone:NO];
}

-(void)NewEventsXml:(NSString *)eventId
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [EventsXML saxParser];
	parser.EventID = eventId;
    parser.delegate = self;
    [parser getData];

     [pool release];
}

 

- (void)EventsXML_Error:(EventsXML *)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsLoadingCompleted)])
	{
		[(id)[self delegate] EventsLoadingCompleted];
	}
}

- (void)EventsXML_Finished:(NSMutableArray *)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsLoadingCompleted)])
	{
		[(id)[self delegate] EventsLoadingCompleted];
	}
 	CompletedParser =YES;

}

-(void)EventsLoadingCompleted
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
