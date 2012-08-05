//
//  DDAnnotation.h
//  MapKitDragAndDrop
//
//  Created by digdog on 7/24/09.
//  Copyright 2009 Ching-Lan 'digdog' HUANG and digdog software.


#import <MapKit/MapKit.h>

@interface DDAnnotation : MKPlacemark {	
	
@private
	CLLocationCoordinate2D			_coordinate;
	NSString *						_title;
	NSString *						_subtitle;
}

@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate addressDictionary:(NSDictionary *)newAddressDictionary;
@end
