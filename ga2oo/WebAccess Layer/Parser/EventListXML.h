#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"
#import "EventCategoryBO.h"
#import "EventImagesBO.h"

#define GetEventList 11
#define GetBydate 12
#define GetBycategory 13
#define GetBydate_Category 14
#define GetBycategory_dateBysortOption 15

@protocol EventListXML_Delegate;

@class EventListBO;

@interface EventListXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	EventListBO *currentObject;
    EventCategoryBO *currentEventCatObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
	NSString *strID;
    NSMutableArray *arrCats;
	NSInteger idCount;
	EventImagesBO *currentImageObj ;
	BOOL isEventImage;
	BOOL isFavId;
    
    NSInteger ModeType;
    
    NSString *Str_date;
    NSString *str_category;
    NSString *str_type;
    
}


@property(nonatomic, retain)EventCategoryBO *currentEventCatObject;

@property(nonatomic, retain) EventListBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;
@property(nonatomic, retain) NSString *strID;
@property(nonatomic, assign) NSInteger ModeType;
@property(nonatomic, retain) NSString *Str_date;
@property(nonatomic, retain) NSString *str_category;
@property(nonatomic, retain) NSString *str_type;

@end

@protocol EventListXML_Delegate<NSObject>

- (void)EventListXML_Error:(EventListXML*)parser encounteredError:(NSError *)error;
- (void)EventListXML_Finished:(NSMutableArray*)parser;

@end
