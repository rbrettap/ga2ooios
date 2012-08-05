//
//  FriendsBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//
#import "Ga2ooUserBO.h"
#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "FriendsBO.h"
#import "FriendsDA.h"
#import "FriendsXML.h"

@interface FriendsBL : BaseBussinessLayer <FriendsXML_Delegate> {

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadFriends;
-(void)NewFriendsXml;
-(void)FriendsLoadingCompleted:(NSMutableArray *)arrFriends;
-(BOOL)deleteTheFriendFromServer:(FriendsBO *)selObj;
-(void)deleteObject:(FriendsBO *)baseBussiness;


-(BOOL)addTheUserAsFriendFromServer:(Ga2ooUserBO *)selObj;


@end
