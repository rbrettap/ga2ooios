//
//  BusinessBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "BusinessBO.h"


@implementation BusinessBO

@synthesize CreatedBy;
@synthesize BusinessTypeId;
@synthesize ModifiedOn;
@synthesize FaxNumber;
@synthesize ModifiedBy;
@synthesize BusinessId;
@synthesize URL;
@synthesize ImageData;
@synthesize ContactEmail;
@synthesize BusinessName;
@synthesize CreatedOn;
@synthesize SupportEmail;
@synthesize PhoneNumber;
@synthesize Image;
@synthesize IsActive;
@synthesize EIN;
@synthesize External_biz_id;


-(void)CopyData:(BaseCoreDataObject *)object
{
	Business *obj_ = (Business *)object;
	[self setCreatedBy:[obj_.CreatedBy integerValue]];
	[self setBusinessTypeId:[obj_.BusinessTypeId integerValue]];
	[self setModifiedOn:obj_.ModifiedOn];
	[self setFaxNumber:obj_.FaxNumber];
	[self setModifiedBy:[obj_.ModifiedBy integerValue]];
	[self setBusinessId:[obj_.BusinessId integerValue]];
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

-(void)dealloc
{
	[ModifiedOn release];
	[FaxNumber release];
	[URL release];
	[ImageData release];
	[ContactEmail release];
	[BusinessName release];
	[CreatedOn release];
	[SupportEmail release];
	[PhoneNumber release];
	[Image release];
	[IsActive release];
	[EIN release];
	[External_biz_id release];
	[super dealloc];
}

@end