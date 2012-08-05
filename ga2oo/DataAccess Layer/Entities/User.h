//
//  tblUser.h
//  Ga2oo
//NSString
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BaseCoreDataObject.h"
#import <Foundation/Foundation.h>
#import "UserBO.h"


@interface User :  BaseCoreDataObject  
{
}

@property (nonatomic, retain) NSString * Lastname;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * DeviceId;
@property (nonatomic, retain) NSString * IsCalenderShared;
@property (nonatomic, retain) NSString * UserId;
@property (nonatomic, retain) NSString * Invisiblemode;
@property (nonatomic, retain) NSString * Password;
@property (nonatomic, retain) NSDate * Birthday;
@property (nonatomic, retain) NSString * Zipcode;
@property (nonatomic, retain) NSString * Username;
@property (nonatomic, retain) NSString * IsPublic;
@property (nonatomic, retain) NSDate * CreatedOn;
@property (nonatomic, retain) NSString * Gender;
@property (nonatomic, retain) NSString * Firstname;
@property (nonatomic, retain) NSString * IsActive;
@property (nonatomic, retain) NSString * UserImage;
@property (nonatomic, retain) NSNumber * ModifiedBy;
@property (nonatomic, retain) NSNumber * CreatedBy;
@property (nonatomic, retain) NSDate * ModifiedOn;
@property (nonatomic, retain) NSData *userImageDate;



@end



