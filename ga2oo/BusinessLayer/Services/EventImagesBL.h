//
//  EventImagesBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventImagesBO.h"
#import "EventImagesDA.h"
 
@interface EventImagesBL : BaseBussinessLayer {

	id delegate;
}

@property(nonatomic,assign) id delegate;


@end
