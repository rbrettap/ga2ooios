#import <Foundation/Foundation.h>
#import "SaxXMLParser.h"
#import "Ga2ooAppDelegate.h"

@protocol FavoriteBusinessXML_Delegate;

@class FavoriteBusinessBO;

@interface FavoriteBusinessXML : SaxXMLParser
{
	Ga2ooAppDelegate *appDelegate;
	FavoriteBusinessBO *currentObject;
	NSMutableArray *arrData;
	NSMutableString *currentValue;
	NSMutableString	*_currentParentElement;
}

@property(nonatomic, retain) FavoriteBusinessBO *currentObject;
@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSMutableString *currentValue;
@property(nonatomic, retain) NSMutableString *_currentParentElement;

@end

@protocol FavoriteBusinessXML_Delegate<NSObject>

- (void)FavoriteBusinessXML_Error:(FavoriteBusinessXML*)parser encounteredError:(NSError *)error;
- (void)FavoriteBusinessXML_Finished:(NSMutableArray*)parser;

@end
