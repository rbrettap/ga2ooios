//
//  RecommendationCell.h
//  Ga2oo
//
//  Created by Fahad on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommendationCell : UITableViewCell {
    
    UILabel *lblFromName;
	UILabel *lblSubject;
    UILabel *lblMessage;
    UIImageView *imgSep;
}

@property (nonatomic, retain) UILabel *lblFromName;
@property (nonatomic, retain) UILabel *lblSubject;
@property (nonatomic, retain) UILabel *lblMessage;
@property (nonatomic, retain)  UIImageView *imgSep;

@end
