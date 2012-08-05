//
//  AuthenticateUserBO.h
//  Ga2oo
//
//  Created by Fakhre Alam on 30/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"

@interface AuthenticateUserBO : BaseBusinessObject {
	NSString *Response;
	NSString * UserId;
}
@property (nonatomic,retain) NSString * UserId;
@property (nonatomic,retain) NSString *Response;
@end
