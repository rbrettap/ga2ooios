//
//  EventRecommendateBL.m
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventRecommendateBL.h"


@implementation EventRecommendateBL
@synthesize delegate;


-(BOOL)Insert:(EventRecommendateBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventRecommendateDA *dataAccessLayer = [[EventRecommendateDA alloc]init];
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

-(BOOL)Update:(EventRecommendateBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventRecommendateDA *dataAccessLayer = [[EventRecommendateDA alloc]init];
    NSString *PrimarykeyColumnName = [EventRecommendate PrimarykeyColumnName];
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
    for(EventRecommendateBO *object in arrData)
    {
        NSString *key = [object valueForKey:[EventRecommendate PrimarykeyColumnName]];
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
    EventRecommendateDA *dataAccessLayer = [[EventRecommendateDA alloc]init];
    BaseCoreDataObject *NotificCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventNotificationsBO *Notific = nil; 
    
    if(NotificCDO != nil)
    {
        Notific = [[EventNotificationsBO alloc] init];
        [Notific CopyData:NotificCDO];
    }
    
    [dataAccessLayer release];
    return Notific;
}

-(NSMutableArray*)SelectAll
{
    EventRecommendateDA *dataAccessLayer = [[EventRecommendateDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventRecommendate *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            EventRecommendateBO *User1 = [[EventRecommendateBO alloc] init];
            [User1 CopyData:UserCDO];
            [ArrCopyObjects addObject:User1];
            [User1 release];
            User1=nil;
        }
    }
	
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
	
}

-(void)deleteAll
{
    EventRecommendateDA *dataAccessLayer = [[EventRecommendateDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadEventRecommendate
{
    [self performSelectorOnMainThread:@selector(NewRecommendateXml) withObject:nil waitUntilDone:NO];
}

-(void)NewRecommendateXml
{
	CompletedParser = NO;
	parser = nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	parser = [EventRecommendateXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

- (void)EventRecommendateXML_Error:(EventRecommendateXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(RecommendationLoadingCompleted)])
	{
		[(id)[self delegate] RecommendationLoadingCompleted];
	}
}

- (void)EventRecommendateXML_Finished:(NSMutableArray*)arrSchedule
{
    [self InsertArray:arrSchedule];
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(RecommendationLoadingCompleted)])
	{
		[(id)[self delegate] RecommendationLoadingCompleted];
	}
	CompletedParser =YES;
}

-(void)RecommendationLoadingCompleted
{
}

-(void)dealloc
{
	if(!CompletedParser)
		parser.delegate = nil;
	
	parser = nil;
	
	[super dealloc];
}



@end
