//
//  Appointments.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpcomingEvents.h"
#import "Global.h"
#import "TapkuLibrary/TapkuLibrary.h"
@interface Appointments : UIViewController <TKCalendarMonthViewDataSource,TKCalendarMonthViewDelegate>{
   
	UITableView *myTableView;
	NSMutableArray *tableViewData;
	BOOL shouldPushAnotherView;
	NSString *reminder;
	IBOutlet UILabel *reminder1;
    HealthVCardAppDelegate *objappdel;
	TKCalendarMonthView *tkmonthView;
	
    
}
-(IBAction)upComingEvents:(id)sender;
@property (nonatomic ,retain) TKCalendarMonthView *tkmonthView;
@end




