//
//  EventImagesBO.h
//  Ga2oo
//
//  Created by WINIT on 5/3/11.
//  Copyright 2011 WIN INFORMATION TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "EventImages.h"

@interface EventImagesBO : BaseBusinessObject {

 	NSString * imageUrl;
    NSString * eventId;
    NSString * isMain;
    UIImage * imgEvent;
        NSData * dataImgEvent;
 }


@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * eventId;
@property (nonatomic, retain) NSString * isMain;
@property (nonatomic, retain) UIImage * imgEvent;
@property (nonatomic, retain) NSData * dataImgEvent;


@end
