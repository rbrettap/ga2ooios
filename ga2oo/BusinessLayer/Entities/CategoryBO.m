//
//  CategoryBO.m
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import "CategoryBO.h"


@implementation CategoryBO

@synthesize maincategoryid;
@synthesize maincategoryname;
@synthesize date_updated;




-(void)CopyData:(BaseCoreDataObject *)object
{
	Category *obj_ = (Category *)object;
 	[self setMaincategoryid:obj_.maincategoryid];
	[self setMaincategoryname:obj_.maincategoryname];
	[self setDate_updated:obj_.date_updated];
}

-(void)dealloc
{
	[maincategoryid release];
	[maincategoryname release];
    [date_updated release];
	[super dealloc];
}

@end
