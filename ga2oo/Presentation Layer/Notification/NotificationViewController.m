//
//  NotificationViewController.m
//  Ga2oo
//
//  Created by Mayank Goyal on 05/04/11.
//  Copyright 2011 Winit. All rights reserved.
//

#import "NotificationViewController.h"
#import "EventListBO.h"
#import "NotifyTabeCell.h"
#import "EventDetailViewController.h"
#import "EventNotificationsBO.h"
#import "RecommendationCell.h"
#import "FriendRequestBO.h"
#import "FriendRequestXML.h"
#import "HttpRequest.h"

@implementation NotificationViewController
@synthesize arrNotification;
@synthesize notifyBl;
@synthesize arrRecommendation;
@synthesize RecmBL;
@synthesize Selectedobj;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	tblRecomendation.backgroundColor = [UIColor clearColor];
	tblRecomendation.separatorColor = [UIColor clearColor];
	tblRecomendation.tag = 1;
	self.arrNotification = [[NSMutableArray alloc] init];
	
	notifyBl = [[NotificationsBL alloc] init];
	self.arrNotification = [notifyBl SelectAll];
    
    RecmBL = [[EventRecommendateBL alloc] init];
    self.arrRecommendation = [RecmBL SelectAll];
	
	objFrndBL = [[FriendsBL alloc]init];
	objFrndBL.delegate = self;

	
	
	

	
}

#pragma mark UIButton Methods








#pragma mark -

#pragma mark IBAction Methods



