//
//  HttpRequest.h
//  Plants411
//
//  Created by WINIT on 25/06/10.
//  Copyright 2010 WINIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebResponse.h"

@protocol HttpDelegate;

@interface HttpRequest : NSObject 
{
	NSMutableData *data;
	id _delegate;
	NSInteger _tag;
	NSString *_moduleName;
}

@property(nonatomic, retain) NSData *data;
@property(nonatomic, retain) id _delegate;
@property(nonatomic) NSInteger _tag;
@property (nonatomic, retain) NSString *_moduleName;

-(void)PostRequest:(NSString *)url PostData:(NSDictionary *)myPostDictionary Delegate:(id)delegate Tag:(NSInteger)tag;
-(void)PostRequestToDelete:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag;
-(void)GetRequest:(NSString *)url Delegate:(id)delegate Tag:(NSInteger)tag ModuleName:(NSString *)moduleName;
-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData;
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)connectionDidFinishLoading:(NSURLConnection*)connection ;
-(void)UpdateCaller:(id)responseData isError:(BOOL)isError;

+ (NSString *)flattenHTML:(NSString *)html;

//-(NSString *)uploadLiveMediaToServer:(UIImage *)image MediaType:(NSString *) mediaType UserId:(NSString *)userid Delegate:(id)delegate Tag:(NSInteger)tag;
//-(NSString *)uploadMediaToServer:(NSData *)imageData MediaType:(NSString *) mediaType UserId:(NSString *)userid Delegate:(id)delegate Tag:(NSInteger)tag;

@end

@protocol HttpDelegate <NSObject>

- (void)httpResponseReceived:(WebResponse *)response;

@end