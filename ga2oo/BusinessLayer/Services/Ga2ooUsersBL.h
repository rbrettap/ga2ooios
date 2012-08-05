//
//  FriendsBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "Ga2ooUserBO.h"
#import "Ga2ooUsersDA.h"
#import "Ga2ooUsersXML.h"

@interface Ga2ooUsersBL : BaseBussinessLayer <Ga2ooUsersXML_Delegate> {

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadGa2ooUser;
-(void)getGa2ooUsersXML;
-(void)Ga2ooUsersLoadingCompleted:(NSMutableArray *)arrFriends;

@end
