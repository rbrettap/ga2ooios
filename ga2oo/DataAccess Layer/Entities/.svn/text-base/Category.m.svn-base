// 
//  Category.m
//  Ga2oo
//
//  Created by Mayank Goyal on 03/05/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "Category.h"


@implementation Category 

@dynamic maincategoryid;
@dynamic maincategoryname;
@dynamic date_updated;

+(NSString*)TableName
{
    return @"Category";
}

+(NSString*)PrimarykeyColumnName
{
    return @"maincategoryid";
}

-(void)CopyData:(BaseBusinessObject *)object
{
	CategoryBO *obj_ = (CategoryBO *)object;
	[self setMaincategoryid:obj_.maincategoryid];
	[self setMaincategoryname:obj_.maincategoryname];
	[self setDate_updated:obj_.date_updated];
}

@end
