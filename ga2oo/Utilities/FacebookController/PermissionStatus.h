//
//  PermissionStatus.h


#import <Foundation/Foundation.h>
#import "FBRequest.h"

@protocol PermissionStatusDelegate;

@interface PermissionStatus : NSObject <FBRequestDelegate> {
	BOOL userHasPermission;
	id<PermissionStatusDelegate> delegate;
}

@property (nonatomic, assign) BOOL userHasPermission;
@property (nonatomic, retain) id<PermissionStatusDelegate> delegate;

- (PermissionStatus *)initWithUserId:(long long int)uid;

@end


#pragma mark method to call after response
@protocol PermissionStatusDelegate <NSObject>
- (void)statusWasSet:(BOOL)status;
@end
