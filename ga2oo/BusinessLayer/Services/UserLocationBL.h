//
//  UserLocationBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "UserLocationBO.h"
#import "UserLocationDA.h"
#import "UserLocationXML.h"
@class Ga2ooAppDelegate;
@interface UserLocationBL : BaseBussinessLayer <UserLocationXML_Delegate>{
	Ga2ooAppDelegate *appDelegate;
	NSURLConnection *connection;
	NSString *strLocIdToDelete;

	id delegate;
}
@property(nonatomic, retain) NSURLConnection *connection;

@property(nonatomic,assign) id delegate;

-(void)LoadUserLocation;
-(void)NewUserLocationXml;
-(void)UserLocationLoadingCompleted;


@end