-(IBAction)segmentBtnClicked:(UIButton *)sender
{
	if([sender tag]==1)
	{
		[btnAll setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"all_btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
		[btnRecomd setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recommen_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[btnNoti setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notifications_btn" ofType:@"png"]] forState:UIControlStateNormal];
		
		tblRecomendation.tag = 1;
		[tblRecomendation reloadData];
	}
	else if([sender tag]==2){
		
		[btnAll setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"all_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[btnRecomd setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recommen_btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
		[btnNoti setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notifications_btn" ofType:@"png"]] forState:UIControlStateNormal];
		
		tblRecomendation.tag = 2;
		[tblRecomendation reloadData];
	}
	else {
		
		[btnAll setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"all_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[btnRecomd setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recommen_btn" ofType:@"png"]] forState:UIControlStateNormal];
		[btnNoti setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notifications_btn_hover" ofType:@"png"]] forState:UIControlStateNormal];
		
		tblRecomendation.tag = 3;
		[tblRecomendation reloadData];
	}
}

-(IBAction)backBtnClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -

#pragma mark UITableView Delagate

-(UIView *)designHeaderView
{
	UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 34)];
	[v setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1.0]];
	
	UILabel *lbl_HelpTxt = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 270, 20)];
	lbl_HelpTxt.numberOfLines=0;
	lbl_HelpTxt.textColor = [UIColor colorWithRed:110/255.0 green:149/255.0 blue:165/255. alpha:1.0];
	lbl_HelpTxt.numberOfLines = 2;
	lbl_HelpTxt.backgroundColor = [UIColor clearColor];
	lbl_HelpTxt.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
	
	if(tblRecomendation.tag == 3)
	{
		lbl_HelpTxt.text = @"Notifications";
	}
	else if(tblRecomendation.tag == 1)
	{
		lbl_HelpTxt.text = @"All Events";
	}
	else {
		
		lbl_HelpTxt.text = @"Recommended Events";
	}

	[v addSubview:lbl_HelpTxt];
	
	UIImageView *imgSep = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 300, 2)];
	imgSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"seperator@2x" ofType:@"png"]];
	imgSep.backgroundColor = [UIColor clearColor];
	[v addSubview:imgSep];
	[imgSep release];
	[lbl_HelpTxt release];
	
	return [v autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if(tableView.tag == 1)
    {
    
        if([self.arrRecommendation  count] && [self.arrNotification count])
        {
            return 2;
        }
        else 
        {
            return 1;
        }
    }
    
	else if(tableView.tag == 2)
		return 1;
	else
		return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	return 34;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView.tag == 1)
	{
        if (section == 0)
        {
          if([self.arrNotification count])
          {
              return [self.arrNotification count];
          }
          else if([self.arrRecommendation count])
          {
              return [self.arrRecommendation count];
          }
          else
          {
              return 1;
          }
        }
        else if (section == 1)
        {
        
            if([self.arrRecommendation count])
            {
                return [self.arrRecommendation count];
            }
            else
            {
                return 1;
            }
        
        }
		
	}
	else if(tableView.tag == 2)
	{
		if([self.arrRecommendation  count])
				return [self.arrRecommendation count];
			else 
				return 1;
    }
	else 
	{
        if([self.arrNotification count])
				return [self.arrNotification count];
			else 
				return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	    return 100;
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
	  return [self designHeaderView];
    }
    else 
    {
        return nil;
    }
}

	// create the parent view that will hold header Label
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(tableView.tag == 1)
	{
		if(indexPath.section == 0)
        {
            if([self.arrNotification count])
            {
                static NSString *NotificationCell1 = @"NotificationCell1";
                
                NotifyTabeCell *cell1 = (NotifyTabeCell *)[tableView dequeueReusableCellWithIdentifier:NotificationCell1];
                if (cell1 == nil) 
                {
                    cell1 = [[[NotifyTabeCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell1] autorelease];
                    
                    UIButton *Rejectbtn = [[UIButton alloc]initWithFrame:CGRectMake(185, 60, 105, 30)];
                    Rejectbtn.tag=indexPath.row;
                    Rejectbtn.contentMode = UIViewContentModeScaleAspectFill;
                    [Rejectbtn setImage:[UIImage imageNamed:@"btnreject.png"] forState:UIControlStateNormal];
                    [Rejectbtn addTarget:self action:@selector(BtnRejectClk:) forControlEvents:UIControlEventTouchUpInside];
                    [cell1.contentView addSubview:Rejectbtn];
                    [Rejectbtn release];
                    
                    
                    UIButton *Acceptbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 60, 105, 30)];
                    Acceptbtn.tag=indexPath.row;
                    Acceptbtn.contentMode = UIViewContentModeScaleAspectFill;
                    [Acceptbtn setImage:[UIImage imageNamed:@"btnaccept.png"] forState:UIControlStateNormal];
                    [Acceptbtn addTarget:self action:@selector(BtnAcceptedClk:) forControlEvents:UIControlEventTouchUpInside];
                    [cell1.contentView addSubview:Acceptbtn];
                    [Acceptbtn release];
                }
                
                EventNotificationsBO *obj = [self.arrNotification objectAtIndex:indexPath.row];
                cell1.lblTitle.text = [NSString stringWithFormat:@"%@",obj.strNotificationTye];
                cell1.lblTitle.frame = CGRectMake(15, 0, 225, 20);
                
                cell1.imgImage.frame = CGRectMake(0, 0, 0, 0	);
                
                
              /*  NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
                NSDate *eventdate;
                if([obj.strdate_Created length])
                {
                    NSString *str = [obj.strdate_Created stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    NSArray *arrDtsStr = [str componentsSeparatedByString:@"."];
                    str = [arrDtsStr count]?[arrDtsStr objectAtIndex:0]:str;
                    [dtFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                    eventdate = [dtFormat dateFromString:str];
                }
                NSString *strEventdate = [dtFormat stringFromDate:eventdate];
                [dtFormat release];*/
                
                NSString *strText  = [NSString stringWithFormat:@"%@ By:%@ On:%@", obj.strText, obj.strsenderName,obj.strdate_Created ];
                cell1.lblSubTitle.text=[NSString stringWithFormat:@"%@",strText];// obj.event_start_date; 
                cell1.lblSubTitle.numberOfLines = 0;
                cell1.lblSubTitle.frame = CGRectMake(15, 20, 280, 40);
                cell1.lblSubTitle.textColor = [UIColor blackColor];
                cell1.lblSubTitle.font = [UIFont systemFontOfSize:12];
				cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell1;
            }
            else  if([self.arrRecommendation count])
            {
                
                static NSString *RecommendationCell2 = @"RecommendationCell2";
                
                RecommendationCell *cell2 = (RecommendationCell *)[tableView dequeueReusableCellWithIdentifier:RecommendationCell2];
                if (cell2 == nil) 
                {
                    cell2 = [[[RecommendationCell alloc] initWithFrame:CGRectZero reuseIdentifier:RecommendationCell2] autorelease];
                }
                
                EventRecommendateBO *obj = [self.arrRecommendation objectAtIndex:indexPath.row];
                cell2.lblFromName.text = obj.strfromname;
                cell2.lblSubject.text = obj.strsubject;
                obj.strmessage = [obj.strmessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                cell2.lblMessage.text = obj.strmessage;
				cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell2;
                
            }
            else
            {
                static NSString *NotificationCell3 = @"NotificationCell3";
                
                UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:NotificationCell3];
                if (cell3 == nil) 
                {
                    cell3 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell3] autorelease];
                }
                cell3.textLabel.text = @"No event added";
                [cell3.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
                cell3.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
                cell3.textLabel.textAlignment = UITextAlignmentCenter;	
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell3;
            }
        
        }
        else if(indexPath.section == 1)
        {
            if([self.arrRecommendation count])
            {
                
                static NSString *RecommendationCell9 = @"RecommendationCell9";
                
                RecommendationCell *cell9 = (RecommendationCell *)[tableView dequeueReusableCellWithIdentifier:RecommendationCell9];
                if (cell9 == nil) 
                {
                    cell9 = [[[RecommendationCell alloc] initWithFrame:CGRectZero reuseIdentifier:RecommendationCell9] autorelease];
                }
                
                EventRecommendateBO *obj = [self.arrRecommendation objectAtIndex:indexPath.row];
                cell9.lblFromName.text = obj.strfromname;
                cell9.lblSubject.text = obj.strsubject;
                obj.strmessage = [obj.strmessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                cell9.lblMessage.text = obj.strmessage;
				cell9.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell9;
                
            }
            else
            {
                static NSString *NotificationCell10 = @"NotificationCell10";
                
                UITableViewCell *cell10 = [tableView dequeueReusableCellWithIdentifier:NotificationCell10];
                if (cell10 == nil) 
                {
                    cell10 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell10] autorelease];
                }
                cell10.textLabel.text = @"No event added";
                [cell10.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
                cell10.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
                cell10.textLabel.textAlignment = UITextAlignmentCenter;	
                cell10.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell10;
            }

        
        }
	}
	else if(tableView.tag == 2)
	{
        if([self.arrRecommendation count])
		{
            
            static NSString *RecommendationCell4 = @"RecommendationCell4";
            
            RecommendationCell *cell4 = (RecommendationCell *)[tableView dequeueReusableCellWithIdentifier:RecommendationCell4];
            if (cell4 == nil) 
            {
                cell4 = [[[RecommendationCell alloc] initWithFrame:CGRectZero reuseIdentifier:RecommendationCell4] autorelease];
            }
            
            EventRecommendateBO *obj = [self.arrRecommendation objectAtIndex:indexPath.row];
            cell4.lblFromName.text = obj.strfromname;
            cell4.lblSubject.text = obj.strsubject;
            NSLog(@"obj.strmessage %@",obj.strmessage);
            NSString *Tempmessage = [obj.strmessage stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            Tempmessage = [Tempmessage stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSLog(@"obj.strmessage %@",Tempmessage);
            cell4.lblMessage.text = Tempmessage;
			cell4.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell4;
        
        }
        
		else
		{
			static NSString *NotificationCell6 = @"NotificationCell6";
			
			UITableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:NotificationCell6];
			if (cell6 == nil) 
			{
				cell6 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell6] autorelease];
			}
			cell6.textLabel.text = @"No recommendate events";
			[cell6.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell6.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
			cell6.textLabel.textAlignment = UITextAlignmentCenter;	
			cell6.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell6;
		}
	}
	else {
		
		if([self.arrNotification count])
		{
			static NSString *NotificationCell7 = @"NotificationCell7";
			
			NotifyTabeCell *cell7 = (NotifyTabeCell *)[tableView dequeueReusableCellWithIdentifier:NotificationCell7];
			if (cell7 == nil) 
			{
				cell7 = [[[NotifyTabeCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell7] autorelease];
                
                UIButton *Rejectbtn = [[UIButton alloc]initWithFrame:CGRectMake(185, 60, 105, 30)];
				Rejectbtn.tag=indexPath.row;
				Rejectbtn.contentMode = UIViewContentModeScaleAspectFill;
				[Rejectbtn setImage:[UIImage imageNamed:@"btnreject.png"] forState:UIControlStateNormal];
				[Rejectbtn addTarget:self action:@selector(BtnRejectClk:) forControlEvents:UIControlEventTouchUpInside];
				[cell7.contentView addSubview:Rejectbtn];
				[Rejectbtn release];
                
                
                UIButton *Acceptbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 60, 105, 30)];
				Acceptbtn.tag=indexPath.row;
				Acceptbtn.contentMode = UIViewContentModeScaleAspectFill;
				[Acceptbtn setImage:[UIImage imageNamed:@"btnaccept.png"] forState:UIControlStateNormal];
				[Acceptbtn addTarget:self action:@selector(BtnAcceptedClk:) forControlEvents:UIControlEventTouchUpInside];
				[cell7.contentView addSubview:Acceptbtn];
				[Acceptbtn release];
			}
			
			EventNotificationsBO *obj = [self.arrNotification objectAtIndex:indexPath.row];
			cell7.lblTitle.text = [NSString stringWithFormat:@"%@",obj.strNotificationTye];
			cell7.lblTitle.frame = CGRectMake(15, 0, 225, 20);
			
			cell7.imgImage.frame = CGRectMake(0, 0, 0, 0	);
			
			
		/*	NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
			NSDate *eventdate;
			if([obj.strdate_Created length])
			{
				NSString *str = [obj.strdate_Created stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
				NSArray *arrDtsStr = [str componentsSeparatedByString:@"."];
				str = [arrDtsStr count]?[arrDtsStr objectAtIndex:0]:str;
				[dtFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
				eventdate = [dtFormat dateFromString:str];
			}
			NSString *strEventdate = [dtFormat stringFromDate:eventdate];
			[dtFormat release];*/
			
			NSString *strText  = [NSString stringWithFormat:@"%@ By:%@ On:%@", obj.strText, obj.strsenderName,obj.strdate_Created ];
			cell7.lblSubTitle.text=[NSString stringWithFormat:@"%@",strText];// obj.event_start_date; 
			cell7.lblSubTitle.numberOfLines = 0;
			cell7.lblSubTitle.frame = CGRectMake(15, 20, 280, 40);
			cell7.lblSubTitle.textColor = [UIColor blackColor];
			cell7.lblSubTitle.font = [UIFont systemFontOfSize:12];
			cell7.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell7;
		}
		else
		{
			static NSString *NotificationCell8 = @"NotificationCell8";
			
			UITableViewCell *cell8 = [tableView dequeueReusableCellWithIdentifier:NotificationCell8];
			if (cell8 == nil) 
			{
				cell8 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:NotificationCell8] autorelease];
			}
			cell8.textLabel.text = @"No notification";
			[cell8.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
			cell8.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:60/255.0 blue:83/255.0 alpha:1.0];
			cell8.textLabel.textAlignment = UITextAlignmentCenter;	
			cell8.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell8;
		}
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

