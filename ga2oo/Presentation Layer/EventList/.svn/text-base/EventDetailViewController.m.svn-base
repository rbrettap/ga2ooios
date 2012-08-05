//
//  EventDetailViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 14/02/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "EventDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EventMapViewController.h"
#import "UserBO.h"
#import "FriendDetailViewController.h"
#import "eventListViewController.h"
#import "EventsBO.h"
#import "HttpRequest.h"
#import "GlobalConstant.h"
#import "FriendTableCell.h"
#import "EventLocationBO.h"
#import "EventImagesBL.h"
#import "AsyncImageView.h"


#import "TicketWebViewController.h"
#import "BusinessCalenderViewController.h"


static int imgIndex=0;
@implementation EventDetailViewController
@synthesize objEvent;
@synthesize scroll_LargeImage;;
@synthesize arrLocation;
@synthesize intEventID;
@synthesize strUserID;
@synthesize arrEventFriend;
@synthesize intBusiessID;
@synthesize objEventList;
@synthesize objEventLoc;
@synthesize arrEventAttendingFriends;
@synthesize IsEventToDelete;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.arrEventFriend = [[NSMutableArray alloc] init];
	pageViews = [[NSMutableArray alloc] init];
	BigImagePath=[[NSMutableArray alloc]init];
 	arrEventAttendingFriends = [[NSMutableArray alloc] init];
    arrFriendEmails = [[NSMutableArray alloc] init];

    UserFavBussLayer = [[FavoriteBusinessBL alloc]init];
	UserFavBussLayer.delegate = self;
    
     /////////////////////////  get event friends   //////////
      NSString *strUsers = objEventList.UserID;
    NSArray *arr = [strUsers componentsSeparatedByString:@","];		
    FriendsBL *friendbl = [[FriendsBL alloc]init];
    for (int i=0; i<[arr count]; i++) {
        NSString *fUser = [arr objectAtIndex:i];
        
        
        if ([fUser length] && ![fUser isEqualToString:appDelegate.currentUserID]) {
              FriendsBO *oneFriend = (FriendsBO *)[friendbl SelectByKey:fUser withMode:YES];
             if (oneFriend!=nil)
             {
                [arrEventAttendingFriends addObject:oneFriend];
            }
            oneFriend = nil;
            
        }
    }
    [friendbl release];
     /////////////////////////
 
	
	businessLayer = [[BusinessListBL alloc]init];
	businessLayer.delegate = self;
	
	EventLocLayer = [[EventLocationBL alloc]init];
	EventLocLayer.delegate = self;

	EventFriendLayer = [[EventFriendListBL alloc]init];
	EventFriendLayer.delegate = self;

	EventLayer = [[EventsBL alloc]init];
	EventLayer.delegate = self;
	
    
    objEvent = (EventsBO *)[EventLayer SelectByKey:[NSString stringWithFormat:@"%@",objEventList.Eventid] withMode:YES];
    if (objEvent) {
        [self createInteface];
    }
    else{
        [self loadAnimation];

        [EventLayer LoadEvents:objEventList.Eventid];

    }
   // self.title = @"Event Details";
    [self setTopBarImageToEventDetailView:self.view];


    
  
 
	isFirst = NO;
	
	UILabel *lblHead = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 188, 45)];
	lblHead.text = @"Event Details";
	lblHead.textAlignment = UITextAlignmentCenter;
	lblHead.backgroundColor = [UIColor clearColor];
	lblHead.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
	lblHead.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
	[self.view addSubview:lblHead];
	[lblHead release];
	
	UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
	btnBack.frame = CGRectMake(5, 7, 51, 30);
	[btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back_btnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnBack];
	
 }

-(void)viewWillAppear:(BOOL)animated{
	
	[self removeFriendsView];
    //[self removeScrollView];
}
-(void)EventsLoadingCompleted
{
    [self removeSyncLoader];
    objEvent = (EventsBO *)[EventLayer SelectByKey:[NSString stringWithFormat:@"%@",objEventList.Eventid] withMode:YES];
    if (objEvent) {
        [self createInteface];
    }
    else{
         
        
    }

    
}

  


