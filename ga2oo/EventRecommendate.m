//
//  EventRecommendate.m
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EventRecommendate.h"


@implementation EventRecommendate
@dynamic strfromid;
@dynamic strfromname;
@dynamic strthread_id;
@dynamic strsubject;
@dynamic strmessage;
@dynamic stris_read;
@dynamic strgaeventid;
@dynamic strgaeventname;
@dynamic strdate_Created;

+(NSString*)TableName
{
    return @"EventRecommendate";
}

+(NSString*)PrimarykeyColumnName
{
    return @"strfromid";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	EventRecommendateBO *obj_ = (EventRecommendateBO *)object;
	[self setStrfromid:obj_.strfromid]; 
    [self setStrfromname:obj_.strfromname];
    [self setStrthread_id:obj_.strthread_id];
	[self setStrsubject:obj_.strsubject];
	[self setStrmessage:obj_.strmessage];
	[self setStris_read:obj_.stris_read];
	[self setStrgaeventid:obj_.strgaeventid];
	[self setStrgaeventname:obj_.strgaeventname];
	[self setStrdate_Created:obj_.strdate_Created];

}

@end
