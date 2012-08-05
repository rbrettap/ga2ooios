//
//  RegistrationBL.h
//  Ga2oo
//
//  Created by AJIT MISHRA on 6/4/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "RegisterObject.h"
#import "RegistrationXML.h"

@protocol RegistrationXML_Delegate;
@class RegisterObject;

@interface RegistrationBL : BaseBussinessLayer <RegistrationXML_Delegate>  {
 
	id delegate;
	 BOOL CompletedParser;
	RegistrationXML *parser; 
	NSURLConnection *connection;
}
@property(nonatomic,retain)	NSURLConnection *connection;
@property(nonatomic,assign) id delegate;
 
-(void)RegisterTheUserwith:(RegisterObject *)regObj;
-(void)UpdateProfileXML:(NSMutableArray *)arr;
-(void)UpdateProfileCompleted:(RegisterObject *)Object;
 
@end
