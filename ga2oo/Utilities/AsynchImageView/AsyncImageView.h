//
//  AsyncImageView.h
//  ImageLoading
//
//  Created by Hugo Wetterberg on 2009-08-06.
//  Copyright 2009 Hugo Wetterberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageLoader.h"
#import "AsyncImageLoaderDelegate.h"

@class AsyncImageView;
@protocol AsyncImageViewDelegate <NSObject>
@optional
- (void) didLoadImage:(UIImage*)anImage ImageView:(AsyncImageView*)imageView;
- (void) didFailWithError:(NSError*)error;
- (void) asyncImageLoaderTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event sender:(id) aSender;
@end

@interface AsyncImageView : UIImageView <AsyncImageLoaderDelegate> {
	id<AsyncImageViewDelegate> delegate;
    NSURL *imageUrl;
    BOOL loadNeeded;
    AsyncImageLoader *loader;
    UIActivityIndicatorView *activity;
}

@property(nonatomic, retain) id<AsyncImageViewDelegate> delegate;


- (void) loadImageIfNeeded;
- (void) setURL:(NSURL *)url;
- (void) imageFromUrl:(NSURL *)url;
- (void) loadImageFromURL:(NSURL*)url;
- (void) setShowActivity:(BOOL)showActivity;
- (void) setActivityStyle:(UIActivityIndicatorViewStyle)style;

@end
