//
//  BusinessListBO.h
//  Ga2oo
//
//  Created by Mayank goyal on 14/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "BusinessList.h"

@interface BusinessListBO : BaseBusinessObject {
	NSString *bussinessId;
	NSString *bizname;
	NSString *businesstype;
	NSString *contactemail;
	NSString *contactname;
	NSString *url;//
	NSString *ein;
	NSString *supportemail;//
	NSString *phone;
	NSString *fax;
	NSString *is_active;
	NSString *geocode;
	NSString *address;
	NSString *city;
	NSString *state;
 	NSString *zipcode;//
  	NSString *country;
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
