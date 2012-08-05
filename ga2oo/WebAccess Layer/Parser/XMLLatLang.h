//
//  XMLLatLang.h
//  MobileSurroundings
//
//  Created by narender on 3/3/10.
//  Copyright 2010 Winitsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserLocationBO.h"

@interface XMLLatLang : NSObject<NSXMLParserDelegate>
{
	NSMutableString *contentOfCurrentComment;
    UserLocationBO *location;
}

@property(nonatomic,retain) UserLocationBO *location;

@property(nonatomic,retain) NSMutableString *contentOfCurrentComment;

- (UserLocationBO*)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;

@end
