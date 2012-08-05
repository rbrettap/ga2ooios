//
//  PersonalCustonCell.m
//  Registration
//
//  Created by SaiKrishna on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalCustonCell.h"


@implementation PersonalCustonCell

@synthesize lbl1;
@synthesize txtField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {

		lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 128, 40)];
		lbl1.backgroundColor=[UIColor clearColor];
		lbl1.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 16.0];
		[self.contentView addSubview:lbl1];
				
		txtField=[[UITextField alloc]initWithFrame:CGRectMake(130, 10, 160, 20)];
		txtField.backgroundColor=[UIColor clearColor];
		txtField.font=[UIFont fontWithName:@"HelveticaNeue" size: 17.0];
		txtField.textColor=[UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0];
 		[txtField setBorderStyle:UITextBorderStyleNone];		
		[self.contentView addSubview:txtField];
	
	}
	return self;
}


-(void)dealloc
{
	[lbl1 release];
	[txtField release];
  	[super dealloc];
}


@end