-(void)ShowLoading
{
    
    if([self.view viewWithTag:82])
	{
		[[self.view viewWithTag:82] removeFromSuperview];
	}
 	UIView *vw_Loader = [[UIView alloc] initWithFrame:CGRectMake(75,130+55, 170, 49)];
	vw_Loader.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
	vw_Loader.layer.cornerRadius = 6.0;
	vw_Loader.layer.borderColor = [[UIColor grayColor] CGColor];
	vw_Loader.layer.borderWidth = 2.0;
 	vw_Loader.tag = 82;
	
	//add indicator
	UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 6, 37, 37)];
	[indView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indView startAnimating];
    [vw_Loader addSubview:indView];
	[indView release];
	
	UILabel *lblSyncing = [[UILabel alloc] initWithFrame:CGRectMake(135-75,14, 90, 20)];
	lblSyncing.backgroundColor = [UIColor clearColor];
	lblSyncing.text = @"Loading...";
	lblSyncing.textAlignment =UITextAlignmentCenter;
	lblSyncing.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
	lblSyncing.font = [UIFont boldSystemFontOfSize:14.0];
	lblSyncing.textColor = [UIColor whiteColor];
	lblSyncing.alpha=1.0;
	[vw_Loader addSubview:lblSyncing];
	[lblSyncing release];
	
	[self.view addSubview:vw_Loader];
    [vw_Loader release];
 	
	self.view.userInteractionEnabled = NO;
    
}


