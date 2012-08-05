//
//  EventObject.h
//  Ga2oo
//
//  Created by win it on 2/10/11.
//  Copyright 2011 WINITSOFTWARE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventObject : NSObject {
	NSInteger intID;
	NSString *strTitle;
 	NSString *strDetail;
 	NSString *strImage;;
 	NSString *strDate;
		NSString *strDate1;
 	NSString *strTime;
 	NSString *strAddress;
 	NSString *strDuration;
	NSString *strRating;
	NSString *strCategory;
	NSString *strZip;
	NSString *strCity;
	NSString *strState;
	NSString *strLongitude;
	NSString *strLatitude;
	NSString *strBuyTickets;
	NSInteger intRate;
	BOOL isFav;
	NSString *strOrganization;
	NSInteger intOrganisationID;
	
	BOOL isFavOrganisation;
}
@property(nonatomic)NSInteger intRate;
@property(nonatomic)NSInteger intID;
@property(nonatomic,retain)NSString *strTitle;
@property(nonatomic,retain)NSString *strDetail;
@property(nonatomic,retain)NSString *strImage;;
@property(nonatomic,retain)NSString *strDate;
@property(nonatomic,retain)NSString *strDate1;
@property(nonatomic,retain)NSString *strTime;
@property(nonatomic,retain)NSString *strAddress;
@property(nonatomic,retain)NSString *strDuration;
@property(nonatomic,retain)NSString *strRating;
@property(nonatomic,retain)NSString *strCategory;
@property(nonatomic,retain)NSString *strZip;
@property(nonatomic,retain)NSString *strCity;
@property(nonatomic,retain)NSString *strState;
@property(nonatomic,retain)NSString *strLongitude;
@property(nonatomic,retain)NSString *strLatitude;
@property(nonatomic,retain)NSString *strBuyTickets;
@property(nonatomic)BOOL isFav;
@property(nonatomic, retain) NSString *strOrganization;
@property(nonatomic) NSInteger intOrganisationID;
@property (nonatomic) BOOL isFavOrganisation;


@end