-(void)createInteface
{
	CGSize maximumSize = CGSizeMake(300, 9999);
	int yRef = 5;
	int space = 10;
	
	//UIScrollView *
	scrl = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, 320, 370)];
	scrl.backgroundColor = [UIColor clearColor];
	scrl.tag = 65;
	[self.view addSubview:scrl];
	
	UIImageView *imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, 320, 400)];
	imgBack.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"inner_bg" ofType:@"png"]];
	[scrl addSubview:imgBack];
	
	UILabel *lblTitle = [[UILabel alloc] init];

	UIFont *TitleFont = [UIFont fontWithName:@"Helvetica" size:24];
	CGSize TitleFrameStringSize = [objEvent.name sizeWithFont:TitleFont 
											  constrainedToSize:maximumSize 
												  lineBreakMode:UILineBreakModeWordWrap];
	lblTitle.frame = CGRectMake(10, yRef, 300, TitleFrameStringSize.height);
    lblTitle.text = objEvent.name;  
	lblTitle.textColor = [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1.0];
	lblTitle.numberOfLines = 0;
	lblTitle.font = [UIFont fontWithName:@"Helvetica" size:24];
	lblTitle.backgroundColor = [UIColor clearColor];
	[scrl addSubview:lblTitle];
	[lblTitle release];
	
	yRef = yRef+TitleFrameStringSize.height;
	
	UILabel *lblDate = [[UILabel alloc] init];
	
	/*NSDateFormatter *format = [[NSDateFormatter alloc] init];	
	[format setDateFormat:webServiceDate];   
    NSDate *eventdate = [format dateFromString:objEvent.event_start_date];
    [format setDateFormat:dateFormatofEvent];  

	NSString *strDate = [format stringFromDate:eventdate];*/
	
	NSString *strDateStr = [NSString stringWithFormat:@"%@ %@  %@", objEvent.event_start_date, objEvent.event_start_time, objEvent.price];
	
	UIFont *DateFont = [UIFont fontWithName:@"Helvetica" size:12];
	CGSize DateFrameStringSize = [strDateStr sizeWithFont:DateFont 
												constrainedToSize:maximumSize 
													lineBreakMode:UILineBreakModeWordWrap];
	lblDate.frame = CGRectMake(10, yRef, 300, DateFrameStringSize.height);
	lblDate.text = strDateStr;
	lblDate.numberOfLines = 0;
	lblDate.textColor = [UIColor blackColor];
	lblDate.font = [UIFont fontWithName:@"Helvetica" size:12];
	lblDate.backgroundColor = [UIColor clearColor];
	[scrl addSubview:lblDate];
	[lblDate release];
	
	UIButton *btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
	btnMap.frame = CGRectMake(DateFrameStringSize.width+20, yRef, 31, 18);
	[btnMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map" ofType:@"png"]] forState:UIControlStateNormal];
	[btnMap addTarget:self action:@selector(mapBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[scrl addSubview:btnMap];
	
	yRef = yRef+DateFrameStringSize.height+space;
	
    
    selectedBussiness = (BusinessListBO *)[businessLayer SelectByKey:objEvent.BusinessId withMode:YES];
    
    CGSize AddressFrameStringSize;
    //if (objEventList.address) {
	
	NSString *TempAddress = [NSString stringWithFormat:@""];
	
	if([objEventList.address length])
	{
		TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",objEventList.address]];
	}
	if([objEventList.city length])
	{
		TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",objEventList.city]];
	}
	if([objEventList.state length])
	{
		TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",objEventList.state]];
	}
	if([objEventList.zipcode length])
	{
		TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",objEventList.zipcode]];
	}
	if([objEventList.country length])
	{
		TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",objEventList.country]];
	}
	
	NSArray *TempAddresArray = [TempAddress componentsSeparatedByString:@","];
	TempAddress = @"";
	for(int  k = 0 ; ([TempAddresArray count] - 1) > k ; k++)
	{
		if(k)
		{
		 TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@",%@",[TempAddresArray objectAtIndex:k]]];
		}
		else 
		{
		  TempAddress = [TempAddress stringByAppendingString:[NSString stringWithFormat:@"%@",[TempAddresArray objectAtIndex:k]]];
		}
		
		
	}
	
	
	
	        UILabel *lblAddress = [[UILabel alloc] init];
                
        UIFont *AddressFont = [UIFont fontWithName:@"Helvetica" size:12];
         AddressFrameStringSize = [TempAddress sizeWithFont:AddressFont 
                                               constrainedToSize:maximumSize 
                                                   lineBreakMode:UILineBreakModeWordWrap];
        lblAddress.frame = CGRectMake(10, yRef, 300, AddressFrameStringSize.height);
        lblAddress.numberOfLines = 0;
        lblAddress.textColor = [UIColor blackColor];
        lblAddress.text = TempAddress;
        lblAddress.numberOfLines = 0;
        lblAddress.font = [UIFont fontWithName:@"Helvetica" size:12];
        lblAddress.backgroundColor = [UIColor clearColor];
        [scrl addSubview:lblAddress];
        [lblAddress release];
   // }

 
 
	/*	if(objEventList.geocode && ![objEventList.geocode isEqualToString:@"None"])
		{
			UIButton *btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
			btnMap.frame = CGRectMake(AddressFrameStringSize.width+20, yRef, 31, 18);
			[btnMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map" ofType:@"png"]] forState:UIControlStateNormal];
			[btnMap addTarget:self action:@selector(mapBtnClicked) forControlEvents:UIControlEventTouchUpInside];
			[scrl addSubview:btnMap];
		}
	 
	NSLog(@"AddressFrameStringSize.height %lf",AddressFrameStringSize.height);
	if(AddressFrameStringSize.height  < 10)
	{
		AddressFrameStringSize.height = AddressFrameStringSize.height + 31;
		btnMap.frame = CGRectMake(10, yRef, 31, 18);
	}
	*/
	yRef = yRef+AddressFrameStringSize.height+space;
	
	UILabel *lblOrganization = [[UILabel alloc] init];
	NSString *strOrganization = @"";
	if(selectedBussiness)
		strOrganization = [NSString stringWithFormat:@"by %@", selectedBussiness.bizname];
	
	UIFont *OrganizationFont = [UIFont fontWithName:@"Helvetica" size:12];
	CGSize OrganizationFrameStringSize = [strOrganization sizeWithFont:OrganizationFont 
										   constrainedToSize:maximumSize 
											   lineBreakMode:UILineBreakModeWordWrap];
	lblOrganization.frame = CGRectMake(10, yRef, 300, OrganizationFrameStringSize.height);
	lblOrganization.numberOfLines = 0;
	lblOrganization.textColor = [UIColor blackColor];
	lblOrganization.text = strOrganization;
	lblOrganization.numberOfLines = 0;
	lblOrganization.font = [UIFont fontWithName:@"Helvetica" size:12];
	lblOrganization.backgroundColor = [UIColor clearColor];
	[scrl addSubview:lblOrganization];
	[lblOrganization release];
	
	if(selectedBussiness.bizname)
	{
		UILabel *lblSeeMore = [[UILabel alloc] init];
		lblSeeMore.frame = CGRectMake(OrganizationFrameStringSize.width+20, yRef, 200, OrganizationFrameStringSize.height);
		lblSeeMore.numberOfLines = 0;
		lblSeeMore.textColor = [UIColor colorWithRed:1.0/255 green:60.0/255 blue:83.0/255 alpha:1.0];
		lblSeeMore.text = @"see more events";
		lblSeeMore.font = [UIFont fontWithName:@"Helvetica" size:12];
		lblSeeMore.backgroundColor = [UIColor clearColor];
		[scrl addSubview:lblSeeMore];
		[lblSeeMore release];
		
		UIImageView *imgUnderLine = [[UIImageView alloc] initWithFrame:CGRectMake(OrganizationFrameStringSize.width+20, yRef+15, 90, 1)];
		imgUnderLine.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"underline" ofType:@"png"]];
		[scrl addSubview:imgUnderLine];
		[imgUnderLine release];
		
		UIButton *btnSeeMore = [[UIButton alloc] init];
		btnSeeMore.frame = CGRectMake(OrganizationFrameStringSize.width+20, yRef, 200, OrganizationFrameStringSize.height);
		[btnSeeMore addTarget:self action:@selector(SeeMoreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
		[scrl addSubview:btnSeeMore];
        [btnSeeMore release];
	}
	yRef = yRef+OrganizationFrameStringSize.height+space;
	
	imgEvent = [[UIImageView alloc] initWithFrame:CGRectMake(10, yRef, 119, 119)];
	[imgEvent.layer setMasksToBounds:YES];
	[imgEvent.layer setBorderColor:[[UIColor blackColor] CGColor]];
	[imgEvent.layer setBorderWidth:1.0];
	imgEvent.contentMode = UIViewContentModeScaleAspectFit;
    imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
	[scrl addSubview:imgEvent];
    
	
	loader=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	loader.center =imgEvent.center;
	[scrl addSubview:loader];
	[scrl bringSubviewToFront:loader];
	//[loader startAnimating];
	
    
    imagBl = [[EventImagesBL alloc]init];
    
    NSMutableArray *arrImageObjects = [[NSMutableArray alloc]init];
    [arrImageObjects addObjectsFromArray:[imagBl SelectAll]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"eventId == %@",objEvent.EventId];
    NSArray *arr = [arrImageObjects filteredArrayUsingPredicate:pred];
    [arrImageObjects release];
  /*  if ([arr count]) {
        
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"isMain == %@",@"True"];
        NSArray *arr1 = [arr filteredArrayUsingPredicate:pred1];
        
        if ([arr1 count]) {
            EventImagesBO *obj = [arr1 objectAtIndex:0];
            if (obj.imgEvent) {
                imgEvent.image = obj.imgEvent;

            }
            else{
                [loader startAnimating];
                 [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:[arr1 objectAtIndex:0]];
              }
         }
        else{
           imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
         }
        
        NSPredicate *pred2 =[NSPredicate predicateWithFormat:@"isMain == %@",@"False"];
        NSArray *arr2 = [arr filteredArrayUsingPredicate:pred2];
		 
		
		if ([arr2 count]) {
             
            [BigImagePath addObjectsFromArray:arr2];
            UIButton *imgEventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgEventBtn.frame = CGRectMake(10, yRef, 119, 119);
            [imgEventBtn addTarget:self action:@selector(imgClicked) forControlEvents:UIControlEventTouchUpInside];
            [scrl addSubview:imgEventBtn];
         }
        else{
            
         }
     }*/
	
	if ([arr count])
	{
		NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"isMain == %@",@"True"];
        NSArray *arr1 = [arr filteredArrayUsingPredicate:pred1];
        
        if ([arr1 count]) {
            EventImagesBO *obj = [arr1 objectAtIndex:0];
            if (obj.imgEvent) {
                imgEvent.image = obj.imgEvent;
				
            }
            else{
                [loader startAnimating];
				[NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:[arr1 objectAtIndex:0]];
			}
		}
		else 
		{
	
			EventImagesBO *obj = [arr objectAtIndex:0];
			if (obj.imgEvent) {
				imgEvent.image = obj.imgEvent;
				
			}
			else{
				[loader startAnimating];
				[NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:[arr objectAtIndex:0]];
			}
		
		}
		
		[BigImagePath addObjectsFromArray:arr];
		UIButton *imgEventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		imgEventBtn.frame = CGRectMake(10, yRef, 119, 119);
		[imgEventBtn addTarget:self action:@selector(imgClicked) forControlEvents:UIControlEventTouchUpInside];
		[scrl addSubview:imgEventBtn];
		
	}
	else{
		imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
	}
	 
	
	UILabel *lblDetail = [[UILabel alloc] init];
	NSString *strDetail = [NSString stringWithFormat:@"%@", objEvent.Description];
	
	//UIFont *DetailFont = [UIFont fontWithName:@"Helvetica" size:12];
	//CGSize DetailFrameStringSize = [strDetail sizeWithFont:DetailFont constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];
	lblDetail.frame = CGRectMake(139, yRef, 170, 90);
	lblDetail.text = strDetail;
	lblDetail.numberOfLines = 0;
	lblDetail.font = [UIFont fontWithName:@"Helvetica" size:12];
	lblDetail.backgroundColor = [UIColor clearColor];
	lblDetail.textColor = [UIColor blackColor];
	[scrl addSubview:lblDetail];
	[lblDetail release];
	
	UIButton *btnFav = [UIButton buttonWithType:UIButtonTypeCustom];
	btnFav.frame = CGRectMake(139, yRef+93, 65, 26);
	
		if(objEventList.isFavOrganisation)
		{
			[btnFav setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fav_hover" ofType:@"png"]] forState:UIControlStateNormal];
		}
		else
		{
			[btnFav setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fav" ofType:@"png"]] forState:UIControlStateNormal];

		}
    
 

	
	
	btnFav.tag = 111;
	[btnFav addTarget:self action:@selector(FavBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[scrl addSubview:btnFav];
	
	btnAttending = [UIButton buttonWithType:UIButtonTypeCustom];
	btnAttending.frame = CGRectMake(139, yRef+93, 84, 26);
	[btnAttending setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"attending_icon" ofType:@"png"]] forState:UIControlStateNormal];
	[btnAttending addTarget:self action:@selector(attnedingClicked) forControlEvents:UIControlEventTouchUpInside];
	//[scrl addSubview:btnAttending];
	
	btnTicket = [UIButton buttonWithType:UIButtonTypeCustom];
	btnTicket.frame = CGRectMake(139, yRef+93, 84, 26);
	[btnTicket setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buy" ofType:@"png"]] forState:UIControlStateNormal];
	[btnTicket addTarget:self action:@selector(ticketBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	//[scrl addSubview:btnTicket];
	
    
    ///////////////////////////// CAN BUY TICKETS //////////////////////////////////////
     NSDateFormatter *format2nd = [[NSDateFormatter alloc] init];
    [format2nd setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *eventDate = [format2nd dateFromString:[objEvent.event_start_date stringByAppendingFormat:@" %@",objEvent.event_start_time]];
    NSLog(@"%@", [NSDate date]);
    NSString *strCurrntDate = [format2nd stringFromDate:[NSDate date]];
    NSDate *currentDate = [format2nd dateFromString:strCurrntDate];
    [format2nd release];
     if([eventDate compare:currentDate] == NSOrderedSame)
    {
             btnTicket.userInteractionEnabled = NO;
            [btnTicket setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buy1" ofType:@"png"]] forState:UIControlStateNormal];
    }
    else if([eventDate compare:currentDate] == NSOrderedAscending)
    {
		btnTicket.userInteractionEnabled = NO;
		[btnTicket setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buy1" ofType:@"png"]] forState:UIControlStateNormal];
    }
 ///////////////////////////// CAN BUY TICKETS //////////////////////////////////////
 
	NSString *strBuyYesOrNoo = objEvent.tickets;
	if(strBuyYesOrNoo)
	{
		strBuyYesOrNoo = [strBuyYesOrNoo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if([strBuyYesOrNoo isEqualToString:@"1"])
		{
			btnAttending.hidden = YES;
			btnTicket.hidden = NO;
			
		}
		else if([strBuyYesOrNoo isEqualToString:@"0"])
		{
			btnAttending.hidden = NO;
			btnTicket.hidden = YES;
		}
		else
		{
		}
	}
	
	

	btnFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
	btnFavorite.frame = CGRectMake(139+67, yRef+93, 41, 26);
    
   /* NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
    BOOL isEventExists = NO;
    if([arrEvents count] && !isEventExists)
    {
        NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[objEventList.Eventid integerValue]];
        [arrEvents filterUsingPredicate:predic];
        if([arrEvents count])
        {
            isEventExists = YES;
        }
        
    }
    
    NSMutableArray *arrFavBusObjects = [UserFavBussLayer SelectAllBusinessEventsByKey:[appDelegate.currentUserID integerValue]];
    BOOL isFavBusExists = NO;
    if([arrFavBusObjects count] && !isFavBusExists)
    {
        NSPredicate *predic = [NSPredicate predicateWithFormat:@"BusinessId ==%i",[objEventList.business integerValue]];
        [arrFavBusObjects filterUsingPredicate:predic];
        if([arrFavBusObjects count])
        {
            isFavBusExists = YES;
        }
        
    }

	
    if(isEventExists && isFavBusExists)
	{
		[btnFavorite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(btn_FavDelete:) forControlEvents:UIControlEventTouchUpInside];
	}
	else 
	{*/
		[btnFavorite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star" ofType:@"png"]] forState:UIControlStateNormal];
        [btnFavorite addTarget:self action:@selector(btn_starAction:) forControlEvents:UIControlEventTouchUpInside];
		
	//}
  
	btnFavorite.tag = 123;
	
	[scrl addSubview:btnFavorite];
	
	UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
	btnShare.frame = CGRectMake(139+90+41, yRef+93, 41, 26);
	[btnShare setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]] forState:UIControlStateNormal];
	[btnShare addTarget:self action:@selector(btn_shareAction:) forControlEvents:UIControlEventTouchUpInside];
	[scrl addSubview:btnShare];

	yRef = yRef + 93+26;

	yRef = yRef+space;

	if([arrEventFriend count])
	{
		UILabel *lblAttend = [[UILabel alloc] initWithFrame:CGRectMake(15, yRef, 290, 20)];
		lblAttend.font = [UIFont boldSystemFontOfSize:17];
		lblAttend.textColor = [UIColor colorWithRed:76.0/255.0 green:86.0/255.0 blue:108.0/255.0 alpha:1.0];
		lblAttend.text = @"Attending";
		lblAttend.backgroundColor = [UIColor clearColor];
		[scrl addSubview:lblAttend];
		[lblAttend release];
		
		yRef+=20;
	}
	
	tblFriend = [[UITableView alloc] initWithFrame:CGRectMake(0, yRef, 320, 20+[arrEventAttendingFriends count]*44) style:UITableViewStyleGrouped];
	tblFriend.delegate = self;
	tblFriend.backgroundColor = [UIColor clearColor];
	tblFriend.dataSource = self;
	[scrl addSubview:tblFriend];
	tblFriend.scrollEnabled= FALSE;
	tblFriend.separatorStyle = UITableViewCellSeparatorStyleNone;

	tblFriend.tag = 1111;
	yRef =yRef+space+10+ [arrEventAttendingFriends count]*44;

	imgBack.frame = CGRectMake(0, 0, 320, yRef+40);
	[imgBack release];
	scrl.contentSize = CGSizeMake(320, yRef+40);
}

#pragma mark  Methods for POPUP 
-(void)addFriendToSendmail:(UIButton *)btn{
    FriendsBO *obj =  [arrEventFriend objectAtIndex:btn.tag]; 	
    
    if ([[btn currentImage] isEqual:[UIImage imageNamed:@"select_enable.png"]]) {
        [btn setImage:[UIImage imageNamed:@"rite_active.png"] forState:UIControlStateNormal];
        [arrFriendEmails addObject:obj];
    }
    else{
        [btn setImage:[UIImage imageNamed:@"select_enable.png"] forState:UIControlStateNormal];
        [arrFriendEmails removeObjectIdenticalTo:obj];
    }
    
}
-(void)sendMail:(NSMutableArray *)friends
{
	if([MFMailComposeViewController  canSendMail])
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		mail.mailComposeDelegate = self;
		[mail.navigationBar setTintColor: [UIColor colorWithRed:1.0/255.0 green:60.0/255.0 blue:83.0/255.0 alpha:1] ];
		if ([MFMailComposeViewController canSendMail]) {
			[mail setSubject:[NSString stringWithFormat:@"%@", objEvent.name]];
			
			NSArray *arr;
			arr = [friends valueForKeyPath:@"email"];				
			[mail setToRecipients:arr];
			
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setDateFormat:dateFormatofEvent];
			NSString *strDate = [format stringFromDate:objEvent.event_start_date];
			
			NSString *strDateStr = [NSString stringWithFormat:@"%@ %@", strDate, objEvent.event_start_date];
			
			NSString *str = [NSString stringWithFormat:@"<html><body><b>%@</b> <br/>%@ <br/>%@ <br/><br/>%@</body></html>",objEvent.name,strDateStr,objEvent.price, objEvent.Description];
			[format release];
			[mail setMessageBody:str isHTML:YES];	
			UIImage *img = objEventList.imageEvent;
			if(img)
			{
				NSData *data = UIImagePNGRepresentation(img);
				[mail addAttachmentData:data mimeType:@"image/png" fileName:@"abc"];
				
			}
			[self presentModalViewController:mail animated:YES];
		}
		[mail release];		
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please configure Email in your device." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];	
	}
	
}

-(void)sendRecomendations:(NSMutableArray *)friends
{
    
    NSArray *arr;
    arr = [friends valueForKeyPath:@"FriendId"];
    NSString *FriendsIds = [NSString stringWithFormat:@
                            "<friend>\n"];
    
    for(int k = 0 ; [arr count]>k ; k++)
    {
        FriendsIds = [FriendsIds stringByAppendingString:[NSString stringWithFormat:@"<friendid>%i</friendid>\n",[[arr objectAtIndex:k] integerValue]]];
    }
    
    FriendsIds = [FriendsIds stringByAppendingString:@"</friend>"];
    
    UserFavBussLayer.strSopForDeleteEvnt = [NSString stringWithFormat:@
                                            "<useraccount >\n"
                                            "<id>%i</id>\n"   
                                            "<eventid>%@</eventid>\n"
                                            "<subject>%@</subject>\n"  
                                            "<message>%@,%@</message>\n"
                                            "<friendships>%@</friendships>\n"
                                            "</useraccount >\n",[appDelegate.currentUserID intValue],objEvent.EventId,objEvent.name,objEvent.event_start_date, objEvent.event_start_time,FriendsIds];
    
    
    NSLog(@"UserFavBussLayer.strSopForDeleteEvnt %@",UserFavBussLayer.strSopForDeleteEvnt);
    
    [UserFavBussLayer deleteFavorite];
    
    
}

 

-(void)popUpMail{
	
	scrl.userInteractionEnabled		= NO;
	
	friendsView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 335)];
	friendsView.alpha = 0.80;
	friendsView.backgroundColor = [UIColor blackColor];
	friendsView.layer.cornerRadius = 10.0;
	friendsView.layer.borderWidth = 3.0;
	friendsView.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] CGColor];
	[friendsView.layer setMasksToBounds:YES];
	
	
	UIButton *btnClose = [[UIButton alloc]initWithFrame:CGRectMake(209, 2, 71, 30)];
	[btnClose setImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
	btnClose.backgroundColor = [UIColor clearColor];
	[btnClose addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	[friendsView addSubview:btnClose];
	[btnClose release];
	
	UIButton *btnOK = [[UIButton alloc]initWithFrame:CGRectMake(40, 300, 200, 30)];
 	///[btnOK setTitle:@"OK" forState:UIControlStateNormal];
    [btnOK setImage:[UIImage imageNamed:@"DoneBtn.png"] forState:UIControlStateNormal];
	btnOK.backgroundColor = [UIColor clearColor];
	[btnOK addTarget:self action:@selector(btnOkClicked) forControlEvents:UIControlEventTouchUpInside];
	[friendsView addSubview:btnOK];
	[btnOK release];
	
	tblFriends = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 280, 260)];
	tblFriends.backgroundColor = [UIColor clearColor];
	tblFriends.tag =2222;
	tblFriends.delegate = self;
	tblFriends.dataSource = self;
	[friendsView addSubview:tblFriends];
	
	[self.view addSubview:friendsView];
	
	//transforming the view
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	[self.view addSubview:friendsView];
	
	//animation starts here
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
	[UIView setAnimationDelegate:self];
	
	friendsView.transform = CGAffineTransformIdentity;
	friendsView.alpha = 0.80;
	[UIView commitAnimations];			
}

-(void)btnOkClicked{
	if([arrFriendEmails count]){
		scrl.userInteractionEnabled		= YES;

		if(friendsView!=nil)
		{
			[friendsView removeFromSuperview];
			[friendsView release];
			friendsView = nil;
			tblFriends.delegate = nil;
			tblFriends.dataSource = nil;
			[tblFriends release];
		}
		
		[self sendRecomendations:arrFriendEmails];
	}
	else {
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please select at least one friend to send mail." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];			
	}
}	

-(void)closeBtnClicked:(id)sender
{
	scrl.userInteractionEnabled		= YES;
	
 	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	friendsView.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(removeFriendsView) withObject:nil afterDelay:1.0];
	
}

