//
//  ServiceOutput.h
//  Transformation
//
//  Created by WINIT on 11/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServiceOutput : NSObject 
{
	NSMutableArray *arrData;
	int maxRecords;
	NSMutableArray *arrDataSecond;
 	NSString *responseStringfromWeb;
}

@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic) int maxRecords;
@property(nonatomic, retain)NSMutableArray *arrDataSecond;
 @property(nonatomic, retain)NSString *responseStringfromWeb;


+(ServiceOutput*)arrayWithArray:(NSMutableArray*)array;
+(ServiceOutput*)arrayWithArray:(NSMutableArray*)array andMaxRecords:(int)maxRecords;
+(ServiceOutput*)stringWithTheResponseString:(NSString *)responseStr;

@end
