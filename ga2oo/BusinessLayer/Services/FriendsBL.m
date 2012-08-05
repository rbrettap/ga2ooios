//
//  FriendsBL.m
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "FriendsBL.h"
#import "UserDA.h"
#import "HttpRequest.h"
#import "ServiceOutput.h"
#import "ServiceRequestXML.h"

@implementation FriendsBL
@synthesize delegate;

-(BOOL)Insert:(FriendsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
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

-(BOOL)Update:(FriendsBO*)BaseBusinessObj withSave:(BOOL)Save
{
    if(BaseBusinessObj != nil && BaseBusinessObj.FriendId !=nil){
        FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
        NSString *PrimarykeyColumnName = [Friends PrimarykeyColumnName];
        NSString *primarykey = [BaseBusinessObj valueForKey:PrimarykeyColumnName];
        if (primarykey !=nil) 
        {
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
    for(FriendsBO *object in arrData)
    {
        NSString *key = [object valueForKey:[Friends PrimarykeyColumnName]];
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
    FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
    BaseCoreDataObject *FrindCDO = [dataAccessLayer SelectByKey:Key withMode:ModeString];
    
    FriendsBO *Frind = nil; 
    
    if(FrindCDO != nil)
    {
        Frind = [[FriendsBO alloc] init];
        [Frind CopyData:FrindCDO];
    }
    
    [dataAccessLayer release];
    return Frind;
}

-(NSMutableArray*)SelectAll
{
	
	FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
    NSMutableArray *arrData = [dataAccessLayer SelectAll];
	
	NSMutableArray *ArrCopyObjects = [[NSMutableArray alloc]init];
    
    for(Friends *UserCDO in arrData)
    {
        if(UserCDO != nil)
        {
            FriendsBO *User1 = [[FriendsBO alloc] init];
            [User1 CopyData:UserCDO];
            [ArrCopyObjects addObject:User1];
            [User1 release];
            User1=nil;
        }
    }
	
    [dataAccessLayer release];
    return [ArrCopyObjects autorelease];
 
}
-(void)deleteObject:(FriendsBO *)baseBussiness
{
    FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
   // NSString *PrimarykeyColumnName = [Friends PrimarykeyColumnName];
    //NSString *primarykey = [baseBussiness valueForKey:PrimarykeyColumnName];
    BaseCoreDataObject *baseBusinessObject = [dataAccessLayer SelectByKey:baseBussiness.FriendId withMode:YES];
    
    [dataAccessLayer DeleteObject:baseBusinessObject];
    [dataAccessLayer release];
}
-(void)deleteAll
{
    FriendsDA *dataAccessLayer = [[FriendsDA alloc]init];
    [dataAccessLayer DeleteAll];
     [dataAccessLayer release];
}

-(void)LoadFriends
{
    [self performSelectorOnMainThread:@selector(NewFriendsXml) withObject:nil waitUntilDone:NO];
}

-(void)NewFriendsXml
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    FriendsXML *parser = [FriendsXML saxParser];
    parser.delegate = self;
    [parser getData];
    parser = nil;
    [pool release];
}

- (void)FriendsXML_Error:(FriendsXML*)parser encounteredError:(NSError *)error
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FriendsLoadingCompleted:)])
	{
		[(id)[self delegate] FriendsLoadingCompleted:nil];
	}
}

- (void)FriendsXML_Finished:(NSMutableArray*)arrSchedule;
{
	
	[self InsertArray:arrSchedule];
	
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(FriendsLoadingCompleted:)])
	{
		[(id)[self delegate] FriendsLoadingCompleted:arrSchedule];
	}
}

-(void)FriendsLoadingCompleted:(NSMutableArray *)arrFriends
{
    
}
///////////////////////////////////////// DELETE FRIENDS /////////////////////////////

-(BOOL)deleteTheFriendFromServer:(FriendsBO *)selObj{
	
    Ga2ooAppDelegate *appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
     if(appDelegate.isNetAvail)
	{
		HttpRequest *request = [[HttpRequest alloc] init];
 		[request PostRequestToDelete:[NSString stringWithFormat:@"%@%i/deleteids/%i",Ga2ooDeleteFriend,[appDelegate.currentUserID integerValue],[selObj.addedFriendId integerValue]] Delegate:self Tag:10];
  		[request release];		
		return TRUE;
	}
	else {
 		return FALSE;
 	}
    
}

-(void)httpResponseReceived:(WebResponse *)response
{
	
    if (response.tag == 10) {
        NSString *responseString = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
         
        NSString *opstr = [self flattenHTML:responseString];
        NSLog(@"opstr %@",opstr);
         opstr=[opstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompleted:)])
   {
       [(id)[self delegate] ServiceRequestCompleted:[ServiceOutput stringWithTheResponseString:opstr]];
   }
            
         
    }
     
}
///////////////////////////////////////// ADD FRIENDS /////////////////////////////
-(BOOL)addTheUserAsFriendFromServer:(Ga2ooUserBO *)selObj{

    Ga2ooAppDelegate *appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	NSString *strUrl = [NSString stringWithFormat:@"%@",Ga2ooAddFriend];
	NSString *strSoapMsg =  [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<useraccount>\n"
							 "<id>%@</id>\n"
                             "<friendships>\n"
                             "<friend>\n"
   							 "<friendid>%@</friendid>\n"
                             "</friend>\n"
                             "</friendships>\n"
  							 "</useraccount>\n",appDelegate.currentUserID,selObj.ga2ooUserId];
	
	NSMutableArray *arrRequest = [[NSMutableArray alloc]init]	;
	[arrRequest addObject:strUrl];
	[arrRequest addObject:strSoapMsg];
	[self performSelectorOnMainThread:@selector(ServiceRequestXML:) withObject:arrRequest waitUntilDone:NO];
	return YES;
}

-(void)ServiceRequestXML:(NSMutableArray *)arrRequest
{
  	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	ServiceRequestXML *parser = [ServiceRequestXML saxParser];
 	parser.arrRequest = arrRequest;
    parser.delegate = self; 
    [parser getData];
    [pool release];
}

- (void)ServiceRequestXML_Error:(ServiceRequestXML*)parser encounteredError:(NSError *)error with:(ServiceOutput *)Object
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompletedToAddFriend:)])
	{
		[(id)[self delegate] ServiceRequestCompletedToAddFriend:Object];
	}
}


- (void)ServiceRequestXML_Finished:(ServiceOutput *)parser1
{    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(ServiceRequestCompletedToAddFriend:)])
	{
		[(id)[self delegate] ServiceRequestCompletedToAddFriend:parser1];
	}
}

-(void)ServiceRequestCompletedToAddFriend:(ServiceOutput *)Object
{
    
}
@end
