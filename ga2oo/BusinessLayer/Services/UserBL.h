//
//  UserBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserBO.h"
#import "UserDA.h"
#import "UserXML.h"

@interface UserBL : BaseBussinessLayer <UserXML_Delegate> {

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUser:(NSString *)userId;
-(void)NewUserXml:(NSString  *)userId;
-(void)UserLoadingCompleted;
-(void)Update:(UserBO *)object;
-(void)SaveUserLocations:(UserBO*)BaseBusinessObj;
-(void)SaveUserAssociations:(UserBO*)BaseBusinessObj;
@end
