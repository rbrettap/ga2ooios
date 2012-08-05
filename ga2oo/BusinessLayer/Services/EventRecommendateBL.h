//
//  EventRecommendateBL.h
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussinessLayer.h"
#import "EventRecommendateBO.h"
#import "EventRecommendateDA.h"
#import "EventRecommendateXML.h"

@interface EventRecommendateBL : BaseBussinessLayer <EventRecommendateXML_Delegate>{
    
    EventRecommendateXML *parser;
	BOOL CompletedParser;
	UIAlertView *locationAlert;
    id delegate;
}

@property(nonatomic,assign) id delegate;

-(void)LoadEventRecommendate;
-(void)NewRecommendateXml;
-(void)RecommendationLoadingCompleted;

@end
