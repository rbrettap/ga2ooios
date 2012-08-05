//
//  EventMapViewController.h
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "ParkPlaceMark.h"
#import "EventsBO.h"
#import "EventLocationBO.h"
#import "BusinessListBO.h"
#import "EventListBO.h"


@interface EventMapViewController : BaseViewController<MKMapViewDelegate>{

	BusinessListBO *objEventLocation;
	EventLocationBO *objLoc;
	MKMapView *mapView;
	EventListBO *objEventListMap;
}
@property (nonatomic, retain)BusinessListBO *objEventLocation;
@property (nonatomic, retain)MKMapView *mapView;
@property (nonatomic, retain) EventLocationBO *objLoc;
@property (nonatomic, retain) EventListBO *objEventListMap;

@end
