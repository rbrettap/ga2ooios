// 
//  Business.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Business.h"


@implementation Business 

@dynamic CreatedBy;
@dynamic BusinessTypeId;
@dynamic ModifiedOn;
@dynamic FaxNumber;
@dynamic ModifiedBy;
@dynamic BusinessId;
@dynamic URL;
@dynamic ImageData;
@dynamic ContactEmail;
@dynamic BusinessName;
@dynamic CreatedOn;
@dynamic SupportEmail;
@dynamic PhoneNumber;
@dynamic Image;
@dynamic IsActive;
@dynamic EIN;
@dynamic External_biz_id;


+(NSString*)TableName
{
    return @"Business";
}

+(NSString*)PrimarykeyColumnName
{
    return @"BusinessId";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	BusinessBO *obj_ = (BusinessBO *)object;
	[self setCreatedBy:[NSNumber numberWithInt:obj_.CreatedBy]];
	[self setBusinessTypeId:[NSNumber numberWithInt:obj_.BusinessTypeId]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setFaxNumber:obj_.FaxNumber];
	[self setModifiedBy:[NSNumber numberWithInt:obj_.ModifiedBy]];
	[self setBusinessId:[NSNumber numberWithInt:obj_.BusinessId]];
	[self setURL:obj_.URL];
	[self setImageData:obj_.ImageData];
	[self setContactEmail:obj_.ContactEmail];
	[self setBusinessName:obj_.BusinessName];
	[self setCreatedOn:obj_.CreatedOn];
	[self setSupportEmail:obj_.SupportEmail];
	[self setPhoneNumber:obj_.PhoneNumber];
	[self setImage:obj_.Image];
	[self setIsActive:obj_.IsActive];
	[self setEIN:obj_.EIN];
	[self setExternal_biz_id:obj_.External_biz_id];
}

@end
