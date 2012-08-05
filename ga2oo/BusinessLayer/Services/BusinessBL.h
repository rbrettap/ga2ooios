//
//  BusinessBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "BusinessBO.h"
#import "BusinessDA.h"
#import "BusinessXML.h"

@interface BusinessBL : BaseBussinessLayer {

	id delegate;
	BusinessXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadBusiness;
-(void)BusinessXml;
-(void)BusinessLoadingCompleted;

@end
