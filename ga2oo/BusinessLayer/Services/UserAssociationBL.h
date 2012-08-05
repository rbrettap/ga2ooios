//
//  UserAssociationBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserAssociationBO.h"
#import "UserAssociationDA.h"
#import "UserAssociationXML.h"

@interface UserAssociationBL : BaseBussinessLayer <UserAssociationXML_Delegate>{

	id delegate;
	UserAssociationXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadUserAssociation:(NSInteger)userId;;
-(void)NewUserAssociationXml:(NSNumber *)userId;
-(void)UserAssociationLoadingCompleted;

@end
