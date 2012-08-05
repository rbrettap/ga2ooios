//
//  BusinessList.h
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "BusinessListBO.h"

@interface BusinessList :  BaseCoreDataObject  
{
}

@property(nonatomic,retain) NSString *zipcode;
@property(nonatomic,retain) NSString *url;
@property(nonatomic,retain) NSString *supportemail;
@property(nonatomic,retain) NSString *state;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *is_active;
@property(nonatomic,retain) NSString *bussinessId;
@property(nonatomic,retain) NSString *geocode;
@property(nonatomic,retain) NSString *fax;
@property(nonatomic,retain) NSString *ein;
@property(nonatomic,retain) NSString *country;
@property(nonatomic,retain) NSString *contactname;
@property(nonatomic,retain) NSString *contactemail;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *businesstype;
@property(nonatomic,retain) NSString *bizname;
@property(nonatomic,retain) NSString *address;

@end



