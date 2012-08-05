//
//  GlobalizationBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "GlobalizationBO.h"
#import "GlobalizationDA.h"
#import "GlobalizationXML.h"


@interface GlobalizationBL : BaseBussinessLayer <GlobalizationXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadGlobalization;
-(void)GlobalizationXml;
-(void)GlobalizationLoadingCompleted;


@end