-(void)removeFriendsView
{
	scrl.userInteractionEnabled = YES;
	
	if(friendsView!=nil)
	{
		[friendsView removeFromSuperview];
		[friendsView release];
		friendsView = nil;
		tblFriends.delegate = nil;
		tblFriends.dataSource = nil;
		[tblFriends release];
	}
}

-(void)removeScrollView
{
    if(scrl!=nil)
    {
        for(UIView *TempViev in scrl.subviews)
        {
            [TempViev removeFromSuperview];
        }
        [scrl  removeFromSuperview];
    
    }
}


#pragma mark UIActionSheet, MFMailComposeViewController and UIAlertView delegate methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if(actionSheet.tag == 400 || actionSheet.tag == 401)
	{
		if(buttonIndex == 0){
            [arrEventFriend removeAllObjects];
			FriendsBL *friendbl = [[FriendsBL alloc]init];
			[arrEventFriend addObjectsFromArray:[friendbl SelectAll]];
			[friendbl release];
			if ([arrEventFriend count]) {
                [self popUpMail];
			}
            
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have no friends." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];	
            }
		}
		
		if (buttonIndex == 1) {
            
 			
			FriendsBL *friendbl = [[FriendsBL alloc]init];
			[arrEventFriend addObjectsFromArray:[friendbl SelectAll]];
			[friendbl release];
			if ([arrEventFriend count]) {
				[self sendRecomendations:arrEventFriend];
			}
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have no friends." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];	
            }
			
 			//[self eventFrienDownload];
		}
		else if (buttonIndex == 2) 
		{
			
			if([arrFriendEmails count])
				[arrFriendEmails removeAllObjects];
			
			[self sendMail:arrFriendEmails];
			
		}
		else if (buttonIndex == 3) {
            
#if !TARGET_IPHONE_SIMULATOR
			MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            
            picker.recipients = [NSArray arrayWithObject:@"23234567"];  
            picker.body = @"iPhone OS4";
            
            [self presentModalViewController:picker animated:YES];
            [picker release];
#endif
            
		}
		else if (buttonIndex == 4) {
			/*
             facebookConnectViewController *obj = [[facebookConnectViewController alloc]initWithNibName:@"facebookConnectViewController" bundle:[NSBundle mainBundle]];
             obj.objTemp = objEvent;
             [self.navigationController pushViewController:obj animated:YES];
             [obj release];
			 */
			
		}
		else if (buttonIndex == 5) {
			/*
             twitterViewController *obj = [[twitterViewController alloc]initWithNibName:@"twitterViewController" bundle:[NSBundle mainBundle] withDataToBePublished:objEvent.name];
             [self.navigationController pushViewController:obj animated:YES];
             [obj release];
			 */
		}
		else if (buttonIndex == 6) {
			
		}
		
	}
	
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 62)
	{
		if(buttonIndex == 0)
		{
			objEvent.Tickets = @"0";
			[appDelegate.arr_AddedEvents addObject:objEvent];
			
			NSInteger intId = objEvent.EventId;
			for(int index1=0;index1<[appDelegate.arr_AllEvents count]; index1++)
			{
				EventsBO *obj = [appDelegate.arr_AllEvents objectAtIndex:index1];
				NSInteger intIdd = obj.EventId;
				if(intIdd == intId)
				{
					[appDelegate.arr_AllEvents replaceObjectAtIndex:index1 withObject:objEvent];
					[btnTicket removeFromSuperview];
					btnAttending.hidden = NO;
				}
			}
		}
	}
	else if(alertView.tag==1234)
	{
		if(buttonIndex==0)
		{
			UIButton *sender = (UIButton *)[self.view viewWithTag:111];
			NSString *strmsg;
			NSInteger intValue = 1;
			for(int i = 0; i<[appDelegate.arrOrganisationFav count]; i++)
			{
				BusinessListBO *obj = [appDelegate.arrOrganisationFav objectAtIndex:i];
				if([objEventList.business integerValue] == obj.id)
				{
					objEventList.isFavOrganisation = NO;
					intValue = 0;
					strmsg = @"This company is already in your favorites.";
					break;
				}
			}
			if(intValue)
			{
				objEventList.isFavOrganisation = YES;
				strmsg = @"This company has been added to your favorites.";
				BusinessListBL *businessLayer1 = [[BusinessListBL alloc]init];
				businessLayer1.delegate = self;
				BusinessListBO *objBusiness1 = (BusinessListBO*) [businessLayer1 SelectByKey:objEventList.business withMode:NO];
				[sender setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"fav_hover" ofType:@"png"]] forState:UIControlStateNormal];
				[appDelegate.arrOrganisationFav addObject:objBusiness1];
			}
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else if(buttonIndex==1)
		{
			NSString *strmsg;
			if(!objEventList.isFav)
			{		
				UIButton *sender = (UIButton *)[self.view viewWithTag:123];
				[sender setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"star_hover" ofType:@"png"]] forState:UIControlStateNormal];
				objEventList.isFav = YES;
				strmsg = @"This event has been added to your favorites.";
				[appDelegate.arrFavorite addObject:objEventList];
			}
			else
			{
				
				strmsg = @"This event is already in your favorites.";
			}
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}		
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    
    if(alertView.tag==1234)
	{
        
        
        if(buttonIndex==0)
        {
            [self loadAddFavrXml:objEventList forCompany:YES];
        }
        else if(buttonIndex==1)
        {
            [self loadAddFavrXml:objEventList forCompany:NO];
        }
    }
    else if(alertView.tag == 1235)
    {
        NSMutableArray *arrEvents = [UserFavBussLayer SelectfavEventsByKey:[objEventList.Eventid integerValue]];
        
        if(buttonIndex==0)
        {
            [self deletefavevent:[arrEvents objectAtIndex:0]];
            
        }
    }
}	

