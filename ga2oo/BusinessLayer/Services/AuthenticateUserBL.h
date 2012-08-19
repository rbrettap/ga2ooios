//
//  AuthenticateUserBL.h
//  Ga2oo
//
//  Created by Fakhre Alam on 30/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "AuthenticateUserBO.h"
#import "AuthenticateUserXML.h"


@interface AuthenticateUserBL : BaseBussinessLayer<AuthenticateUserXML_Delegate> {

	id delegate;
	BOOL CompletedParser;
	AuthenticateUserXML *parser;
}
@property(nonatomic,assign) id delegate;

-(void)LoadAuthenticateUserWith:(NSDictionary *)soapMsg;
-(void)AuthenticateUserXML:(NSString *)soapMsg;
-(void) AuthenticateUserCompleted:(AuthenticateUserBO *)Object;


@end
