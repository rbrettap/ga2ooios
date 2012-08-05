





#import "ParkPlaceMark.h"

@implementation ParkPlaceMark

@synthesize coordinate, title, subtitle, tag;

- (NSString *)subtitle{
	return subtitle;
}

- (NSString *)title{
	return title;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate = c;
	
	return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)markTitle subtitle:(NSString *)markSubtitle{
	if(self = [super init]){
		coordinate=c;
		title = markTitle;
		if(subtitle!= nil)
			[subtitle release];
		subtitle = [[NSString alloc] initWithString:markSubtitle ];
		
		
	}
	return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)markTitle subtitle:(NSString *)markSubtitle image:(UIImage *)img
{
	if(self = [super init]){
		coordinate=c;
		title = markTitle;
		if(subtitle!= nil)
			[subtitle release];
		subtitle = [[NSString alloc] initWithString:markSubtitle ];
		
		
	}
	return self;
}

- (void) dealloc
{
	[title release];
	[subtitle release];
	[super dealloc];
}

@end
