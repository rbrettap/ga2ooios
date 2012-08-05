//
//  UserInboxBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserInboxBO.h"
#import "UserInboxDA.h"
#import "UserInboxXML.h"

@interface UserInboxBL : BaseBussinessLayer <UserInboxXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUserInbox;
-(void)NewUserInboxXml;
-(void)UserInboxLoadingCompleted;

@end
