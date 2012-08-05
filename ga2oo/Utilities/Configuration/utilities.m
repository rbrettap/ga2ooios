//
//  utilities.m
//  iVoucher
//
//  Created by narendar on 14/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "utilities.h"


@implementation utilities
@synthesize intValue;

+ (CGSize)getStrinsize:(NSString *)str forSize:(CGSize)size fontSize:(CGFloat)font
{
	CGSize strSize = [str sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
	return strSize;
}

/*+(NSString)adjustStringByRemovingComma:(NSString *)strValue{

	NSString *str=[strValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSArray *arrItems= [str	componentsSeparatedByString:@","];

}*/

-(double)CalculateDistanceWithLat1:(double)nLat1 Lon1:(double)nLon1 Lat2:(double)nLat2 Long2:(double)nLon2{
	
	
	double nRadius = 6371; // Earth's radius in Kilometers
	
	// Get the difference between our two points then convert the difference into radians;
	
	double nDLat =[self ToRad:nLat2 - nLat1];  
	double nDLon =[self ToRad:nLon2 - nLon1];
	
	nLat1 = [self ToRad:nLat1];
	nLat2 = [self ToRad:nLat2];
	
	double nA =	pow ( sin(nDLat/2), 2 ) +
	cos(nLat1) * cos(nLat2) * 
	pow ( sin(nDLon/2), 2 );
	
	double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
	double nD = nRadius * nC;
	
	//return  nD/1.609344; // Return our calculated distance in miles
	return  nD;
	
}

-(double)ToRad:(double)nVal{
	
	return nVal * (M_PI/180);
	
}


@end
