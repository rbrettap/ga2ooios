//
//  EventCategoryBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventCategoryBO.h"
#import "EventCategoryDA.h"
#import "EventCategoryXML.h"

@interface EventCategoryBL : BaseBussinessLayer <EventCategoryXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadEventsCategory;
-(void)EventsCategoryXml;
-(void)EventsCategoryLoadingCompleted;


@end
