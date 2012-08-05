//
//  ServiceOutput.m
//  Transformation
//
//  Created by WINIT on 11/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServiceOutput.h"


@implementation ServiceOutput

@synthesize arrData, maxRecords,responseStringfromWeb,arrDataSecond;

+(ServiceOutput*)arrayWithArray:(NSMutableArray*)array
{
	ServiceOutput *Data = [[ServiceOutput alloc] init];
	Data.arrData = array;
	Data.maxRecords = [array count];
	
	return [Data autorelease];
}

+(ServiceOutput*)arrayWithArray:(NSMutableArray*)array andMaxRecords:(int)maxRecords
{
	ServiceOutput *arrDataObj = [[ServiceOutput alloc] init];
	arrDataObj.arrData = array;
	arrDataObj.maxRecords = maxRecords;
	
	return [arrDataObj autorelease];
}
+(ServiceOutput*)stringWithTheResponseString:(NSString *)responseStr
{
	ServiceOutput *arrDataObj = [[ServiceOutput alloc] init];
	arrDataObj.responseStringfromWeb = responseStr;
 	
	return [arrDataObj autorelease];
}
+(ServiceOutput*)arrayWithArray:(NSMutableArray*)array andSecondArray:(NSMutableArray *)thesecondArray andMaxRecords:(int)maxRecords
{
	ServiceOutput *arrDataObj = [[ServiceOutput alloc] init];
 	
	arrDataObj.arrData = array;
	arrDataObj.arrDataSecond = thesecondArray;
 	arrDataObj.maxRecords = maxRecords;
	
	return [arrDataObj autorelease];
}

@end
