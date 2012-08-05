//
//  RegisterObject.h
//  Ga2oo
//
//  Created by Mayank Goyal on 16/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RegisterObject : NSObject {
	
	NSString *strFirstName;
	NSString *strLastName;
	NSString *strEmail;
	NSString *strUserName;
	NSString *strPaswd;
	NSString *strZip;
	NSString *strGender;
	NSString *strBirthDay;
	UIImage *imgImage;
	NSString *strBio;
	NSString *strCate;
	NSString *strLocation;
    
    
    NSString *geocode;
    NSString *address;
    NSString *city;
    NSString *state;
    NSString *zipcode;
    NSString *country;
    
}

@property(nonatomic, retain) NSString *strFirstName;
@property(nonatomic, retain) NSString *strLastName;
@property(nonatomic, retain) NSString *strEmail;
@property(nonatomic, retain) NSString *strUserName;
@property(nonatomic, retain) NSString *strPaswd;
@property(nonatomic, retain) NSString *strZip;
@property(nonatomic, retain) NSString *strGender;
@property(nonatomic, retain) NSString *strBirthDay;
@property(nonatomic, retain) UIImage *imgImage;
@property(nonatomic, retain) NSString *strBio;
@property(nonatomic, retain) NSString *strCate;
@property(nonatomic, retain) NSString *strLocation;

@property(nonatomic, retain) NSString *geocode;
@property(nonatomic, retain) NSString *address;
@property(nonatomic, retain) NSString *city;
@property(nonatomic, retain) NSString *state;
@property(nonatomic, retain) NSString *zipcode;
@property(nonatomic, retain) NSString *country;

@end
