//
//  Appointments.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Appointments.h"
#import "AppointmentDetail.h"
#import "UpcomingEvents.h"
#import "JSONParser.h"
@implementation Appointments
@synthesize tkmonthView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date
{
	
	NSLog(@"Date Selected is %@",date);
		//txtbdate.text=date;
	    
	NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
	NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	[timeFormat setDateFormat:@"yyyy-MM-dd"];
	[timeFormat setTimeZone:gmt];
	
	
	//[timeFormat setLocale:[NSLocale currentLocale]];
	//[timeFormat setTimeZone:[NSTimeZone localTimeZone]]; 
	NSString *theTime = [timeFormat stringFromDate:date];	
	NSLog(@"%@",theTime); 
	objappdel.strdate=theTime;
	    
	[tkmonthView reload];
	AppointmentDetail *appointmentDetail=[[AppointmentDetail alloc]initWithNibName:@"AppointmentDetail" bundle:nil];
	[self.navigationController pushViewController:appointmentDetail animated:YES];
	[appointmentDetail release];
}
- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate
{	
	NSMutableArray * data = [[NSMutableArray alloc] init];
	NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
	NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	[dateForm setDateFormat:@"yyyy-MM-dd"];
	[dateForm setTimeZone:gmt];
	NSDate *date ;
	
	
    for (int i=0; i<[objappdel.arrDate count]; i++)
	{
		NSString *time;
		time=[objappdel.arrDate objectAtIndex:i];
		//time=  [[[jobData valueForKey:@"Record"] objectAtIndex:i] valueForKey:@"JobStartDate"];
		//time = [[time componentsSeparatedByString:@" "] objectAtIndex:0];
		date = [dateForm dateFromString:time];
		[data addObject:[NSString stringWithFormat:@"%@",date]];
    }
	NSArray *copy = [data copy];
		NSInteger index = [copy count] - 1;
		for (id object in [copy reverseObjectEnumerator]) 
		{
			if ([data indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) 
			{
				[data removeObjectAtIndex:index];
			}
			index--;
		}
	
	NSLog(@"sorted dates are %@",copy);
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit |
											  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) 
									fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
	
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) 
		{
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		//NSLog(@"%@",[d description]);
		
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	[offsetComponents release];
	
	return [NSArray arrayWithArray:marks];
}



-(void)JSON{
	[AlertHandler showAlertForProcess];
	//start = [NSDate timeIntervalSinceReferenceDate];
	NSString *url=[NSString stringWithFormat:@"%@appointment_list.php?userid=%@&account_id=%@",objappdel.strUrl,objappdel.appUserId,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
	[AlertHandler hideAlert];
	objappdel.arrDate=[[NSMutableArray alloc]init];
	objappdel.arrDate=[[[dictionary valueForKey:@"Appointments"]valueForKey:@"Date"]copy];
	NSLog(@"%@",objappdel.arrDate);
	//NSArray *copy = [objappdel.arrDate copy];
//	NSInteger index = [copy count] - 1;
//	for (id object in [copy reverseObjectEnumerator]) 
//	{
//		if ([objappdel.arrDate indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) 
//		{
//			[objappdel.arrDate removeObjectAtIndex:index];
//		}
//		index--;
//	}
//	
//	NSLog(@"sorted dates are %@",copy);
	[tkmonthView reload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   //    self.title=@"John Smith";
     self.navigationItem.hidesBackButton=TRUE;
	
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
	tkmonthView=[[TKCalendarMonthView alloc]init];
	tkmonthView.delegate = self;
	tkmonthView.dataSource = self;
	
	[self.view addSubview:tkmonthView];
    
	
    objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
   self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
	objappdel.arrSort=[[NSMutableArray alloc]init];
	[self JSON];
	
	objappdel.sign=@"change";
	
}


-(IBAction)upComingEvents:(id)sender{
	
	NSDate *today=[NSDate date];
	
	NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
	NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	[dateForm setDateFormat:@"yyyy-MM-dd"];
	[dateForm setTimeZone:gmt];
	NSString *str;
	str=[dateForm stringFromDate:today];
	NSLog(@"%@",str);
	
	
	for(int i=0;i<[objappdel.arrDate count];i++)
	{
		if ([(NSString *)[objappdel.arrDate objectAtIndex:i] compare:str] == NSOrderedDescending)
		{
			
			[objappdel.arrSort addObject:[objappdel.arrDate objectAtIndex:i]];	
		}
	}
	NSArray *copy = [objappdel.arrSort copy];
	NSInteger index = [copy count] - 1;
	for (id object in [copy reverseObjectEnumerator]) {
		if ([objappdel.arrSort indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
			[objappdel.arrSort removeObjectAtIndex:index];
		}
		index--;
	}
	[copy release];
	
	NSLog(@"upcoming%@",objappdel.arrSort);

	NSLog(@"%d",[objappdel.arrSort count]);
	UpcomingEvents *upComingEvents=[[UpcomingEvents alloc]initWithNibName:@"UpcomingEvents" bundle:nil];
	[self.navigationController pushViewController:upComingEvents animated:YES];
	[upComingEvents release];
	
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
