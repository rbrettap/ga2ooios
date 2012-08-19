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
	NSString *UserId;
	NSString *UserMessage;
	NSString *Message;
	NSString *Code;
}
@property (nonatomic,retain) NSString * UserId;
@property (nonatomic,retain) NSString * UserMessage;
@property (nonatomic,retain) NSString * Message;
@property (nonatomic,retain) NSString * Code;
@end
