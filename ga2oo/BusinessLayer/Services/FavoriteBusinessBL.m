//
//  FavoriteBusinessBL.m
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FavoriteBusinessBL.h"
#import "BusinessListDA.h"
#import "BusinessList.h"

@implementation FavoriteBusinessBL

@synthesize delegate;

@synthesize strSopForAddBussinessEvnt;
@synthesize strSopForAddEvent;
@synthesize strSopDelEvent;
@synthesize objEventLtBO;
@synthesize addFavEvnt;
@synthesize objFavBusEvtBO;
@synthesize  strSopForDeleteEvnt;

-(BOOL)Insert:(FavoriteBusinessBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteBusinessDA *dataAccessLayer = [[FavoriteBusinessDA alloc]init];
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

-(BOOL)Update:(FavoriteBusinessBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteBusinessDA *dataAccessLayer = [[FavoriteBusinessDA alloc]init];
    NSString *PrimarykeyColumnName = [FavoriteBusiness PrimarykeyColumnName];
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

-(BOOL)InsertEvent:(AddFavEventBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
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

-(BOOL)UpdateEvent:(AddFavEventBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    NSString *PrimarykeyColumnName = [AddFavEvent PrimarykeyColumnName];
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

-(BOOL)InsertBusinessEvent:(FavoriteBusinessEventBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
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

-(BOOL)UpdateBusinessEvent:(FavoriteBusinessEventBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
    NSString *PrimarykeyColumnName = [FavoriteBusinessEvent PrimarykeyColumnName];
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
    for(FavoriteBusinessBO *object in arrData)
    {
        NSString *key = [object valueForKey:[FavoriteBusiness PrimarykeyColumnName]];
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
    FavoriteBusinessDA *dataAccessLayer = [[FavoriteBusinessDA alloc]init];
    BaseCoreDataObject *FrindCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    FavoriteBusinessBO *Frind = nil; 
    if(FrindCDO != nil)
    {
        Frind = [[FavoriteBusinessBO alloc] init];
        [Frind CopyData:FrindCDO];
    }
    
    [dataAccessLayer release];
    return Frind;
}

-(NSMutableArray*)SelectAllByKey:(NSString*)key
{
	NSMutableArray *arrOfFav = [[NSMutableArray alloc]init];
	[arrOfFav addObject:[self SelectByKey:key withMode:NO]];
	return [arrOfFav autorelease];
}

-(NSMutableArray*)SelectAll
{
    FavoriteBusinessDA *dataAccessLayer = [[FavoriteBusinessDA alloc]init];
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
	
	BusinessListDA *objUserDA = [[BusinessListDA alloc]init];
    NSMutableArray *arrUsers = [objUserDA SelectAll];
    [objUserDA release];
	
	NSArray *friendIds = [arrFriend valueForKey:@"id"];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id IN %@",friendIds];
	NSMutableArray *filteredUsers = (NSMutableArray *)[arrUsers filteredArrayUsingPredicate:predicate];
	
	arrFriend = nil;
	arrUsers = nil;
	
    NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    for(BusinessList *objUser in filteredUsers)
    {
        if(objUser != nil)
        {
            BusinessListBO *objUserBO = [[BusinessListBO alloc] init];
            [objUserBO CopyData:objUser];
            [ArrCopyObjects addObject:objUserBO];
            [objUserBO release];
            objUserBO=nil;
        }
    }
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)SelectAllBusinessEventsByKey:(NSInteger)userIdofTheEvnt
{
	FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    for(FavoriteBusinessEvent *objEvn in arrFriend)
    {
        if([objEvn.UserId integerValue]== userIdofTheEvnt)
        {
            FavoriteBusinessEventBO *objEvnBO = [[FavoriteBusinessEventBO alloc] init];
            [objEvnBO CopyData:objEvn];
            [ArrCopyObjects addObject:objEvnBO];
            [objEvnBO release];
            objEvnBO=nil;
        }
    }
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)SelectAllEventsByKey:(NSInteger)userIdofTheEvnt
{
	FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    for(AddFavEvent *objEvn in arrFriend)
    {
        if([objEvn.UserId integerValue]== userIdofTheEvnt)
        {
            AddFavEventBO *objEvnBO = [[AddFavEventBO alloc] init];
            [objEvnBO CopyData:objEvn];
            [ArrCopyObjects addObject:objEvnBO];
            [objEvnBO release];
            objEvnBO=nil;
        }
    }
	
    return [ArrCopyObjects autorelease];
}

-(NSMutableArray*)SelectfavEventsByKey:(NSInteger)FavEventId
{
	FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    for(AddFavEvent *objEvn in arrFriend)
    {
        if([objEvn.EventId integerValue]== FavEventId)
        {
            AddFavEventBO *objEvnBO = [[AddFavEventBO alloc] init];
            [objEvnBO CopyData:objEvn];
            [ArrCopyObjects addObject:objEvnBO];
            [objEvnBO release];
            objEvnBO=nil;
        }
    }
    

	
    return [ArrCopyObjects autorelease];
}

-(void*)DeletefavEventsByKey:(NSInteger)FavEventId
{
	FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    
    AddFavEvent *objEvn;
    
    BOOL Isfound = NO;
    
    for(objEvn in arrFriend)
    {
        if([objEvn.EventId integerValue]== FavEventId)
        {
            Isfound = YES;
            break;
        }
    }
    
    
    if(Isfound)
    {
        [dataAccessLayer DeleteObject:objEvn];
    }
    
    [dataAccessLayer release];

}


-(void*)DeletefavBusinessByKey:(NSInteger)FavBusinessId
{
	FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
    
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    
    FavoriteBusinessEventBO *objEvn;
    
    BOOL Isfound = NO;
    
    for(objEvn in arrFriend)
    {
        if([objEvn.BusinessId integerValue]== FavBusinessId)
        {
            Isfound = YES;
            break;
        }
    }
    
    
    if(Isfound)
    {
        [dataAccessLayer DeleteObject:objEvn];
    }
    
    [dataAccessLayer release];
    
}



-(NSMutableArray*)SelectAllEvents
{
	FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    NSMutableArray *arrFriend = [dataAccessLayer SelectAll];
    [dataAccessLayer release];
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    for(AddFavEvent *objEvn in arrFriend)
    {
		AddFavEventBO *objEvnBO = [[AddFavEventBO alloc] init];
		[objEvnBO CopyData:objEvn];
		[ArrCopyObjects addObject:objEvnBO];
		[objEvnBO release];
		objEvnBO=nil;
	}
    return [ArrCopyObjects autorelease];
}

-(void)deleteAll
{
    FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
    [dataAccessLayer DeleteAll];
    [dataAccessLayer release];
	FavoriteEventDA *dataAccessLayerevent = [[FavoriteEventDA alloc]init];
	[dataAccessLayerevent DeleteAll];
    [dataAccessLayerevent release];
}

-(void)LoadFavoriteBusiness
{
    [self performSelectorOnMainThread:@selector(NewFavoriteBusinessXml) withObject:nil waitUntilDone:NO];
}

-(void)addFavoriteBusiness
{
	    [self performSelectorOnMainThread:@selector(AddFavoriteBusinessXml) withObject:nil waitUntilDone:NO];
}

-(void)loadFavoriteEvent
{
	    [self performSelectorOnMainThread:@selector(AddFavoriteEventXml) withObject:nil waitUntilDone:NO];
}

-(void)deleteFavorite
{
	[self performSelectorOnMainThread:@selector(deleteAddedFavouriteXml) withObject:nil waitUntilDone:NO];
}

-(void)AddFavoriteBusinessXml
{
	CompletedParser = NO;
	addFavParser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    addFavParser = [AddFavouriteToBusinessXML saxParser];
	addFavParser.strSoapMsg = self.strSopForAddBussinessEvnt;
    addFavParser.delegate = self;
    [addFavParser getData];
    [pool release];
}

-(void)AddFavoriteEventXml
{
	CompletedParser = NO;
	addFavEvtParser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    addFavEvtParser = [AddFavouriteToEventXML saxParser];
	addFavEvtParser.strSoapMsg = self.strSopForAddEvent;
    addFavEvtParser.delegate = self;
    [addFavEvtParser getData];
    [pool release];
}

-(void)NewFavoriteBusinessXml
{
	CompletedParser = NO;
	parser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    parser = [FavoriteBusinessXML saxParser];
    parser.delegate = self;
    [parser getData];
    [pool release];
}

-(void)deleteAddedFavouriteXml
{
	CompletedParser = NO;
	delFavParser =nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    delFavParser = [DeleteFavouriteToEventXML saxParser];
	delFavParser.strSoapMsg = self.strSopForDeleteEvnt;
    delFavParser.delegate = self;
    [delFavParser getData];
    [pool release];
}

- (void)FavoriteBusinessXML_Error:(FavoriteBusinessXML*)parser encounteredError:(NSError *)error
{
	CompletedParser =YES;
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FavoriteBusinessLoadingCompleted:)])
	{
		[(id)[self delegate] FavoriteBusinessLoadingCompleted:nil];
	}
}

- (void)FavoriteBusinessXML_Finished:(NSMutableArray*)arrSchedule
{
	
	[self InsertArray:arrSchedule];
	
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FavoriteBusinessLoadingCompleted:)])
	{
		[(id)[self delegate] FavoriteBusinessLoadingCompleted:arrSchedule];
	}
	CompletedParser =YES;
}

