//
//  RecommendationCell.m
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecommendationCell.h"


@implementation RecommendationCell
@synthesize lblFromName;
@synthesize lblSubject;
@synthesize lblMessage;
@synthesize imgSep;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        lblFromName = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 225, 25)];
		lblFromName.backgroundColor = [UIColor clearColor];
		lblFromName.font = [UIFont boldSystemFontOfSize:16];
		lblFromName.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
		[self.contentView addSubview:lblFromName];
		[lblFromName release];
		
		lblSubject = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 225, 20)];
		lblSubject.backgroundColor = [UIColor clearColor];
		lblSubject.font = [UIFont boldSystemFontOfSize:11];
		lblSubject.textColor = [UIColor colorWithRed:131.0/255.0 green:179.0/255.0 blue:197.0/255.0 alpha:1.0];
		[self.contentView addSubview:lblSubject];
		[lblSubject release];
        
        
        lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 305, 45)];
		lblMessage.backgroundColor = [UIColor clearColor];
        lblMessage.numberOfLines = 2;
		lblMessage.font = [UIFont boldSystemFontOfSize:11];
		lblMessage.textColor = [UIColor colorWithRed:131.0/255.0 green:179.0/255.0 blue:197.0/255.0 alpha:1.0];
		[self.contentView addSubview:lblMessage];
		[lblMessage release];
        
        imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(13, 98, 293, 2)];
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
		imgSep.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:imgSep];
		[imgSep release];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [imgSep release];
    [lblFromName release];
    [lblSubject release];
    [lblMessage release];
    [super dealloc];
}

@end