-(void) RemoveLoading
{
	if([self.view viewWithTag:82])
	{
		[[self.view viewWithTag:82] removeFromSuperview];
	}
	self.view.userInteractionEnabled = YES;
    
}



-(void)BtnAcceptedClk:(UIButton *)sender
{
    
    [self ShowLoading];

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    self.Selectedobj = [self.arrNotification objectAtIndex:sender.tag];
    FriendRequestXML *parser = [FriendRequestXML saxParser];
	parser.strSoapMsg = [NSString stringWithFormat:@
                         "<useraccount>\n"
                         "<id>%i</id>\n"   
                         "<friendships>\n"
                         "<friend>\n"
                         "<useraddedfriendid>%i</useraddedfriendid>\n" 
                         "<status>1</status>\n"
                         "</friend>\n"
                         "</friendships>\n"
                         "</useraccount>\n",[appDelegate.currentUserID intValue],[Selectedobj.strfriendRequest intValue]];
    parser.delegate = self;
    [parser getData];
	parser = nil;
    [pool release];

    

}


-(void)BtnRejectClk:(UIButton *)sender
{
    [self ShowLoading];

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    FriendRequestXML *parser = [FriendRequestXML saxParser];
    self.Selectedobj  = [self.arrNotification objectAtIndex:sender.tag];
	parser.strSoapMsg = [NSString stringWithFormat:@
                         "<useraccount>\n"
                         "<id>%i</id>\n"   
                         "<friendships>\n"
                         "<friend>\n"
                         "<useraddedfriendid>%i</useraddedfriendid>\n" 
                         "<status>-1</status>\n"
                         "</friend>\n"
                         "</friendships>\n"
                         "</useraccount>\n",[appDelegate.currentUserID intValue],[Selectedobj.strfriendRequest intValue]];

    parser.delegate = self;
    [parser getData];
	parser = nil;
    [pool release];
}