-(void)FavoriteBusinessLoadingCompleted:(NSMutableArray *)arrFriends
{
    
}

-(void)AddFavouriteToEventXML_Error:(AddFavouriteToEventXML*)parser encounteredError:(NSError *)error with:(AddFavouriteToEventBO *)Object
{
	CompletedParser =YES;
	NSLog(@"adding favourite Event  is getting error while upload to server");
}

-(void)InsertFavBusinessEvent:(FavoriteBusinessEventBO *)favEventBO
{
	//NSString *key = [favEventBO valueForKey:[AddFavEvent PrimarykeyColumnName]];
	NSString *key = [NSString stringWithFormat:@"%i",favEventBO.BusinessId];
	BaseBusinessObject *object_business = [self SelectByKeyForEvent:key withMode:NO];
	if(object_business != nil)
	{
		[self UpdateBusinessEvent:favEventBO withSave:NO];
	}
	else
	{
		[self InsertBusinessEvent:favEventBO withSave:NO];
	}
    
    [self Save];
}

-(BaseBusinessObject*)SelectByKeyForBusinessEvent:(NSString*)Key withMode:(BOOL)ModeString
{
    FavoriteBusinessEventDA *dataAccessLayer = [[FavoriteBusinessEventDA alloc]init];
    BaseCoreDataObject *FrindCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    FavoriteBusinessEventBO *Frind = nil; 
    if(FrindCDO != nil)
    {
        Frind = [[FavoriteBusinessEventBO alloc] init];
        [Frind CopyData:FrindCDO];
    }
    
    [dataAccessLayer release];
    return Frind;
}

