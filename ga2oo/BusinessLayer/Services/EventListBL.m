//
//  EventListBL.m
//  Ga2oo
//
//  Created by Mayank goyal on 25/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventListBL.h"
#import "EventCategoryBL.h"
#import "EventListBO.h"
#import "Ga2ooAppDelegate.h"

@implementation EventListBL
@synthesize delegate;
@synthesize str_date;
@synthesize str_category;
@synthesize str_type;
@synthesize ModeType;


-(BOOL)Insert:(EventListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer NewRecord];
    BOOL saved = TRUE;
    
     EventCategoryBL *eventcatBl = [[EventCategoryBL alloc]init];
     [eventcatBl InsertArray:BaseBusinessObj.arrCategories];
     [eventcatBl release];// uncomment for cats

    [baseBusinessObject CopyData:BaseBusinessObj];     
    if(Save)
    {
        saved = [dataAccessLayer Save];
    }
    [dataAccessLayer release];
    
    return saved;
}

-(BOOL)Update:(EventListBO*)BaseBusinessObj withSave:(BOOL)Save
{
    if (BaseBusinessObj  != nil) {
        EventListDA *dataAccessLayer = [[EventListDA alloc]init];
        NSString *PrimarykeyColumnName = [EventList PrimarykeyColumnName];
        NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
        if (primarykey!=nil) {
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
        else 
        {
         [dataAccessLayer release];
        }
       
    }
   }
 
-(void)InsertArray:(NSMutableArray *)arrData
{
	NSLog(@"%i", [arrData count]);
    for(EventListBO *object in arrData)
    {
        NSString *key = [object valueForKey:[EventList PrimarykeyColumnName]];
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
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    BaseCoreDataObject *EventsCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    EventListBO *EventsList = nil; 
    
    if(EventsCDO != nil)
    {
        EventsList = [[EventListBO alloc] init];
        [EventsList CopyData:EventsCDO];
    }
    
    [dataAccessLayer release];
    return EventsList;
}

-(NSMutableArray*)SelectAll
{
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventList *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            EventListBO *Eventsllist = [[EventListBO alloc] init];
            [Eventsllist CopyData:EventsCDO];
            [ArrCopyObjects addObject:Eventsllist];
            [Eventsllist release];
            Eventsllist=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}
-(NSMutableArray*)SelectAllEventsAddingNoOfFriends
{
    
    Ga2ooAppDelegate *appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventList *EventsCDO in arrData)
    {
        EventListBO *Eventsllist = [[EventListBO alloc] init];
        if(EventsCDO != nil)
        {
            [Eventsllist CopyData:EventsCDO];
        }
        if (Eventsllist) {
            Eventsllist.noOfFriends = 0;
			NSString *strUsers = Eventsllist.UserID;
			NSArray *arr = [strUsers componentsSeparatedByString:@","];					
			for (int i=0; i<[arr count]; i++) {
				NSString *fUser = [arr objectAtIndex:i];
				if ([fUser length] && ![fUser isEqualToString:appDelegate.currentUserID]) {
					 
                    
                    FriendsBL *friendbl = [[FriendsBL alloc]init];
					FriendsBO *oneFriend = (FriendsBO *)[friendbl SelectByKey:fUser withMode:YES];
					
					if (oneFriend!=nil) {
                        Eventsllist.noOfFriends  = Eventsllist.noOfFriends+1;
                        
 					}
                
                    oneFriend=nil;
					[friendbl release];
 				}
                
			}
			
			
			strUsers=nil;
			
            [ArrCopyObjects addObject:Eventsllist];
                         [Eventsllist release];
                        Eventsllist=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

/*
-(NSMutableArray*)SelectAllEventsAddingFriends
{
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventList *EventsCDO in arrData)
    {
        EventListBO *Eventsllist = [[EventListBO alloc] init];
        if(EventsCDO != nil)
        {
            [Eventsllist CopyData:EventsCDO];
        }
        if (Eventsllist) {
    
			NSString *strUsers = Eventsllist.UserID;
			NSArray *arr = [strUsers componentsSeparatedByString:@","];					
			for (int i=0; i<[arrUsers count]; i++) {
				NSString *fUser = [arrUsers objectAtIndex:i];
				if ([fUser length]) {
					FriendsBL *friendbl = [[FriendsBL alloc]init];
					FriendsBO *oneFriend = (FriendsBO *)[friendbl SelectByKey:fUser withMode:YES];
					
					if (oneFriend!=nil) {
						[Eventsllist.arrFriendsAttending addObject:oneFriend];
					}
                    [oneFriend release];
                    oneFriend=nil;
					[friendbl release];
 				}
								
			}
			
			
			strUsers=nil;
			
            [ArrCopyObjects addObject:Eventsllist];
//            [Eventsllist release];
//            Eventsllist=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

*/
-(NSMutableArray*)SelectAllEventsAccordingToFriend:(NSString *)friendId
{
    Ga2ooAppDelegate *appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
    
   /* NSMutableArray *FeaturedEvents = [[NSMutableArray alloc] init];
    
    for(int i = 0; i<[arrData count]; i++)
	{
		EventListBO *objEvent = [arrData objectAtIndex:i];
        BOOL isEvtDtFeatured = [appDelegate featuredDateIs:objEvent.event_start_date];
		if(isEvtDtFeatured)
		{
			[FeaturedEvents addObject:objEvent];
        }
	}
    [arrData removeAllObjects];
    [arrData addObjectsFromArray:FeaturedEvents];
    [FeaturedEvents release];*/
    
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(EventList *EventsCDO in arrData)
    {
        if(EventsCDO != nil)
        {
            EventListBO *Eventsllist = [[EventListBO alloc] init];
            [Eventsllist CopyData:EventsCDO];
			
			NSString *strUsers = Eventsllist.UserID;
            NSArray *arrUsers = [strUsers componentsSeparatedByString:@","];	
            
            int index = -1;
            
            index = [arrUsers indexOfObject:friendId];
            
            if (index < [arrUsers count]) {
                for (int i=0; i<[arrUsers count]; i++) {
                    NSString *fUser = [arrUsers objectAtIndex:i];
                    if ([fUser length] && ![fUser isEqualToString:appDelegate.currentUserID]) {
                        
                        
                        FriendsBL *friendbl = [[FriendsBL alloc]init];
                        FriendsBO *oneFriend = (FriendsBO *)[friendbl SelectByKey:fUser withMode:YES];
                        
                        if (oneFriend!=nil) {
                            Eventsllist.noOfFriends  = Eventsllist.noOfFriends+1;
                            
                        }
                    
                        oneFriend=nil;
                        [friendbl release];
                    }
                    
                }
                
                [ArrCopyObjects addObject:Eventsllist];
                
            }
            
            
            [Eventsllist release];
            Eventsllist=nil;
        }
    }
    
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
}

-(void)deleteAll
{
    EventListDA *dataAccessLayer = [[EventListDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
}

-(void)LoadEventList
{
    [self performSelectorOnMainThread:@selector(NewEventsListXml) withObject:nil waitUntilDone:NO];
}

-(void)NewEventsListXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    EventListXML *parser = [EventListXML saxParser];
    parser.delegate = self;
    parser.ModeType = ModeType;
    parser.str_category = str_category;
    parser.Str_date = str_date;
    parser.str_type = str_type;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)EventListXML_Error:(EventListXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsListLoadingCompleted:)])
	{
		[(id)[self delegate] EventsListLoadingCompleted:[NSMutableArray array]];
	}
}

- (void)EventListXML_Finished:(NSMutableArray*)arrSchedule
{
	NSLog(@"%i", [arrSchedule count]);
    
    if(ModeType==GetEventList)
    {
        [self InsertArray:arrSchedule];
    }
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(EventsListLoadingCompleted:)])
	{
		[(id)[self delegate] EventsListLoadingCompleted:arrSchedule];
	}
}


-(void)EventsListLoadingCompleted
{
    
}


-(void)dealloc
{
    delegate = nil;
    [str_type release];
    [str_date release];
    [str_category release];
    [super dealloc];
}



@end
