//
//  CategoryBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "CategoryBO.h"
#import "CategoryDA.h"
#import "CategoryXML.h"

@interface CategoryBL : BaseBussinessLayer <CategoryXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadCategory;
-(void)CategoryXml;
-(void)CategoryLoadingCompleted;

@end
