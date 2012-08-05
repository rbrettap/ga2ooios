//
//  utilities.h
//  iVoucher
//
//  Created by narendar on 14/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface utilities : NSObject {

	NSInteger intValue;
}
@property (nonatomic) NSInteger intValue;
+ (CGSize)getStrinsize:(NSString *)str forSize:(CGSize)size fontSize:(CGFloat)font;
//+(NSString)adjustStringByRemovingComma:(NSString *)strValue;
-(double)CalculateDistanceWithLat1:(double)nLat1 Lon1:(double)nLon1 Lat2:(double)nLat2 Long2:(double)nLon2;
-(double)ToRad:(double)nVal;

@end
