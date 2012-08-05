//
//  CategoryBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "Category.h"

@interface CategoryBO : BaseBusinessObject {

	NSString * maincategoryid;
    NSString * maincategoryname;
    NSString * date_updated;
}
@property(nonatomic,retain)NSString * maincategoryid;
@property(nonatomic,retain)NSString * maincategoryname;
@property(nonatomic,retain)NSString * date_updated;

@end
