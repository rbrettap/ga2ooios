//
//  Business.h
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "BusinessBO.h"


@interface Business :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSNumber * CreatedBy;
@property (nonatomic, retain) NSNumber * BusinessTypeId;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSString * FaxNumber;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSNumber * BusinessId;
@property (nonatomic, retain) NSString * URL;
@property (nonatomic, retain) NSString * ImageData;
@property (nonatomic, retain) NSString * ContactEmail;
@property (nonatomic, retain) NSString * BusinessName;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * SupportEmail;
@property (nonatomic, retain) NSString * PhoneNumber;
@property (nonatomic, retain) NSString * Image;
@property (nonatomic, retain) NSData * IsActive;
@property (nonatomic, retain) NSString * EIN;
@property (nonatomic, retain) NSString * External_biz_id;

@end