-(void)loadAddFavrXml:(EventListBO*)evnts forCompany:(BOOL)isCmpnyREvnt
{
	//fetching all favouties of the company for the user id
	if(isCmpnyREvnt)
	{
		NSMutableArray *arrFavBusObjects = [UserFavBussLayer SelectAllBusinessEventsByKey:[appDelegate.currentUserID integerValue]];
		BOOL isEventExists = NO;
		if([arrFavBusObjects count] && !isEventExists)
		{
			NSPredicate *predic = [NSPredicate predicateWithFormat:@"BusinessId ==%i",[evnts.business integerValue]];
			[arrFavBusObjects filterUsingPredicate:predic];
			if([arrFavBusObjects count])
			{
				isEventExists = YES;
			}
			
		}
		if(isEventExists)
		{
			[self showAlerts:@"Selected business is already added as favorites."];
		}
		else
		{
			UserFavBussLayer.objFavBusEvtBO = nil;
			FavoriteBusinessEventBO *objAddFav = [[FavoriteBusinessEventBO alloc]init];
			objAddFav.UserId     = [appDelegate.currentUserID integerValue];
			objAddFav.BusinessId = [evnts.business integerValue];
			UserFavBussLayer.objFavBusEvtBO = objAddFav;
			[objAddFav release];
			UserFavBussLayer.strSopForAddBussinessEvnt = [NSString stringWithFormat:@
														  "<useraccount >\n"
														  "<id>%i</id>\n"   
														  "<fav_businesses>\n"
														  "<business>\n"
														  "<businessid>%i</businessid>\n"  
														  "</business>\n"
														  "</fav_businesses>\n"
														  "</useraccount >\n",[appDelegate.currentUserID intValue],[evnts.business intValue]];
			[UserFavBussLayer addFavoriteBusiness];
			
		}
	}
	else
	{
		NSMutableArray *arrEvents = [UserFavBussLayer SelectAllEventsByKey:[appDelegate.currentUserID integerValue]];
		BOOL isEventExists = NO;
		if([arrEvents count] && !isEventExists)
		{
			NSPredicate *predic = [NSPredicate predicateWithFormat:@"EventId ==%i",[evnts.Eventid integerValue]];
			[arrEvents filterUsingPredicate:predic];
			if([arrEvents count])
			{
				isEventExists = YES;
			}
			
		}
		if(isEventExists)
		{
			[self showAlerts:@"Event selected is already added to Palendar."];
		}
		else
		{
			UserFavBussLayer.addFavEvnt = nil;
			AddFavEventBO *objAddFav = [[AddFavEventBO alloc]init];
			objAddFav.UserId = [appDelegate.currentUserID integerValue];
			objAddFav.EventId = [evnts.Eventid integerValue];
			UserFavBussLayer.addFavEvnt = objAddFav;
			[objAddFav release];
			UserFavBussLayer.strSopForAddEvent = [NSString stringWithFormat:@
												  "<useraccount >\n"
												  "<id>%i</id>\n"   
												  "<events>\n"
												  "<event>\n"
												  "<eventid>%i</eventid>\n"  
												  "</event>\n"
												  "</events>\n"
												  "</useraccount >\n",[appDelegate.currentUserID intValue],[evnts.Eventid intValue]];
			[UserFavBussLayer loadFavoriteEvent];
			
		}
	}
}

