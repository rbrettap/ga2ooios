//
//  BusinessTypeBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "BusinessTypeBO.h"
#import "BusinessTypeDA.h"
#import "BusinessTypeXML.h"

@interface BusinessTypeBL : BaseBussinessLayer <BusinessTypeXML_Delegate>{

	id delegate;
	BusinessTypeXML *parser;
	BOOL CompletedParser;
}

@property(nonatomic,assign) id delegate;

-(void)LoadBusinessType;
-(void)BusinessTypeXml;
-(void)BusinessTypeLoadingCompleted;

@end
