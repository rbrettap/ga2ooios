//
//  Globalization.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "GlobalizationBO.h"


@interface Globalization :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * Country;
@property (nonatomic, retain) NSNumber * CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * Address2;
@property (nonatomic, retain) NSNumber * Latitude;
@property (nonatomic, retain) NSString * State;
@property (nonatomic, retain) NSNumber * BusinessId;
@property (nonatomic, retain) NSNumber * ID;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSNumber * Longitude;
@property (nonatomic, retain) NSString * Address;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSString * GeoPoint;
@property (nonatomic, retain) NSString * City;
@property (nonatomic, retain) NSString * Address1;

@end



