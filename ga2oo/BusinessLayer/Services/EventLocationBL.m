//
//  EventLocationBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventLocationBL.h"


@implementation EventLocationBL
@synthesize delegate;

-(BOOL)Insert:(EventLocationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventLocationDA *dataAccessLayer = [[EventLocationDA alloc]init];
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

-(BOOL)Update:(EventLocationBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventLocationDA *dataAccessLayer = [[EventLocationDA alloc]init];
    NSString *PrimarykeyColumnName = [EventLocation PrimarykeyColumnName];
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
    for(EventLocationBO *object in arrData)
    {
        NSString *key = [object valueForKey:[EventLocation PrimarykeyColumnName]];
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
    EventLocationDA *dataAccessLayer = [[EventLocationDA alloc]init];
    BaseCoreDataObject *EventLocCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventLocationBO *EventLoc = nil; 
    
    if(EventLocCDO != nil)
    {
        EventLoc = [[EventLocationBO alloc] init];
        [EventLoc CopyData:EventLocCDO];
    }
    
    [dataAccessLayer release];
    return EventLoc;
}

-(NSMutableArray*)SelectAll
{
    EventLocationDA *dataAccessLayer = [[EventLocationDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventLocation *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            EventLocationBO *Events2 = [[EventLocationBO alloc] init];
            [Events2 CopyData:EventsCDO];
            [ArrCopyObjects addObject:Events2];
            [Events2 release];
            Events2=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(void)deleteAll
{
    EventLocationDA *dataAccessLayer = [[EventLocationDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadEventsLocation:(NSString *)eventId
{
    [self performSelectorOnMainThread:@selector(NewEventsLocationXml:) withObject:eventId waitUntilDone:NO];
}

-(void)NewEventsLocationXml:(NSString *)eventId
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [EventLocationXML saxParser];
	parser.intEventID = eventId;
    parser.delegate = self;
    [parser getData];
	
	UIActivityIndicatorView *loaders = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	loaders.frame = CGRectMake(125, 55, 37, 37);
	locationAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Downloading..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	[locationAlert addSubview:loaders];
	[loaders startAnimating];
	//[locationAlert show];
    [loaders release];
	
    [pool release];
}

-(void)hidealert
{
	[locationAlert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)EventLocationXML_Error:(EventLocationXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsLocationLoadingCompleted)])
	{
		[(id)[self delegate] EventsLocationLoadingCompleted];
	}
}

- (void)EventLocationXML_Finished:(NSMutableArray*)arrSchedule;
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsLocationLoadingCompleted)])
	{
		[(id)[self delegate] EventsLocationLoadingCompleted];
	}
	[self hidealert];
	CompletedParser =YES;
}

-(void)EventsLocationLoadingCompleted
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
