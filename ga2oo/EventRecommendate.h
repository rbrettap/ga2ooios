//
//  EventRecommendate.h
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import "EventRecommendateBO.h"


@interface EventRecommendate : BaseCoreDataObject {

}
@property (nonatomic, retain) NSString * strfromid;
@property (nonatomic, retain) NSString * strfromname;
@property (nonatomic, retain) NSString * strthread_id;
@property (nonatomic, retain) NSString * strsubject;
@property (nonatomic, retain) NSString * strmessage;
@property (nonatomic, retain) NSString * stris_read;
@property (nonatomic, retain) NSString * strgaeventid;
@property (nonatomic, retain) NSString * strgaeventname;
@property (nonatomic, retain) NSString * strdate_Created;

@end