-(void)InsertFavEvent:(AddFavEventBO *)favEventBO
{
	    NSString *key = [NSString stringWithFormat:@"%i",favEventBO.EventId];
        BaseBusinessObject *object_business = [self SelectByKeyForEvent:key withMode:NO];
        if(object_business != nil)
        {
            [self UpdateEvent:favEventBO withSave:NO];
        }
        else
        {
            [self InsertEvent:favEventBO withSave:NO];
        }
       [self Save];
}

-(void)InsertArrayFavEvents:(NSMutableArray *)arrSchedule
{
	for(AddFavEventBO *favEventBO in arrSchedule)
	{
		NSString *key = [NSString stringWithFormat:@"%i",favEventBO.UserAddedEventId];
		BaseBusinessObject *object_business = [self SelectByKeyForEvent:key withMode:NO];
		if(object_business != nil)
		{
			[self UpdateEvent:favEventBO withSave:NO];
		}
		else
		{
			[self InsertEvent:favEventBO withSave:NO];
		}
	}
	[self Save];
	if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FavoriteEventsLoadingCompleted)])
	{
		[(id)[self delegate] FavoriteEventsLoadingCompleted];
	}
}

-(BaseBusinessObject*)SelectByKeyForEvent:(NSString*)Key withMode:(BOOL)ModeString
{
    FavoriteEventDA *dataAccessLayer = [[FavoriteEventDA alloc]init];
    BaseCoreDataObject *FrindCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    AddFavEventBO *Frind = nil; 
    if(FrindCDO != nil)
    {
        Frind = [[AddFavEventBO alloc] init];
        [Frind CopyData:FrindCDO];
    }
    [dataAccessLayer release];
    return Frind;
}

-(void)AddFavouriteToEventXML_Finished:(AddFavouriteToEventBO *)favBo
{
	NSInteger isFaventAdded = 0;
	NSString *strMsg = @"";

	if(favBo!=nil)
	{
		NSString *strEvnt = [favBo.Result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		if(![strEvnt isEqualToString:@"0"] && ![strEvnt isEqualToString:@"1"] && ![strEvnt isEqualToString:@"-2"])
	    {
			self.addFavEvnt.UserAddedEventId = [strEvnt integerValue];
			[self InsertFavEvent:self.addFavEvnt];
            
			isFaventAdded = 1;// successfully added
		}
		if([strEvnt isEqualToString:@"0"])
		{
			isFaventAdded = 2;//already added
		}
		if([strEvnt isEqualToString:@"1"] || [strEvnt isEqualToString:@"-2"])
		{
			isFaventAdded = 3;//error
		}
	}
	if(isFaventAdded==1)
	{
		strMsg = @"Event selected has successfully been added to Palendar.";
	}
	else if(isFaventAdded==2)
	{
		strMsg = @"Event selected is already added to Palendar.";
	}
	else 
	{
		strMsg = @"Error while adding selected event to Palendar.";
	}
	if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(addingFavDidComplete:)])
	{
		[(id)[self delegate] addingFavDidComplete:strMsg];
	}
	CompletedParser =YES;
	NSLog(@"adding favourite Event is upload to server is done successfully.");
}

