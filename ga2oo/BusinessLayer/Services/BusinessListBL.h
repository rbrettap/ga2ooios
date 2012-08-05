//
//  BusinessListBL.h
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "BusinessListBO.h"
#import "BusinessListDA.h"
#import "BusinessListXML.h"

@interface BusinessListBL : BaseBussinessLayer<BusinessListXML_Delegate> {

	id delegate;
	BOOL CompletedParser;
	BusinessListXML *parser;
}
@property(nonatomic,assign) id delegate;

-(void)LoadBusinessList;
-(void)NewBusinessListXml;
-(void)BusinessListLoadingCompleted;

@end
