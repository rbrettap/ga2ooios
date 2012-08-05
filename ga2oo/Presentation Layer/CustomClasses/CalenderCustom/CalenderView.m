//
//  CalenderView.m
//  Church
//
//  Created by vibhu on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


//#define calenderColor [UIColor colorWithRed:59/255.0 green:65/255.0 blue:74/255.0 alpha:1.0]
//#define calenderColor [UIColor colorWithRed:78/255.0 green:88/255.0 blue:99/255.0 alpha:1.0]

#import "CalenderView.h"
#import "EventListBO.h"
#import "EventDetailViewController.h"
#import "CalenderViewController.h"
#import "HttpRequest.h"
#import "GlobalConstant.h"
#import <quartzcore/QuartzCore.h>
#import "NewMyThread.h"


//320, 230
//     Sun         Mon         Tue         Wed         Thu          Fri           Sat
@implementation CalenderView

@synthesize arrCalenderEvents;
@synthesize dayButtonsArray;
@synthesize eventDatesArray;
@synthesize currentMonth;
@synthesize currentYear;
@synthesize currentFirstDay;
@synthesize currentLastDay;
@synthesize currentDayConstant;
@synthesize currentMonthConstant;
@synthesize currentYearConstant;

@synthesize currentMonth1;
@synthesize currentYear1;
@synthesize currentFirstDay1;
@synthesize currentLastDay1;
@synthesize currentDayConstant1;
@synthesize currentMonthConstant1;
@synthesize currentYearConstant1;

@synthesize delegate;
@synthesize calenderColor, dayBgColor;

@synthesize btn_Temp;
@synthesize strDate;
@synthesize TotalThreads;


-(void)setCalendar
{
	NSDate	*currentDate=[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:( NSWeekdayCalendarUnit | 
												   NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:currentDate];
	NSInteger weekdayInteger=[comps weekday];
	self.currentMonth=[comps month];	
	self.currentYear=[comps year];	
	NSString *dateString=[[NSString stringWithFormat:@"%@",currentDate] substringToIndex:10];
    NSArray *array= [dateString componentsSeparatedByString:@"-"];
	NSInteger currentDay=[[array objectAtIndex:2] intValue];
	
	
	imgButton = [UIImage imageNamed:@"calenderCellBg.png"];
    imgButton2 = [UIImage imageNamed:@"icon.png"];
    //PreimgButton = [UIImage imageNamed:@"icon.png"];
	
	currentMonthConstant=currentMonth;
	currentYearConstant=currentYear;
	currentDayConstant=currentDay;
	 
    currentFirstDay=((8+weekdayInteger-(currentDay%7))%7);
	if(currentFirstDay==0)
		currentFirstDay=7;
	[gregorian release];
}

- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
		
		appDelegate = (Ga2ooAppDelegate *)[[UIApplication sharedApplication]delegate];
		arrCalenderEvents = [[NSMutableArray alloc]init];
		[self setCalendar];
 
		self.calenderColor = [UIColor grayColor];
		self.dayBgColor = [UIColor colorWithRed:0.0/255.0 green:114.0/255.0 blue:226.0/255.0 alpha:1.0];
		
		TotalThreads = [[NSMutableArray alloc]init];
		
    	CGFloat orgx = 0, orgy = 0;
		self.dayButtonsArray = [[NSMutableArray alloc]init];
		for (int i=0; i<42; i++) {
		
			UIButton *button = [[UIButton alloc]init];
			button.userInteractionEnabled = NO;
            
            
			//button.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:162.0/255.0 blue:36.0/255.0 alpha:1.0];
			button.tag = i;
			[button addTarget:self action:@selector(dateSelected:) forControlEvents:(UIControlEventTouchDown|UIControlEventTouchDragInside|UIControlEventTouchDragEnter)];
			button.frame=CGRectMake(orgx, orgy, 46, 40);
			orgx += 46;
			if((i+1)%7==0)
			{
				orgy += 40;
				orgx = 0;
			}
			[self addSubview:button];
            
            UIImageView *buttonTopImg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,46,40)];
            buttonTopImg.backgroundColor = [UIColor clearColor];
            buttonTopImg.image = [UIImage imageNamed:@""];
            buttonTopImg.tag = 123456;
            [button addSubview:buttonTopImg];
            [buttonTopImg release];
           // [button release];
            
           /* UILabel *buttonDateLbl = [[UILabel alloc]initWithFrame:CGRectMake(0,0,46,40)];
            buttonDateLbl.backgroundColor = [UIColor clearColor];
            buttonDateLbl.text = @"";
            buttonDateLbl.tag = 1234567;
            buttonDateLbl.textAlignment = UITextAlignmentCenter;
            [buttonTopImg addSubview:buttonDateLbl];*/

            
			[self.dayButtonsArray addObject:button];
			[button release];
			
		}
		self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:162.0/255.0 blue:36.0/255.0 alpha:1.0];
        //self.backgroundColor  = [UIColor whiteColor];
    }
    return self;
}