-(void)AddFavouriteToBusinessXML_Error:(AddFavouriteToBusinessXML*)parser encounteredError:(NSError *)error with:(AddFavouriteToBusinessBO *)Object
{
		CompletedParser =YES;
	NSLog(@"adding favorite to business is failed for uploading to server");
}

-(void)AddFavouriteToBusinessXML_Finished:(AddFavouriteToBusinessBO *)favBusinessBO
{
	NSInteger isFaventAdded = 0;
	NSString *strMsg = @"";

	if(favBusinessBO!=nil)
	{
		NSString *strEvnt = [favBusinessBO.Result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if(![strEvnt isEqualToString:@"0"] && ![strEvnt isEqualToString:@"1"] && ![strEvnt isEqualToString:@"-2"])
	    {
			self.objFavBusEvtBO.AddedBusinessId = [strEvnt integerValue];
			[self InsertFavBusinessEvent:self.objFavBusEvtBO];

            
            
			isFaventAdded = 1;// successfully added
		}
		if([strEvnt isEqualToString:@"0"])
		{
			isFaventAdded = 2;//already added
		}
		if([strEvnt isEqualToString:@"1"] || [strEvnt isEqualToString:@"-2"])
		{
			isFaventAdded = 3;//error
		}
	}
	if(isFaventAdded==1)
	{
		strMsg = @"Selected organization has been successfully added as favorites.";
	}
	else if(isFaventAdded==2)
	{
		strMsg = @"Selected organization is already added as favorites.";
	}
	else 
	{
		strMsg = @"Error while adding selected organization as favourite.";
	}
	if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FavoriteBusinessEventsLoadingCompleted:)])
	{
		[(id)[self delegate] FavoriteBusinessEventsLoadingCompleted:strMsg];
	}
	
	CompletedParser =YES;
	NSLog(@"adding favorite to business is done for uploading to server");
}

-(void)FavoriteBusinessEventsLoadingCompleted:(NSString*)strMsgs
{
	
}


-(void)DeleteFavouriteToEventXML_Error:(DeleteFavouriteToEventXML*)parser encounteredError:(NSError *)error with:(DeleteFavouriteToEventBO *)Object
{
	CompletedParser =YES;
	NSLog(@"Deleting favorite to business is failed for uploading to server %@",[error description]);
}

-(void)DeleteFavouriteToEventXML_Finished:(DeleteFavouriteToEventBO *)delfavBo
{
	CompletedParser =YES;
    

    
    NSInteger isFaventdeleted = 0;
	NSString *strMsg = @"";
    
	if(delfavBo!=nil)
	{
		NSString *strEvnt = [delfavBo.Result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSRange rangeIs = [strEvnt rangeOfString:@"event recommendations was created with" options:NSCaseInsensitiveSearch];
        if(rangeIs.length > 20)
        {
            isFaventdeleted = 1;
        }
	}
	if(isFaventdeleted==1)
	{
		strMsg = @"Recommendations send successfully.";
	}
	else if(isFaventdeleted==2)
	{
		strMsg = @"Selected event is already removed from favorite events.";
	}
	else 
	{
		strMsg = @"Error while sending recommendations.";
	}
	if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FavoriteEventDeletCompleted:)])
	{
		[(id)[self delegate] FavoriteEventDeletCompleted:strMsg];
	}
    
	NSLog(@"Deleting favorite to business is done for uploading to server");
}

-(void)FavoriteEventDeletCompleted:(NSString*)arrFriends
{
	
}


-(void)addingFavDidComplete:(NSString*)msg
{
}

-(void)dealloc
{
	if(!CompletedParser)
	{
		parser.delegate =nil;
		addFavParser.delegate = nil;
		addFavEvtParser.delegate = nil;
		delFavParser.delegate = nil;
	}
	
	addFavParser = nil;
	addFavEvtParser = nil;
	delFavParser = nil;
	parser =nil;
	
	if(objEventLtBO!=nil)
	{
	  [objEventLtBO release];
	}
	objEventLtBO = nil;
    [strSopForDeleteEvnt release];
	[strSopForAddBussinessEvnt release];
	[strSopForAddEvent release];
	[strSopDelEvent release];
	
	strSopForAddBussinessEvnt = nil;
	strSopForAddEvent = nil;
	strSopDelEvent= nil;
	
	[super dealloc];
}

@end
