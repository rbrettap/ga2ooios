//
//  ConnectionCheck.m
//  growwithme
//
//  Created by Fakhre Alam on 18/10/10.
//  Copyright 2010 WINIT. All rights reserved.
//

#import "ConnectionCheck.h"


@implementation ConnectionCheck

 + (BOOL) isConnected {  
     // Create zero addy  
     struct sockaddr_in zeroAddress;  
     bzero(&zeroAddress, sizeof(zeroAddress));  
     zeroAddress.sin_len = sizeof(zeroAddress);  
     zeroAddress.sin_family = AF_INET;  
     // Recover reachability flags  
     SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);  
     SCNetworkReachabilityFlags flags;  
     BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);  
     CFRelease(defaultRouteReachability);  
     if (!didRetrieveFlags) {  
         NSLog(@"Error. Could not recover network reachability flags");  
         return NO;  
     }  
     BOOL isReachable = flags & kSCNetworkFlagsReachable;  
     BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;  
     BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;  
     NSURL *testURL = [NSURL URLWithString:@"http://www.google.com/"];  
     NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];  
     NSURLConnection *testConnection = [[[NSURLConnection alloc] initWithRequest:testRequest delegate:self] autorelease];  
     return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;  
 } 

@end
