//
//  FavoriteBusinessBL.h
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "FavoriteBusinessBO.h"
#import "FavoriteBusinessDA.h"
#import "FavoriteBusinessXML.h"
#import "AddFavouriteToBusinessXML.h"
#import "AddFavouriteToBusinessBO.h"
#import "AddFavouriteToEventXML.h"
#import "AddFavouriteToEventBO.h"
#import "DeleteFavouriteToEventXML.h"
#import "DeleteFavouriteToEventBO.h"
#import "AddFavEventBO.h"
#import "FavoriteEventDA.h"
#import "FavoriteBusinessEventBO.h"
#import "FavoriteBusinessEventDA.h"
#import "FavoriteBusinessEvent.h"

@interface FavoriteBusinessBL : BaseBussinessLayer<FavoriteBusinessXML_Delegate,AddFavouriteToBusinessXML_Delegate,AddFavouriteToEventXML_Delegate> 
{
	id delegate;
	FavoriteBusinessXML *parser;
	AddFavEventBO *addFavEvnt;
	AddFavouriteToBusinessXML *addFavParser;
	AddFavouriteToEventXML    *addFavEvtParser;
	DeleteFavouriteToEventXML *delFavParser;
	EventListBO *objEventLtBO;
	NSString *strSopForAddBussinessEvnt;
	NSString *strSopForAddEvent;
	NSString *strSopDelEvent;
	NSString *strSopForDeleteEvnt;
	BOOL CompletedParser;
	
	//Business
	FavoriteBusinessEventBO *objFavBusEvtBO;
}

@property (nonatomic, retain) 	FavoriteBusinessEventBO *objFavBusEvtBO;
@property (nonatomic, retain)	AddFavEventBO *addFavEvnt;
@property (nonatomic, retain) 	 EventListBO *objEventLtBO;
@property (nonatomic,  assign)   id delegate;
@property (nonatomic,  retain)   NSString *strSopForAddBussinessEvnt;
@property (nonatomic,  retain)   NSString *strSopForAddEvent;
@property (nonatomic,  retain)   NSString *strSopDelEvent;
@property (nonatomic,  retain) 	 NSString *strSopForDeleteEvnt;

-(void)LoadFavoriteBusiness;
-(void)loadFavoriteEvent;
-(void)NewFavoriteBusinessXml;

-(void)FavoriteBusinessLoadingCompleted:(NSMutableArray *)arrFriends;
-(void)FavoriteBusinessAddingCompleted:(NSMutableArray*)arrFriends;
-(void)FavoriteEventAddingCompleted:(NSMutableArray*)arrFriends;
-(void)FavoriteEventDeletCompleted:(NSString*)arrFriends;
-(BaseBusinessObject*)SelectByKeyForEvent:(NSString*)Key withMode:(BOOL)ModeString;
-(NSMutableArray*)SelectAllEvents:(NSInteger)userIdofTheEvnt;
-(NSMutableArray*)SelectAllEvents;
-(void)InsertArrayFavEvents:(NSMutableArray *)arrData;
-(void)FavoriteEventsLoadingCompleted;
-(void)FavoriteBusinessEventsLoadingCompleted:(NSString*)strmsg;
-(void)addingFavDidComplete:(NSString*)msg;
-(NSMutableArray*)SelectAllBusinessEventsByKey:(NSInteger)userIdofTheEvnt;
-(NSMutableArray*)SelectAllEventsByKey:(NSInteger)userIdofTheEvnt;

@end