-(void)dateSelected:(UIButton *)sender
{
 	//NSMutableArray *arrCalEvents = [[NSMutableArray alloc]init];
	//[arrCalEvents addObjectsFromArray:arrCalenderEvents];
    
    UIButton *tempBtn1 = nil;
	for(int i=0; i<[dayButtonsArray count]; i++)
	{
		
		tempBtn1 = [self.dayButtonsArray objectAtIndex:i];
        [tempBtn1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        UIImageView *btnTopImg = (UIImageView *)[tempBtn1 viewWithTag:123456];
        btnTopImg.image = [UIImage imageNamed:@""];
    }
 
		UIButton *btn = (UIButton *)sender;
    UIImageView *btnTopImg = (UIImageView *)[btn viewWithTag:123456];
    if ([btn currentBackgroundImage] != [UIImage imageNamed:@"calenderCellBg.png"])
    {
        btnTopImg.image = [UIImage imageNamed:@"datebg.png"];
    }
    else 
    {
        btnTopImg.image = [UIImage imageNamed:@"calender_cell_bg_hoveroutline.png"];
    }
    
     
    //[btn setImage:[UIImage imageNamed:@"datebg.png"] forState:UIControlStateNormal];
		
	/*	NSString *strTitle = btn.currentTitle;
		NSLog(@"[strTitle integerValue] %i", [strTitle integerValue]);
		if(![strTitle integerValue]==0)
		{
            NSLog(@"str_Prev value%@", str_Prev);
			if(![strTitle isEqualToString:str_Prev])
			{
				if ([self.btn_Temp currentBackgroundImage])
                {
                  
                    
                    
                      [self.btn_Temp setBackgroundImage:PreimgButton forState:UIControlStateNormal];
                    
                    if ([self.btn_Temp currentBackgroundImage] != [UIImage imageNamed:@"blueBg.png"])
                        {
                            UIImageView *TempImg = (UIImageView *)[self.btn_Temp viewWithTag:786];
                            if(TempImg)
                            {
                                
                            }
                            else 
                            {
                                [self.btn_Temp setBackgroundImage:[UIImage imageNamed:@"calenderCellBg.png"] forState:UIControlStateNormal];
                            }

                        }
                    
                    
				}
				else 
                {
				}
                
                
                if ([btn currentBackgroundImage])
                {
                    
                    PreimgButton = [btn currentBackgroundImage];
                    

                        [btn setBackgroundImage:[UIImage imageNamed:@"green_bg.png"] forState:UIControlStateNormal];

                    
                }
				
                
			}
			
			else {
 			}

				
			

			[appDelegate.selectedBtn removeFromSuperview];
			[appDelegate.selectedBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
			[sender addSubview:appDelegate.selectedBtn];
			
			
				self.btn_Temp = sender;
			str_Prev = strTitle;
			*/
    
			[(id)[self delegate] performSelectorOnMainThread:@selector(pushViewEventDetail:)withObject:[NSString stringWithFormat:@"%@",sender.currentTitle] waitUntilDone:NO];
		
 
	
	//[arrCalEvents release];
}

-(void) clearLabels
{
	UIButton *tempBtn1 = nil;
	for(int i=0; i<[dayButtonsArray count]; i++)
	{
		
		tempBtn1 = [self.dayButtonsArray objectAtIndex:i];

		
		for (UIView *vw in tempBtn1.subviews) {
			if (vw.tag == 786) {
				[vw removeFromSuperview];

			}
		}
		
		[tempBtn1 setTitle:@"" forState:UIControlStateNormal];
		[tempBtn1 setBackgroundColor:[UIColor clearColor]];

		tempBtn1.titleLabel.font = [UIFont boldSystemFontOfSize:20];
		[tempBtn1 setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
		[tempBtn1 setBackgroundImage:[UIImage imageNamed:@"calenderCellBg.png"] forState:UIControlStateNormal];
		[tempBtn1 setImage:nil forState:UIControlStateNormal];
		tempBtn1.userInteractionEnabled = NO;


	}	
}

-(NSInteger)getNumberofDays:(NSInteger)monthInt YearVlue:(NSInteger)yearInt
{
	BOOL isLeap=NO;
	if(((yearInt%400)==0)||(((yearInt%4)==0)&&((yearInt%100!=0))))
		isLeap=YES;
	
	switch (monthInt) {
		case 1:
			
			return 31;
		case 2:
			if(isLeap==YES)
				return 29;
			
			return 28;
		case 3:
			
			return 31;
		case 4:
			
			return 30;
		case 5:
			
			return 31;
		case 6:
			
			return 30;
		case 7:
			
			return 31;
		case 8:
			
			return 31;
		case 9:
			
			return 30;
		case 10:
			
			return 31;
		case 11:
			
			return 30;
		case 12:
			
			return 31;
	}
	return 0;
}

-(NSString *)getMonth:(NSInteger)month
{
	switch (month) 
	{
		case 1:
			
			return @"January";
		case 2:
			
			return @"February";
		case 3:
			
			return @"March";
		case 4:
			
			return @"April";
		case 5:
			
			return @"May";
		case 6:
			
			return @"June";
		case 7:
			
			return @"July";
		case 8:
			
			return @"August";
		case 9:
			
			return @"September";
		case 10:
			
			return @"October";
		case 11:
			
			return @"November";
		case 12:
 			return @"December";
	}
	return @"";
}

-(NSString *)fillCalender:(NSInteger)int_month weekStarts:(NSInteger)int_weekday year:(NSInteger)int_year withEvents:(NSMutableArray *)arrCalEvents
{
	
	
	[self clearLabels];
	
        
	//str_Prev = nil;
 	[arrCalEvents retain];
	[arrCalenderEvents removeAllObjects];
	[arrCalenderEvents addObjectsFromArray:arrCalEvents];
	
	//NSInteger intNoOfEvent = 0;
	self.currentMonth = int_month;
	self.currentYear = int_year;
	self.currentFirstDay = int_weekday;
    NSInteger PreMonth = int_month-1;
    NSInteger preyear = int_year;

	if(PreMonth==0)
	{
		PreMonth=12;
		preyear--;
	}
    NSInteger IsOver = 0;
	
	NSInteger numberOfDays=[self getNumberofDays:int_month YearVlue:int_year];
    NSInteger preNumberOfDays = [self getNumberofDays:PreMonth YearVlue:preyear];
    preNumberOfDays = preNumberOfDays+1;
    NSInteger StatispreNumberOfDays = [self getNumberofDays:PreMonth YearVlue:preyear];
    
	self.currentLastDay = (self.currentFirstDay+numberOfDays-1)%7;
	
	if(self.currentLastDay == 0)
		self.currentLastDay = 7;
	NSString *monthName=[self getMonth:int_month];
	NSInteger grid = (int_weekday-1);	
	NSString *strMonthYear = [[NSString alloc]initWithFormat:@"%@  %d", monthName, int_year];
	BOOL isCurrentDateAvailable = NO;
    int selectedbutton = 0;
    
    for(int j = grid ; j >=0; j--)
    {
        UIButton *tempBtn = nil;
        tempBtn = [self.dayButtonsArray objectAtIndex:j];
        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:[NSString stringWithFormat:@"%d",preNumberOfDays] forState:UIControlStateNormal];
        preNumberOfDays--;
        tempBtn.userInteractionEnabled = NO;

    }

 
	for(int i=1; i<=numberOfDays; i++)
	{
		//intNoOfEvent = 0;
		NSAutoreleasePool *pool = [ [NSAutoreleasePool alloc] init];
		UIButton *tempBtn = nil;
		tempBtn = [self.dayButtonsArray objectAtIndex:grid];

		self.strDate = [NSString stringWithFormat:@"%i", self.currentDayConstant];

		
		if(i == self.currentDayConstant && self.currentYear == self.currentYearConstant && self.currentMonth == self.currentMonthConstant)
		{
 			
			if (![arrCalEvents count]) {
  				tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
  				[tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 				[tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
				isCurrentDateAvailable = YES;
                selectedbutton = grid;
				
			}
			else
            {

				//for (int cout =0; cout<[arrCalEvents count]; cout++) 
               // {
					
				/*	NSString *date = [NSString stringWithFormat:@"%i/%i/%i",i,currentMonth,currentYear];
					NSDateFormatter* dtFormat = [[NSDateFormatter alloc] init];
					[dtFormat setDateFormat:dateFormatXML];
					NSDate *edate = [dtFormat dateFromString:date];
					[dtFormat setDateFormat:@"MM/dd/yyyy"];
					date = [dtFormat stringFromDate:edate];
					
					EventListBO *obj = [arrCalEvents objectAtIndex:cout];
					[dtFormat setDateFormat:@"yyyy-MM-dd"];
					NSDate *eventdate = [dtFormat dateFromString:obj.event_start_date];
					[dtFormat setDateFormat:@"MM/dd/yyyy"];
					
					NSString *strEventdate = [dtFormat stringFromDate:eventdate];
 					[dtFormat release];	*/			

               
					//NSRange Range = [strEventdate rangeOfString:date options:NSCaseInsensitiveSearch];
 					
 					
				
                NSString *TempMonth = [NSString stringWithFormat:@"%i",self.currentMonth];
                if([TempMonth length] == 1)
                {
                    TempMonth = [NSString stringWithFormat:@"0%i",self.currentMonth];
                }
                
                NSString *TempDate = [NSString stringWithFormat:@"%i",i];
                
                if(i < 10)
                {
                    TempDate = [NSString stringWithFormat:@"0%i",i];
                }
                
                NSString *strEventdate = [NSString stringWithFormat:@"%i-%@-%@",self.currentYear,TempMonth,TempDate];
						NSPredicate *pred = [NSPredicate predicateWithFormat:@"event_start_date == %@",strEventdate];
                        NSArray *arr = [arrCalEvents filteredArrayUsingPredicate:pred];
                        
                        
                        if ([arr count]) 
                        {
                            UIImageView *MessageCountView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,15,15)];
                            MessageCountView.backgroundColor = [UIColor clearColor];
                            MessageCountView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"alert_bg"] ofType:@"png"]];
                            MessageCountView.tag = 786;
                            [tempBtn addSubview:MessageCountView];
                            
                            
                            UILabel *MessageCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                            MessageCount.backgroundColor = [UIColor clearColor];
                            MessageCount.font = [UIFont systemFontOfSize:12];
                           // MessageCount.text =  [NSString stringWithFormat:@"%i",[arr count]];
                            MessageCount.text =  [NSString stringWithFormat:@"%i",i];
                            MessageCount.textAlignment = UITextAlignmentCenter;
                            [MessageCountView addSubview:MessageCount];
                            MessageCount.textColor = [UIColor whiteColor];
                            
                            NSString *strCount;
                            strCount= MessageCount.text;
                            CGSize labelStringSize_Count = [strCount sizeWithFont:[UIFont systemFontOfSize:12] 
                                                                constrainedToSize:CGSizeMake(30, 10) 
                                                                    lineBreakMode:MessageCount.lineBreakMode];
                            
                            if(labelStringSize_Count.width<20){
                                
                            }
                            else {
                                MessageCount.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);	
                                MessageCount.text= strCount;
                                MessageCountView.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);
                            }
                            
                            tempBtn.tag = 999;
                            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
                            [tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                            [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                            //[self ShowEventImage:tempBtn withImageName:[[arr objectAtIndex:0]EventImage]];
                            
                            NewMyThread *mythread = [[NewMyThread alloc]initWithData1:tempBtn andDay:i andMonth:self.currentMonth andYear:self.currentYear andmy:1 andImageNamer:[[arr objectAtIndex:0]EventImage] andEventImage:[[arr objectAtIndex:0]image]];
                            [mythread start];
							[TotalThreads addObject:mythread];
                            [mythread release];
							
							/*NSMutableArray *TemArray = [[NSMutableArray alloc]init];
							[TemArray addObject:tempBtn];
							[TemArray addObject:[arr objectAtIndex:0]];
							
							[NSThread detachNewThreadSelector:@selector(ShowEventImage:) toTarget:self withObject:TemArray];*/
							
							
                            
                            isCurrentDateAvailable = YES;
                            selectedbutton = grid;
                            
                            
                            [MessageCount release];
                            [MessageCountView release];
                        }
                        else {
                            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
                            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                            isCurrentDateAvailable = YES;
                            selectedbutton = grid;
                            
                        }
						
						

			

			}
			
	
			 [tempBtn addSubview:appDelegate.selectedBtn];
 			[tempBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			tempBtn.userInteractionEnabled = YES;
            

		}
		else 
		{	
			
 
			
				/*NSString *date = [NSString stringWithFormat:@"%i/%i/%i",i,currentMonth,currentYear];
				NSDateFormatter* dtFormat = [[NSDateFormatter alloc] init];
				[dtFormat setDateFormat:dateFormatXML];
				NSDate *edate = [dtFormat dateFromString:date];
				[dtFormat setDateFormat:@"MM/dd/yyyy"];
				date = [dtFormat stringFromDate:edate];
 				
 				EventListBO *obj = [arrCalEvents objectAtIndex:cout];
 				[dtFormat setDateFormat:@"yyyy-MM-dd"];
				NSDate *eventdate = [dtFormat dateFromString:obj.event_start_date];
 				[dtFormat setDateFormat:@"MM/dd/yyyy"];

				NSString *strEventdate = [dtFormat stringFromDate:eventdate];
				
				
				NSRange Range = [strEventdate rangeOfString:date options:NSCaseInsensitiveSearch];
				[dtFormat release];	*/			
 
				
			NSString *TempMonth = [NSString stringWithFormat:@"%i",self.currentMonth];
            if([TempMonth length] == 1)
            {
                TempMonth = [NSString stringWithFormat:@"0%i",self.currentMonth];
            }
            
            NSString *TempDate = [NSString stringWithFormat:@"%i",i];
            
            if(i < 10)
            {
                TempDate = [NSString stringWithFormat:@"0%i",i];
            }
					
              NSString *strEventdate = [NSString stringWithFormat:@"%i-%@-%@",self.currentYear,TempMonth,TempDate];
              NSPredicate *pred = [NSPredicate predicateWithFormat:@"event_start_date == %@",strEventdate];					NSArray *arr = [arrCalEvents filteredArrayUsingPredicate:pred];
 					
					
					if ([arr count]) 
                    {
						UIImageView *MessageCountView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,15,15)];
						MessageCountView.backgroundColor = [UIColor clearColor];
						MessageCountView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"alert_bg"] ofType:@"png"]];
						MessageCountView.tag = 786;
						[tempBtn addSubview:MessageCountView];

						
						UILabel *MessageCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
						MessageCount.backgroundColor = [UIColor clearColor];
						MessageCount.font = [UIFont systemFontOfSize:12];
						//MessageCount.text =  [NSString stringWithFormat:@"%i",[arr count]];
                         MessageCount.text =  [NSString stringWithFormat:@"%i",i];
						MessageCount.textAlignment = UITextAlignmentCenter;
 						[MessageCountView addSubview:MessageCount];
  						MessageCount.textColor = [UIColor whiteColor];
  						
 						NSString *strCount;
						strCount= MessageCount.text;
						CGSize labelStringSize_Count = [strCount sizeWithFont:[UIFont systemFontOfSize:12] 
															constrainedToSize:CGSizeMake(30, 10) 
																lineBreakMode:MessageCount.lineBreakMode];
						
						if(labelStringSize_Count.width<20){
 					 
						}
 						else {
							MessageCount.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);	
							MessageCount.text= strCount;
							MessageCountView.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);
						}
                        
                        tempBtn.tag = 999;
                        tempBtn.contentMode = UIViewContentModeBottom;
                        //[tempBtn setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
                        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                        [tempBtn setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                        
                        //[self ShowEventImage:tempBtn withImageName:[[arr objectAtIndex:0]EventImage]];
                        //[tempBtn setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                        
                        
                       NewMyThread *mythread = [[NewMyThread alloc]initWithData1:tempBtn andDay:i andMonth:self.currentMonth andYear:self.currentYear andmy:1 andImageNamer:[[arr objectAtIndex:0]EventImage] andEventImage:[[arr objectAtIndex:0]image]];
                        [mythread start];
						[TotalThreads addObject:mythread];
						[mythread release];
						
						
						/*NSMutableArray *TemArray = [[NSMutableArray alloc]init];
						[TemArray addObject:tempBtn];
						[TemArray addObject:[arr objectAtIndex:0]];
						
						[NSThread detachNewThreadSelector:@selector(ShowEventImage:) toTarget:self withObject:TemArray];*/
						

                        
                        [tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
					   
                        
                        [MessageCount release];
                        [MessageCountView release];

						
						
						
					 
					}
            
                    else {
                        
                       
                        [tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                        
                        [tempBtn setBackgroundImage:[UIImage imageNamed:@"calenderCellBg.png"] forState:UIControlStateNormal];
                        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                        [tempBtn setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                        
                    }
					
					
					 				
				
				
			
			
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			tempBtn.userInteractionEnabled = YES;

		}
		
		grid++;
		if(grid==42)
        {
            IsOver = 1;
			grid=0; 
        }
		
		[pool release];
		
		
	}
    
    if(StatispreNumberOfDays+numberOfDays-preNumberOfDays > 35)
    {
        NSLog(@"increase calender height");
        appDelegate.heightOfCalendarIncreased = 1;
    }
    else 
    {
       NSLog(@"decrease calender height");
        appDelegate.heightOfCalendarIncreased = 0;
    }
	
    [arrCalEvents release];
 	if(isCurrentDateAvailable == NO)
	{
		UIButton *sender = [self.dayButtonsArray objectAtIndex:(int_weekday-1)];
  		[sender addSubview:appDelegate.selectedBtn];

       
        str_Prev = @"40";
         PreimgButton = [sender currentBackgroundImage];
        //str_Prev = [NSString stringWithFormat:@"40"];
        //self.btn_Temp = sender;
        //[sender setBackgroundImage:[UIImage imageNamed:@"datebg.png"] forState:UIControlStateNormal];
        [self dateSelected:sender];
		[appDelegate.selectedBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
	}
	else 
    {
       
       UIButton *sender = [self.dayButtonsArray objectAtIndex:selectedbutton];
        [self dateSelected:sender];
    }
    if(!IsOver)
    {
        for(int k = 1 ;grid<42; k++)
        {
            UIButton *tempBtn = nil;
            tempBtn = [self.dayButtonsArray objectAtIndex:grid];
            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",k] forState:UIControlStateNormal];
            tempBtn.userInteractionEnabled = NO;
            grid++;
            
        }
    }
    
    [loaderView stopAnimating];
 
   
	return [strMonthYear autorelease];
}


-(void)ShowEventImage:(UIButton *)currentButton withImageName:(NSString *)imageName
{

    NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, imageName];
	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];

	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error){
			
            [currentButton setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
           
        }
		else
        {
            [currentButton setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
        }
			
		[imageData release];
		
	}
	else
	{
		[currentButton setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
	}

}


-(void)ShowEventImage:(NSMutableArray *)Temp
{
	
    NSError *error = nil;
	UIButton *currentButton = [Temp objectAtIndex:0];
	
	if([[Temp objectAtIndex:1] image])
	{
		[currentButton setBackgroundImage:[[Temp objectAtIndex:1] image] forState:UIControlStateNormal];
		
		

	}
    else if(![[Temp objectAtIndex:1] EventImage] || [[[Temp objectAtIndex:1] EventImage] isEqual:[NSNull null]])
    {
        [currentButton setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
    }
    
	else 
	{
	
		
		NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, [[Temp objectAtIndex:1] EventImage]];
		str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		str = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
		
		NSURL *url = [NSURL URLWithString:str];
		if(url)
		{
			NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
			if(!error){
				[currentButton setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
				
			}
			else
            {
				[currentButton setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
            }
			
			[imageData release];
			
		}
		else
		{
			[currentButton setBackgroundImage:[UIImage imageNamed:@"NoImageEvent.png"] forState:UIControlStateNormal];
		}
		
	}
	
	
	
}


- (void)drawRect:(CGRect)rect 
{
    // Drawing code
}


-(void)SelectedtoDat:(NSString *)Date
{
	NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
	[dtFormatter setDateFormat:@"yyyy-MM-dd"];
	
	NSDate	*currentDate=[dtFormatter dateFromString:Date];
    
    [dtFormatter release];
	
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:( NSWeekdayCalendarUnit | 
												   NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:currentDate];
	NSInteger weekdayInteger=[comps weekday];
	self.currentMonth1=[comps month];	
	self.currentYear1=[comps year];	
	NSString *dateString=[[NSString stringWithFormat:@"%@",currentDate] substringToIndex:10];
    NSArray *array= [dateString componentsSeparatedByString:@"-"];
	NSInteger currentDay=[[array objectAtIndex:2] intValue];
	
	
	currentMonthConstant1=currentMonth1;
	currentYearConstant1=currentYear1;
	currentDayConstant1=currentDay;
	
    currentFirstDay1=((8+weekdayInteger-(currentDay%7))%7);
	if(currentFirstDay1==0)
		currentFirstDay1=7;
	[gregorian release];
}

-(NSString *)fillCalendertoDate:(NSInteger)int_month weekStarts:(NSInteger)int_weekday year:(NSInteger)int_year SelectedDate:(NSInteger)int_Date withEvents:(NSMutableArray *)arrCalEvents
{
    
    [self clearLabels];
	
    
	//str_Prev = nil;
 	[arrCalEvents retain];
	[arrCalenderEvents removeAllObjects];
	[arrCalenderEvents addObjectsFromArray:arrCalEvents];
	
	NSInteger intNoOfEvent = 0;
	self.currentMonth = int_month;
	self.currentYear = int_year;
	self.currentFirstDay = int_weekday;
    NSInteger PreMonth = int_month-1;
    NSInteger preyear = int_year;
    
	if(PreMonth==0)
	{
		PreMonth=12;
		preyear--;
	}
    NSInteger IsOver = 0;
	
	NSInteger numberOfDays=[self getNumberofDays:int_month YearVlue:int_year];
    NSInteger preNumberOfDays = [self getNumberofDays:PreMonth YearVlue:preyear];
    preNumberOfDays = preNumberOfDays+1;
    
     NSInteger StatispreNumberOfDays = [self getNumberofDays:PreMonth YearVlue:preyear];
    
	self.currentLastDay = (self.currentFirstDay+numberOfDays-1)%7;
	
	if(self.currentLastDay == 0)
		self.currentLastDay = 7;
	NSString *monthName=[self getMonth:int_month];
	NSInteger grid = (int_weekday-1);	
	NSString *strMonthYear = [[NSString alloc]initWithFormat:@"%@  %d", monthName, int_year];
	BOOL isCurrentDateAvailable = NO;
    int selectedbutton = 0;
    
    for(int j = grid ; j >=0; j--)
    {
        UIButton *tempBtn = nil;
        tempBtn = [self.dayButtonsArray objectAtIndex:j];
        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:[NSString stringWithFormat:@"%d",preNumberOfDays] forState:UIControlStateNormal];
        preNumberOfDays--;
        tempBtn.userInteractionEnabled = NO;
        
    }
    
    
	for(int i=1; i<=numberOfDays; i++)
	{
		intNoOfEvent = 0;
		NSAutoreleasePool *pool = [ [NSAutoreleasePool alloc] init];
		UIButton *tempBtn = nil;
		tempBtn = [self.dayButtonsArray objectAtIndex:grid];
        
		self.strDate = [NSString stringWithFormat:@"%i", int_Date];
        
		
		if(i == int_Date && self.currentYear == int_year && self.currentMonth == int_month)
		{
 			
			if (![arrCalEvents count]) {
  				tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
  				[tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                if(i == self.currentDayConstant && self.currentYear == self.currentYearConstant && self.currentMonth == self.currentMonthConstant)
                {
 				  [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                }
				isCurrentDateAvailable = YES;
                selectedbutton = grid;
				
			}
			else
            {
                
				
					
					/*NSString *date = [NSString stringWithFormat:@"%i/%i/%i",i,currentMonth,currentYear];
					NSDateFormatter* dtFormat = [[NSDateFormatter alloc] init];
					[dtFormat setDateFormat:dateFormatXML];
					NSDate *edate = [dtFormat dateFromString:date];
					[dtFormat setDateFormat:@"MM/dd/yyyy"];
					date = [dtFormat stringFromDate:edate];
					
					EventListBO *obj = [arrCalEvents objectAtIndex:cout];
					[dtFormat setDateFormat:@"yyyy-MM-dd"];
					NSDate *eventdate = [dtFormat dateFromString:obj.event_start_date];
					[dtFormat setDateFormat:@"MM/dd/yyyy"];
					
					NSString *strEventdate = [dtFormat stringFromDate:eventdate];
 					[dtFormat release];				
                    
					NSRange Range = [strEventdate rangeOfString:date options:NSCaseInsensitiveSearch];
 					
 					
                    
                    
					
					if (Range.length== 10 ) 
					{*/
                
                NSString *TempMonth = [NSString stringWithFormat:@"%i",self.currentMonth];
                if([TempMonth length] == 1)
                {
                    TempMonth = [NSString stringWithFormat:@"0%i",self.currentMonth];
                }
                
                NSString *TempDate = [NSString stringWithFormat:@"%i",i];
                
                if(i < 10)
                {
                    TempDate = [NSString stringWithFormat:@"0%i",i];
                }

                NSString *strEventdate = [NSString stringWithFormat:@"%i-%@-%@",self.currentYear,TempMonth,TempDate];

                        
						NSPredicate *pred = [NSPredicate predicateWithFormat:@"event_start_date == %@",strEventdate];
                        NSArray *arr = [arrCalEvents filteredArrayUsingPredicate:pred];
                        
                        
                        if ([arr count]) 
                        {
                            UIImageView *MessageCountView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,15,15)];
                            MessageCountView.backgroundColor = [UIColor clearColor];
                            MessageCountView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"alert_bg"] ofType:@"png"]];
                            MessageCountView.tag = 786;
                            [tempBtn addSubview:MessageCountView];
                            
                            
                            UILabel *MessageCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                            MessageCount.backgroundColor = [UIColor clearColor];
                            MessageCount.font = [UIFont systemFontOfSize:12];
                            //MessageCount.text =  [NSString stringWithFormat:@"%i",[arr count]];
                             MessageCount.text =  [NSString stringWithFormat:@"%i",i];
                            MessageCount.textAlignment = UITextAlignmentCenter;
                            [MessageCountView addSubview:MessageCount];
                            MessageCount.textColor = [UIColor whiteColor];
                            
                            NSString *strCount;
                            strCount= MessageCount.text;
                            CGSize labelStringSize_Count = [strCount sizeWithFont:[UIFont systemFontOfSize:12] 
                                                                constrainedToSize:CGSizeMake(30, 10) 
                                                                    lineBreakMode:MessageCount.lineBreakMode];
                            
                            if(labelStringSize_Count.width<20){
                                
                            }
                            else {
                                MessageCount.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);	
                                MessageCount.text= strCount;
                                MessageCountView.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);
                            }
                            
                            tempBtn.tag = 999;
                            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
                            [tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                            [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                            //[self ShowEventImage:tempBtn withImageName:[[arr objectAtIndex:0]EventImage]];
                            
                           NewMyThread *mythread = [[NewMyThread alloc]initWithData1:tempBtn andDay:i andMonth:self.currentMonth andYear:self.currentYear andmy:1 andImageNamer:[[arr objectAtIndex:0]EventImage] andEventImage:[[arr objectAtIndex:0]image]];
                            [mythread start];
                            [mythread release];
                            
                          /*  NSMutableArray *TemArray = [[NSMutableArray alloc]init];
                            [TemArray addObject:tempBtn];
                            [TemArray addObject:[arr objectAtIndex:0]];
                            
                            [NSThread detachNewThreadSelector:@selector(ShowEventImage:) toTarget:self withObject:TemArray];*/
                            
                            
                            isCurrentDateAvailable = YES;
                            selectedbutton = grid;
                            [MessageCount release];
                            [MessageCountView release];
                            
                    
						
                    }
					else {
						tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
						[tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                        if(i == self.currentDayConstant && self.currentYear == self.currentYearConstant && self.currentMonth == self.currentMonthConstant)
                        {
 						 [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                        }
 						isCurrentDateAvailable = YES;
                        selectedbutton = grid;
                        
					}
					
				
				
                
                
			}
			
            
            [tempBtn addSubview:appDelegate.selectedBtn];
 			[tempBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			tempBtn.userInteractionEnabled = YES;
            
            
		}
		else 
		{	
			
            
			
				/*NSString *date = [NSString stringWithFormat:@"%i/%i/%i",i,currentMonth,currentYear];
				NSDateFormatter* dtFormat = [[NSDateFormatter alloc] init];
				[dtFormat setDateFormat:dateFormatXML];
				NSDate *edate = [dtFormat dateFromString:date];
				[dtFormat setDateFormat:@"MM/dd/yyyy"];
				date = [dtFormat stringFromDate:edate];
 				
 				EventListBO *obj = [arrCalEvents objectAtIndex:cout];
 				[dtFormat setDateFormat:@"yyyy-MM-dd"];
				NSDate *eventdate = [dtFormat dateFromString:obj.event_start_date];
 				[dtFormat setDateFormat:@"MM/dd/yyyy"];
                
				NSString *strEventdate = [dtFormat stringFromDate:eventdate];
				
				
				NSRange Range = [strEventdate rangeOfString:date options:NSCaseInsensitiveSearch];
				[dtFormat release];				
                
				if (Range.length==10 )
                {*/
            
            NSString *TempMonth = [NSString stringWithFormat:@"%i",self.currentMonth];
            if([TempMonth length] == 1)
            {
                TempMonth = [NSString stringWithFormat:@"0%i",self.currentMonth];
            }
            
            NSString *TempDate = [NSString stringWithFormat:@"%i",i];
            
            if(i < 10)
            {
                TempDate = [NSString stringWithFormat:@"0%i",i];
            }
            
            NSString *strEventdate = [NSString stringWithFormat:@"%i-%@-%@",self.currentYear,TempMonth,TempDate];
            
					
					
					NSPredicate *pred = [NSPredicate predicateWithFormat:@"event_start_date == %@",strEventdate];
					NSArray *arr = [arrCalEvents filteredArrayUsingPredicate:pred];
 					
					
					if ([arr count]) {
						UIImageView *MessageCountView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,15,15)];
						MessageCountView.backgroundColor = [UIColor clearColor];
						MessageCountView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"alert_bg"] ofType:@"png"]];
						MessageCountView.tag = 786;
						[tempBtn addSubview:MessageCountView];
                        
						
						UILabel *MessageCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
						MessageCount.backgroundColor = [UIColor clearColor];
						MessageCount.font = [UIFont systemFontOfSize:12];
						//MessageCount.text =  [NSString stringWithFormat:@"%i",[arr count]];
                         MessageCount.text =  [NSString stringWithFormat:@"%i",i];
						MessageCount.textAlignment = UITextAlignmentCenter;
 						[MessageCountView addSubview:MessageCount];
  						MessageCount.textColor = [UIColor whiteColor];
  						
 						NSString *strCount;
						strCount= MessageCount.text;
						CGSize labelStringSize_Count = [strCount sizeWithFont:[UIFont systemFontOfSize:12] 
															constrainedToSize:CGSizeMake(30, 10) 
																lineBreakMode:MessageCount.lineBreakMode];
						
						if(labelStringSize_Count.width<20){
                            
						}
 						else {
							MessageCount.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);	
							MessageCount.text= strCount;
							MessageCountView.frame=CGRectMake(0, 0, labelStringSize_Count.width, labelStringSize_Count.height);
						}
						
						
                        tempBtn.tag = 999;
                        tempBtn.contentMode = UIViewContentModeBottom;
                        //[tempBtn setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
                        tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                        [tempBtn setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                        
                        //[self ShowEventImage:tempBtn withImageName:[[arr objectAtIndex:0]EventImage]];
                        //[tempBtn setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                        
                        
                        NewMyThread *mythread = [[NewMyThread alloc]initWithData1:tempBtn andDay:i andMonth:self.currentMonth andYear:self.currentYear andmy:1 andImageNamer:[[arr objectAtIndex:0]EventImage] andEventImage:[[arr objectAtIndex:0]image]];
                        [mythread start];
						[mythread release];
                        
                      /*  NSMutableArray *TemArray = [[NSMutableArray alloc]init];
						[TemArray addObject:tempBtn];
						[TemArray addObject:[arr objectAtIndex:0]];
						
						[NSThread detachNewThreadSelector:@selector(ShowEventImage:) toTarget:self withObject:TemArray];*/
                        
                        
                        [tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];

						[MessageCount release];
                        [MessageCountView release];
                        
					}
					
					
                
				else {
                    
                   
 					[tempBtn setTitleColor:calenderColor forState:UIControlStateNormal];
                    
                    if(i == self.currentDayConstant && self.currentYear == self.currentYearConstant && self.currentMonth == self.currentMonthConstant)
                    {
                        [tempBtn setBackgroundImage:[UIImage imageNamed:@"blueBg.png"] forState:UIControlStateNormal];
                    }
                    else
                    {
                    [tempBtn setBackgroundImage:[UIImage imageNamed:@"calenderCellBg.png"] forState:UIControlStateNormal];
                    }
 					tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
					[tempBtn setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                    
				}
				
			
			
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			tempBtn.userInteractionEnabled = YES;
            
		}
		
		grid++;
		if(grid==42)
        {
            IsOver = 1;
			grid=0; 
        }
		
		[pool release];
		
		
	}
    
    if(StatispreNumberOfDays+numberOfDays-preNumberOfDays > 35)
    {
        NSLog(@"increase calender height");
        appDelegate.heightOfCalendarIncreased = 1;
    }
    else 
    {
        NSLog(@"decrease calender height");
        appDelegate.heightOfCalendarIncreased = 0;
    }

	
    [arrCalEvents release];
 	if(isCurrentDateAvailable == NO)
	{
		UIButton *sender = [self.dayButtonsArray objectAtIndex:(int_weekday-1)];
  		[sender addSubview:appDelegate.selectedBtn];
        
       
        str_Prev = @"40";
        PreimgButton = [sender currentBackgroundImage];
        //str_Prev = [NSString stringWithFormat:@"40"];
        //self.btn_Temp = sender;
        //[sender setBackgroundImage:[UIImage imageNamed:@"green_bg.png"] forState:UIControlStateNormal];
        [self dateSelected:sender];
		[appDelegate.selectedBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
	}
	else 
    {
       
        UIButton *sender = [self.dayButtonsArray objectAtIndex:selectedbutton];
        [self dateSelected:sender];
    }
    if(!IsOver)
    {
        for(int k = 1 ;grid<42; k++)
        {
            UIButton *tempBtn = nil;
            tempBtn = [self.dayButtonsArray objectAtIndex:grid];
            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",k] forState:UIControlStateNormal];
            tempBtn.userInteractionEnabled = NO;
            grid++;
            
        }
    }
    
    [loaderView stopAnimating];
    
    
	return [strMonthYear autorelease];
	
}


#pragma mark -


- (void)dealloc {
	[dayBgColor release];
	[calenderColor release];
	self.delegate = nil;
	[eventDatesArray release];
	[dayButtonsArray release];
    [super dealloc];
}


@end
