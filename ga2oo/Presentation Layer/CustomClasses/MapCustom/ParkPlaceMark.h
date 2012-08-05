#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ParkPlaceMark : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *subtitle;
	NSString *title;
	NSInteger tag;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSString *subtitle;
@property(nonatomic, retain) NSString *title;
@property(nonatomic) NSInteger tag;


- (id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)markTitle subtitle:(NSString *)markSubtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)markTitle subtitle:(NSString *)markSubtitle image:(UIImage *)img;


@end
