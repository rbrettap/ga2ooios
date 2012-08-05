//
//  BusinessDetailBO.h
//  Ga2oo
//
//  Created by WINIT on 27/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"


@interface BusinessDetailBO : BaseBusinessObject {
    
	NSString *businessid;
	NSString *businessname;
    NSString *Strcontactemail;
    NSString *Strcontactname;
	NSString *Strurl;
    NSString *Strsupportemail;
    NSString *Strphone;
    NSString *Strimage;
    
    
}

@property (nonatomic, retain) NSString *businessid;
@property (nonatomic, retain) NSString *businessname;
@property (nonatomic, retain) NSString *Strcontactemail;
@property (nonatomic, retain) NSString *Strcontactname;
@property (nonatomic, retain) NSString *Strurl;
@property (nonatomic, retain) NSString *Strsupportemail;
@property (nonatomic, retain) NSString *Strphone;
@property (nonatomic, retain) NSString *Strimage;


@end