- (void)FriendRequestXML_Error:(FriendRequestXML*)parser encounteredError:(NSError *)error with:(FriendRequestBO *)Object
{
    [self RemoveLoading];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)FriendRequestXML_Finished:(FriendRequestBO *)parser
{

    [self RemoveLoading];
    
    
	if(parser!=nil)
	{
		if([parser.Result isEqualToString:@"error"])
		{
		
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Error" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release]; 
		}
		else
		{
			NSRange rangeIs = [parser.Result rangeOfString:@"status 1" options:NSCaseInsensitiveSearch]; 
			NSRange rangeIs1 = [parser.Result rangeOfString:@"status -1" options:NSCaseInsensitiveSearch]; 
			if(rangeIs.length > 7)
			{
				
				
				
				[self.arrNotification removeObject:self.Selectedobj];
				
				[self LoadUserFriendData];
			}
			else if(rangeIs1.length > 8)
			{
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Friendship request has been successfully rejected" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
				[self.arrNotification removeObject:self.Selectedobj];
			}
			
			[self MarkMessageRead];
			[notifyBl  deleteObjectForKey:self.Selectedobj];
			[tblRecomendation reloadData];
		}

       
    }
}


-(void)MarkMessageRead
{
	HttpRequest *request = [[HttpRequest alloc] init];
	[request GetRequest:[NSString stringWithFormat:@"http://5.ga2ootesting.appspot.com/rest/v1/user/notifications/received/id/%@/markread/%@",appDelegate.currentUserID,self.Selectedobj.strNotificationID] Delegate:self Tag:0 ModuleName:@"Notification"];
	[request release];	
}


-(void)httpResponseReceived:(WebResponse *)response
{
	
	NSString *responseString = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
	NSLog(@"%@",responseString);
    [responseString release];
	
}

-(void)LoadUserFriendData
{
	[objFrndBL deleteAll];
	[objFrndBL LoadFriends];

}


-(void)FriendsLoadingCompleted:(NSMutableArray *)arrFriends
{
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Friendship request has been successfully accepted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}


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


- (void)dealloc {
	
	[arrNotification release];
    [super dealloc];
}


@end