-(void)deletefavevent:(AddFavEventBO*)evnts
{
    

    /*UserFavBussLayer.strSopForDeleteEvnt = [NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/events/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],evnts.UserAddedEventId];
    
 
    [UserFavBussLayer deleteFavorite];*/
    
   if(appDelegate.isNetAvail)
	{
		HttpRequest *request = [[HttpRequest alloc] init];
 		[request PostRequestToDelete:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/events/id/%i/deleteids/%i",[appDelegate.currentUserID intValue],evnts.UserAddedEventId] Delegate:self Tag:10];
  		[request release];		
		
	}
}


-(void)httpResponseReceived:(WebResponse *)response
{
	
	
	NSString *strMsg = @"";
	
    if (response.tag == 10)
	{
		if (!response.isError)
		{
           NSString *responseString = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
            NSLog(@"responseStringdelet  %@",responseString);
			responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding='utf-8'?><useraccount><results><result>" withString:@""];
			responseString = [responseString stringByReplacingOccurrencesOfString:@"</result><results></useraccount>" withString:@""];
			
			NSInteger isFaventdeleted = 0;
			
			if(![responseString isEqualToString:@"0"] && ![responseString isEqualToString:@"1"] && ![responseString isEqualToString:@"-2"] &&  [responseString length])
			{
				strMsg = @"Selected event is successfully removed from favorite events.";
			}
			if([responseString isEqualToString:@"0"])
			{
				strMsg = @"Selected event is already removed from favorite events.";
			}
			if([responseString isEqualToString:@"1"] || [responseString isEqualToString:@"-2"])
			{
				strMsg = @"Error while removing selected event from favorite events.";
			}
		}
		else 
		{
		 strMsg = @"Error while removing selected event from favorite events.";
		}
		
		[self FavoriteEventDeletCompleted:strMsg];
    }
    
}


#pragma mark -
#pragma mark  FavoriteEventUpload to sever delegate FUNCTIONs
#pragma mark -

-(void)FavoriteBusinessLoadingCompleted:(NSMutableArray *)arrFriends
{
}

-(void)addingFavDidComplete:(NSString*)strMsgs
{
    NSRange rangeIs = [strMsgs rangeOfString:@"successfully" options:NSCaseInsensitiveSearch];
    if(rangeIs.length > 11)
    {
        NSMutableArray *arrEvents = [UserFavBussLayer SelectfavEventsByKey:[objEventList.Eventid integerValue]];
        
        UserFavEvents *addFav   = [[UserFavEvents alloc]init];
        AddFavEventBO *objAddFav = [arrEvents objectAtIndex:0];
        addFav.strEventId = [NSString stringWithFormat:@"%i",objAddFav.EventId];
        addFav.strUserAddedEventId = [NSString stringWithFormat:@"%i",objAddFav.UserAddedEventId];
        [appDelegate.arr_FavoritesID addObject:addFav];
        [addFav release];
    }
    
	[self showAlerts:strMsgs];
}

-(void)FavoriteBusinessEventsLoadingCompleted:(NSString*)strMsgs
{
	[self showAlerts:strMsgs];
}


-(void)FavoriteEventDeletCompleted:(NSString*)strMsgs
{
    NSRange rangeIs = [strMsgs rangeOfString:@"successfully" options:NSCaseInsensitiveSearch];
    if(rangeIs.length > 11)
    {
        for(int k = 0 ; [appDelegate.arr_FavoritesID count] > k ; k++)
            {
                NSString *tempid = [[appDelegate.arr_FavoritesID objectAtIndex:k] strEventId];
                if([tempid isEqualToString:objEventList.Eventid])
                {
                    [UserFavBussLayer DeletefavEventsByKey:[tempid integerValue]];
                    [appDelegate.arr_FavoritesID removeObjectAtIndex:k];
                    break;
                }
                
            }
    }
    
	[self showAlerts:strMsgs];
}
-(void)showAlerts:(NSString*)strMsg
{
	UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alerts show];
	[alerts release];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	if(result == MFMailComposeResultCancelled)
		NSLog(@"Mail Cancelled");
	if(result == MFMailComposeResultSaved)
		NSLog(@"Mail Saved");
	if(result == MFMailComposeResultSent)
	{
		UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:nil message:@"Your mail has been sent successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
		NSLog(@"Mail Sent");
	}
	if(result == MFMailComposeResultFailed)
	{
		NSLog(@"failed sending mail");	
	};
	[self dismissModalViewControllerAnimated:YES];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	
	switch (result)
	{
		case MessageComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			NSLog(@"Result: sent");
			break;
		case MessageComposeResultFailed:
			NSLog(@"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
	
}


#pragma mark UITableView delegate and dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag == 2222)
		return 60;
	else
		return 44; 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (tableView.tag == 1111) {
		return [arrEventAttendingFriends count];
 	}
	else {
		return [arrEventFriend count];

	}

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(tableView.tag == 2222)
	{
		
		if([arrEventFriend count])
		{
			static NSString *EventDetailCell1 = @"EventDetailCell1";
			FriendsBO *obj =  [arrEventFriend objectAtIndex:indexPath.row]; 	
			
			FriendTableCell *cell = (FriendTableCell *)[tableView dequeueReusableCellWithIdentifier:EventDetailCell1];
			if (cell == nil) {
				cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:EventDetailCell1] autorelease];
 			}
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imgViewDarkBG.image = nil;
            cell.imgViewEvent.frame = CGRectMake(10, 5, 50, 50);
            
            cell.lblTitle.frame = CGRectMake(70, 12, 170, 30);
            cell.lblTitle.textColor = [UIColor whiteColor];
            cell.lblTitle.backgroundColor = [UIColor clearColor];
            
            if(tableView.tag == 2222){
                cell.btnAdd.hidden=NO;
                cell.btnAdd.tag = indexPath.row;
                cell.btnAdd.frame = CGRectMake(240, 12, 30, 30);
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"FriendId == %@",obj.FriendId];
                NSArray *arr = [arrFriendEmails filteredArrayUsingPredicate:pred];
                
                if ([arr count]) {
                    [cell.btnAdd setImage:[UIImage imageNamed:@"rite_active.png"] forState:UIControlStateNormal];
                }
                else{
                    [cell.btnAdd setImage:[UIImage imageNamed:@"select_enable.png"] forState:UIControlStateNormal];
                }
                [cell.btnAdd addTarget:self action:@selector(addFriendToSendmail:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else{
                cell.btnAdd.hidden=YES;
                
                
            }
            
            
			[cell setTips:obj];
			[cell showUserImage];
			return cell;
		}
		else
		{
			static NSString *EventDetailCell2 = @"EventDetailCell2";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventDetailCell2];
        
			if(cell == nil)
			{
				cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EventDetailCell2] autorelease];
			}
			
			cell.textLabel.text = @"No Event Friend";
			[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.textLabel.textAlignment = UITextAlignmentCenter;
			cell.textLabel.textColor = [UIColor whiteColor];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.backgroundColor = [UIColor clearColor];
			return cell;
		}
	}
	else
	{
		static NSString *EventDetailCell3 = @"EventDetailCell3";
		FriendTableCell *cell = (FriendTableCell*)[tableView dequeueReusableCellWithIdentifier:EventDetailCell3];
		if (cell == nil) {
			cell = [[[FriendTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:EventDetailCell3] autorelease];
		}
		FriendsBO *objFr = [arrEventAttendingFriends objectAtIndex:indexPath.row];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		[cell setTips:objFr];
	 
		cell.lblTitle.frame = CGRectMake(60, 0, 200, 44);
		cell.imgViewDarkBG.image = nil;
		
		/*UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(11, 43, 297, 1)];
		imgSep.tag = 10;
		imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperaotr" ofType:@"png"]];
		[cell.contentView addSubview:imgSep];
		[imgSep release];*/
		cell.backgroundView = nil;
		cell.selectedBackgroundView = nil;
		
		cell.imgViewEvent.frame = CGRectMake(1, 1, 42, 42);
		cell.loaderView.center = cell.imgViewEvent.center;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.textAlignment = UITextAlignmentLeft;
		cell.textLabel.textColor = [UIColor whiteColor];
		return cell;
	}
}

