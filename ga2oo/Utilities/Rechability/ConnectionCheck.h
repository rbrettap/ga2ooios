//
//  ConnectionCheck.h
//  growwithme
//
//  Created by Fakhre Alam on 18/10/10.
//  Copyright 2010 WINIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>  
#import <netinet/in.h>  
#import <arpa/inet.h>  
#import <netdb.h>  

@interface ConnectionCheck : NSObject {

}
+ (BOOL) isConnected; 
@end
