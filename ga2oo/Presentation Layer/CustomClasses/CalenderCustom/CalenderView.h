//
//  CalenderView.h
//  Church
//
//  Created by vibhu on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Ga2ooAppDelegate.h"
#import "EventListBO.h"
#import "WebserConsts.h"

@protocol CalenderEventsDelegate;

@interface CalenderView : UIView {

	Ga2ooAppDelegate *appDelegate;
	id<CalenderEventsDelegate> delegate;
	NSMutableArray *dayButtonsArray;
	NSMutableArray *eventDatesArray;
	NSMutableArray *TotalThreads;
	
	NSInteger currentMonth;
	NSInteger currentYear;
	NSInteger currentFirstDay;
	NSInteger currentLastDay;
	
	NSInteger currentDayConstant;
	NSInteger currentMonthConstant;
	NSInteger currentYearConstant;
	
	
	NSInteger currentMonth1;
	NSInteger currentYear1;
	NSInteger currentFirstDay1;
	NSInteger currentLastDay1;
	
	NSInteger currentDayConstant1;
	NSInteger currentMonthConstant1;
	NSInteger currentYearConstant1;
	
	UIColor *calenderColor;
	UIColor *dayBgColor;
	
	UIButton *btn_Temp;
	NSString *strDate;
	
	NSString *str_Prev;
	UIImage *imgButton;
    UIImage *imgButton2;
		UIImage *PreimgButton;
		
	UIActivityIndicatorView *loaderView;
	NSMutableArray *arrCalenderEvents;
	
}
@property (nonatomic, retain) 	NSMutableArray *arrCalenderEvents;
@property(nonatomic,assign) id<CalenderEventsDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *dayButtonsArray;
@property (nonatomic, retain) NSMutableArray *eventDatesArray;
@property (nonatomic, retain) NSMutableArray *TotalThreads;
@property (nonatomic) NSInteger currentMonth;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentFirstDay;
@property (nonatomic) NSInteger currentLastDay;
@property (nonatomic) NSInteger currentDayConstant;
@property (nonatomic) NSInteger currentMonthConstant;
@property (nonatomic) NSInteger currentYearConstant;


@property (nonatomic) NSInteger currentMonth1;
@property (nonatomic) NSInteger currentYear1;
@property (nonatomic) NSInteger currentFirstDay1;
@property (nonatomic) NSInteger currentLastDay1;

@property (nonatomic) NSInteger currentDayConstant1;
@property (nonatomic) NSInteger currentMonthConstant1;
@property (nonatomic) NSInteger currentYearConstant1;

@property (nonatomic, retain) UIColor *calenderColor;
@property (nonatomic, retain) UIColor *dayBgColor;

@property (nonatomic, retain) UIButton *btn_Temp;
@property (nonatomic, retain) NSString *strDate;

-(NSString *)fillCalender:(NSInteger)int_month weekStarts:(NSInteger)int_weekday year:(NSInteger)int_year;
-(NSString *)fillCalender:(NSInteger)int_month weekStarts:(NSInteger)int_weekday year:(NSInteger)int_year withEvents:(NSMutableArray *)arrCalEvents;

-(NSInteger)getNumberofDays:(NSInteger)monthInt YearVlue:(NSInteger)yearInt;
//-(NSString *)getMonth:(NSInteger)month;

@end


@protocol CalenderEventsDelegate <NSObject>

-(void) pushViewEventDetail:(NSString *)selectedDay;

@end