- (void)tableView:(UITableView *)tblNewsPeople willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
		[(FriendTableCell *)cell showUserImage];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(tableView.tag != 2222)
	{
        FriendDetailViewController *objFriendDet= [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:[NSBundle mainBundle]];
        objFriendDet.objFriend = [arrEventAttendingFriends objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:objFriendDet animated:YES];
        [objFriendDet release];

 	}
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(void)bigBtnClicked1:(id)sender
{
 	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.29];
 	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.3);
	friendsView.transform = transform;
	friendsView.alpha = 0.0;
  	[UIView commitAnimations];
	[self performSelector:@selector(removeFriendsView) withObject:nil afterDelay:1.0];
	
}

#pragma mark Button Action Methods

-(void)back_btnClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)btn_shareAction:(id)sender
{
	
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"specific ga2oo friends", @"all ga2oo friends", @"Email", @"SMS", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
	popupQuery.tag = 400;
	[popupQuery showInView:self.tabBarController.view];
	[popupQuery release];
}

-(void)btn_starAction:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Choose a category to make a favorite?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Company", @"Event", nil];
	alert.tag = 1234;
	[alert show];
	[alert release];
}

-(void)btn_FavDelete:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to remove this event form favorite events?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
	alert.tag = 1235;
	[alert show];
	[alert release];
}

