//
//  EventVideosBL.h
//  Ga2oo
//
//  Created by Mayank Goyal on 04/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventVideosBO.h"
#import "EventVideosDA.h"
#import "EventVideosXML.h"

@interface EventVideosBL : BaseBussinessLayer <EventVideosXML_Delegate>{

	id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadEventVideos;
-(void)NewEventVideosXml;
-(void)EventVideosLoadingCompleted;

@end
