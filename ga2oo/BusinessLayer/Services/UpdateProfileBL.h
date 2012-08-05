//
//  UpdateProfileBL.h
//  Ga2oo
//
//  Created by Mayank goyal on 30/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UpdateProfileBO.h"
#import "UpdateProfileDA.h"
#import "UpdateProfileXML.h"
@class Ga2ooAppDelegate;
@interface UpdateProfileBL : BaseBussinessLayer<UpdateProfileXML_Delegate> {
	Ga2ooAppDelegate *appDelegate;
	id delegate;
	BOOL CompletedParser;
	UpdateProfileXML *parser;
	NSURLConnection *connection;
}
@property(nonatomic,assign) id delegate;
@property(nonatomic, retain) NSURLConnection *connection;

-(void)LoadUpdateProfile:(NSInteger)userId with:(NSString *)soapMsg;
-(void)UpdateProfileXML:(NSString *)arr;
-(void)UpdateProfileCompleted:(UpdateProfileBO *)Object;

@end