-(void)SeeMoreBtnClicked
{
	
    NSArray *arr1 = self.navigationController.viewControllers;
    NSLog(@"before count = %i",[arr1 count]);
    int index1 = -1;
    for (UIViewController *controller in arr1) {
        if ([controller isKindOfClass:[BusinessCalenderViewController class]]) {
            index1 = [arr1 indexOfObject:controller];
            NSLog(@"index of login screen = %i",index1);
        }
    }
    
    if (index1>=0) {
        NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [allViewControllers removeObjectIdenticalTo:[arr1 objectAtIndex:index1]];
        self.navigationController.viewControllers = allViewControllers;
    }
	
	BusinessCalenderViewController *objCalVC = [[BusinessCalenderViewController alloc] initWithNibName:@"BusinessCalenderViewController" bundle:[NSBundle mainBundle]];
	objCalVC.BackBtnName = @"Back";
    //objCalVC.SelectedFriendId = objFriend.FriendId;
	NSString *strBusinessID = [NSString stringWithFormat:@"%@", selectedBussiness.bussinessId];
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"business contains[cd] %@",strBusinessID];
	NSArray *arr = [appDelegate.arr_AllEvents filteredArrayUsingPredicate:pred];
	if([arr count])
	{
        objCalVC.TotalBusinessEvents = [[NSMutableArray alloc]initWithArray:arr];
	}
    
    objCalVC.ScreenTitle = selectedBussiness.bizname;
	[self.navigationController pushViewController:objCalVC animated:YES];
	[objCalVC release];
}

-(void)WhoIsGoing
{
}

-(void)rateBtnClicked:(UIButton *)sender
{
	
	for(int i= 0; i<5;i++)
	{
		UIButton *btn = (UIButton *)[self.view viewWithTag:i+10];
		[btn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rate_it_icon1" ofType:@"png"]] forState:UIControlStateNormal];
	}
	NSInteger intTag = sender.tag;
	//objEvent.intRate = intTag;
	for(int i= 0; i<intTag-10+1;i++)
	{
		UIButton *btn = (UIButton *)[self.view viewWithTag:i+10];
		[btn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rate_it_icon" ofType:@"png"]] forState:UIControlStateNormal];
		
		
	}
	NSString *strmsg = [NSString stringWithFormat:@"You have given %i rating to this event.",intTag-9];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)FavBtnClicked:(id)sender
{
	NSString *strmsg;
	NSInteger intValue = 1;
	for(int i = 0; i<[appDelegate.arrOrganisationFav count]; i++)
	{
		EventObject *obj = [appDelegate.arrOrganisationFav objectAtIndex:i];
		if(objEvent.intOrganisationID == obj.intOrganisationID)
		{
			//objEvent.isFavOrganisation = NO;
			intValue = 0;
			strmsg = @"This company is already in your favorites.";
			break;
		}
	}
	if(intValue)
	{
		objEvent.isFavOrganisation = YES;
		[sender setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"fav_hover" ofType:@"png"]] forState:UIControlStateNormal];
		strmsg = @"This company has been added to your favorites.";
		[appDelegate.arrOrganisationFav addObject:objEvent];
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void) attnedingClicked
{
	NSLog(@"attending clicked");
}


-(void)ticketBtnClicked
{
	TicketWebViewController *objCont = [[TicketWebViewController alloc] initWithNibName:@"TicketWebViewController" bundle:[NSBundle mainBundle]];
	objCont.objEvent = objEvent;
	[self.navigationController pushViewController:objCont animated:YES];
	[objCont release];
	/*UIAlertView *alertVwConf = [[UIAlertView alloc] initWithTitle:nil message:@"You have successfully booked ticket for this event." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	alertVwConf.tag = 62;
	[alertVwConf show];
	[alertVwConf release];*/
}

-(void)mapBtnClicked
{
	EventMapViewController *objMap = [[EventMapViewController alloc] initWithNibName:@"EventMapViewController" bundle:[NSBundle mainBundle]];
	//objMap.objEventLocation = selectedBussiness;
	//objMap.objLoc =  self.objEventLoc;
	objMap.objEventListMap = objEventList;
	[self.navigationController pushViewController:objMap animated:YES];
	[objMap release];
}

-(void)imgClicked
{
	if(friendsView == nil){
		
		viewLargImage = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 370)];
		viewLargImage.backgroundColor = [UIColor clearColor];


		scroll_LargeImage = [[UIScrollView alloc] init];
		scroll_LargeImage.frame = CGRectMake(0, 0, 320, 416);
		[scroll_LargeImage setBackgroundColor:[UIColor blackColor]];
		[scroll_LargeImage setContentMode:UIViewContentModeCenter];
		scroll_LargeImage.tag = 2001;
		[viewLargImage addSubview:scroll_LargeImage];
		[self.view addSubview:viewLargImage];
		
		pageControler = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 350, 320, 20)];
		[pageControler addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventTouchUpInside];
		[viewLargImage addSubview:pageControler];
		[pageControler setNumberOfPages:[BigImagePath count]];
		
		UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(250, 5, 71, 30)];
		btn.backgroundColor = [UIColor clearColor];
		[btn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close_button" ofType:@"png"]] forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(bigBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

		[viewLargImage addSubview:btn];
		[btn release];
		
		[self showLargeImages];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	pageControler.currentPage = scrollView.contentOffset.x / 320;
}


-(void)pageChanged:(id)sender{
	
	NSInteger pageIndex = pageControler.currentPage;
	UIScrollView *scr_Temp = (UIScrollView *)[self.view viewWithTag:2001];
	[scr_Temp setContentOffset:CGPointMake(scr_Temp.bounds.size.width * pageIndex,0)];
}


-(void) showLargeImages
{
	index = 0;
	if([pageViews count])
		[pageViews removeAllObjects];
	
	for(UIView *v in scroll_LargeImage.subviews)
		[v removeFromSuperview];
	if([BigImagePath count])
	{
		scrollViewMode = ScrollViewModePaging;
		[self.view addSubview:viewLargImage];
		scroll_LargeImage.delegate = self;
		scroll_LargeImage.maximumZoomScale = 1.80f;
		scroll_LargeImage.minimumZoomScale = 1.0f;
		scroll_LargeImage.pagingEnabled = YES;
		scroll_LargeImage.contentSize=CGSizeMake([BigImagePath count]*320, 0);
		NSInteger temp = [index integerValue];
		scroll_LargeImage.contentOffset = CGPointMake(320 *temp, 0);
		scroll_LargeImage.showsHorizontalScrollIndicator=NO;
		scroll_LargeImage.backgroundColor = [UIColor blackColor];
		for(int i =0;i<[BigImagePath count];i++)
		{
			AsyncImageView *ImgView=[[AsyncImageView alloc]init];
			ImgView.frame=CGRectMake(i*320, 0, 320, 350);
			ImgView.contentMode = UIViewContentModeScaleAspectFit;
			ImgView.backgroundColor=[UIColor clearColor];
			ImgView.layer.masksToBounds = YES;
			ImgView.tag=(i+1)*100;
			[ImgView setShowActivity:YES];
			[scroll_LargeImage addSubview:ImgView];
			[pageViews addObject:ImgView];
			[ImgView release];
			ImgView=nil;
			
		}
		
		[self DownloadAlltheImages:index];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView 
{
	if (scrollViewMode == ScrollViewModePaging)
	{
		CGFloat pageWidth = scroll_LargeImage.frame.size.width;
		NSInteger page = floor((scroll_LargeImage.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		currentPage = page;
		if(imgIndex!=page && imgIndex>=0 && page>=0 && page<[BigImagePath count])
		{
			imgIndex=page;
			UIImageView *Img_view=(UIImageView *)[scroll_LargeImage viewWithTag:(page+1)*100];
			if(!Img_view.image)
			{
				[self DownloadAlltheImages:[NSString stringWithFormat:@"%i",page]];
			}
		}
	}
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
	NSLog(@"viewForZoomingInScrollView");
	if (scrollViewMode != ScrollViewModeZooming)
		[self setZoomingMode];
	return [pageViews objectAtIndex:currentPage];
}


- (void)scrollViewDidEndZooming:(UIScrollView *)aScrollView withView:(UIView *)view atScale:(float)scale {
	NSLog(@"scrollViewDidEndZooming");
	if (scroll_LargeImage.zoomScale == scroll_LargeImage.minimumZoomScale)
		[self setPagingMode];
	else if (pendingOffsetDelta > 0) {
		UIView *view = [pageViews objectAtIndex:currentPage];
		view.center = CGPointMake(view.center.x - pendingOffsetDelta, view.center.y);
		CGSize pageSize = [self pageSize];
		scroll_LargeImage.contentOffset = CGPointMake(scroll_LargeImage.contentOffset.x - pendingOffsetDelta, scroll_LargeImage.contentOffset.y);
		scroll_LargeImage.contentSize = CGSizeMake(pageSize.width * scroll_LargeImage.zoomScale, pageSize.height * scroll_LargeImage.zoomScale);
		pendingOffsetDelta = 0;
	}
	
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"scrollViewDidEndDragging");
}

- (CGSize)pageSize {
	CGSize pageSize = scroll_LargeImage.frame.size;
	return pageSize;
}


- (void)setPagingMode {
	// reposition pages side by side, add them back to the view
	CGSize pageSize = [self pageSize];
	NSUInteger page = 0;
	for (UIView *view in pageViews) {
		if (!view.superview)
			[scroll_LargeImage addSubview:view];
		view.frame = CGRectMake(pageSize.width * page++, 0, pageSize.width, pageSize.height);
	}
	
	scroll_LargeImage.pagingEnabled = YES;
	scroll_LargeImage.showsVerticalScrollIndicator = scroll_LargeImage.showsHorizontalScrollIndicator = NO;
	scroll_LargeImage.contentSize = CGSizeMake(pageSize.width * [pageViews count], pageSize.height);
	scroll_LargeImage.contentOffset = CGPointMake(pageSize.width * currentPage, 0);
	
	scrollViewMode = ScrollViewModePaging;
}

- (void)setCurrentPage:(NSUInteger)page {
	if (page == currentPage)
		return;
	currentPage = page;
	// in a real app, this would be a good place to instantiate more view controllers -- see SDK examples
}



- (void)setZoomingMode {
	NSLog(@"setZoomingMode");
	scrollViewMode = ScrollViewModeZooming; // has to be set early, or else currentPage will be mistakenly reset by scrollViewDidScroll
	
	// hide all pages except the current one
	NSUInteger page = 0;
	for (UIView *view in pageViews)
		if (currentPage != page++)
			[view removeFromSuperview];
	
	scroll_LargeImage.pagingEnabled = NO;
	scroll_LargeImage.showsVerticalScrollIndicator = scroll_LargeImage.showsHorizontalScrollIndicator = YES;
	pendingOffsetDelta =  scroll_LargeImage.contentOffset.x;
	scroll_LargeImage.bouncesZoom = YES;
}


-(void)bigBtnClicked:(id)sender
{
	[viewLargImage removeFromSuperview];
	[scroll_LargeImage removeFromSuperview];
}

-(void) logoutBtn_Clicked:(id) sender
{

	for(UIViewController *viewCont in appDelegate.navigationController.viewControllers)
	{
		if([viewCont isKindOfClass:[HomeViewController class]])
		{
			[appDelegate.navigationController popToViewController:viewCont animated:NO];
			break;
		}
	}
	[appDelegate removeTabBar];
}

#pragma mark -
#pragma mark downloadImage
-(void)downloadImage:(EventImagesBO *)imageObj  {
	
    
    NSString *imageUrl = imageObj.imageUrl;
	if (!imageUrl || [imageUrl isEqual:[NSNull null]]) {
		
		imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
		return;  
	}
	
	NSError *error = nil;
	NSString *str = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, imageUrl];
	str = [str stringByReplacingOccurrencesOfString:@"#38;" withString:@""];
 	str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
 	
	NSURL *url = [NSURL URLWithString:str];
	if(url)
	{
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str] options:3 error:&error];
		if(!error){
            imageObj.dataImgEvent = imageData;
            imgEvent.image = [UIImage imageWithData:imageData];
            [imagBl Update:imageObj withSave:YES];
        }
 		else{
			imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
        }
		[imageData release];
		
	}
	else
	{
		imgEvent.image = [UIImage imageNamed:@"NoImageEvent.png"];
	}
    [loader stopAnimating];

}

-(void)DownloadAlltheImages:(NSString *)IndexPosition
{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
    
    AsyncImageView *Img_view=(AsyncImageView *)[scroll_LargeImage viewWithTag:([IndexPosition intValue]+1)*100];

    
    EventImagesBO *imageObj = [BigImagePath objectAtIndex:[IndexPosition intValue]];
    if (imageObj.imgEvent) {
        Img_view.image = imageObj.imgEvent;
    }
    else{
        NSString *str1 = [imageObj.imageUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strpath = [NSString stringWithFormat:@"%@/%@",Ga2ooimageURL,str1];
        strpath = [strpath stringByReplacingOccurrencesOfString:@"#38" withString:@""];
        NSURL *url = [NSURL URLWithString:strpath];
        
        [Img_view loadImageFromURL:url];
        
        
        imageObj.dataImgEvent = UIImageJPEGRepresentation(Img_view.image, 0.8);
         [imagBl Update:imageObj withSave:YES];

    
    }
    Img_view.contentMode = UIViewContentModeScaleAspectFit;

	
	
	[pool release];
}	
/*
-(void)downloadImage:(NSString *)strImagePath Tag:(NSInteger)tag {
	
	NSString *strpath = [NSString stringWithFormat:@"%@%@", Ga2ooimageURL, objEvent.Image1];
	strpath = [strpath stringByReplacingOccurrencesOfString:@"#38" withString:@""];
	HttpRequest *req =[[HttpRequest alloc]init];
	[req GetRequest:strpath Delegate:self Tag:tag ModuleName:strImagePath];
	[req release];
}

- (void)httpResponseReceived:(WebResponse *)response {
	
	if(response.tag ==12 && !response.isError) {
		
		UIImage *img =[UIImage imageWithData:response.data];
		imgEvent.image = img;
		[loader stopAnimating];
	}
	if(response.tag ==15 && !response.isError) {
		
		UIImage *img =[UIImage imageWithData:response.data];
		UIButton *btn=(UIButton *)[scroll_LargeImage viewWithTag:12345];
		[btn setImage:img forState:UIControlStateNormal];
		
		[loaderBig stopAnimating];
	}
}
*/
#pragma mark -


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
	EventLayer.delegate = nil;
	EventFriendLayer.delegate = nil;
	EventLocLayer.delegate = nil;
	businessLayer.delegate = nil;
}

- (void)dealloc {
	
    UserFavBussLayer.delegate =nil;
	[UserFavBussLayer release];
	[EventLayer release];
	[EventFriendLayer release];
	[EventLocLayer release];
	[businessLayer release];
	
	[arrEventFriend release];
	[imgEvent release];
	[scrl release];
	if(friendsView!=nil)
	{
		[friendsView removeFromSuperview];
		[friendsView release];
		friendsView = nil;
		tblFriends.delegate = nil;
		tblFriends.dataSource = nil;
		[tblFriends release];
	}
	[arrLocation release];
	tblFriend.delegate = nil;
	tblFriend.dataSource = nil;
	[tblFriend release];
	[scroll_LargeImage release];
	[objEvent release];
	[pageControler release];
    [super dealloc];
}

@end
