//
//  AppointmentDetail.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"

@interface AppointmentDetail : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UILabel *lbldate;
    
     IBOutlet UITableView *tblcontact;
    HealthVCardAppDelegate *appdel;
    NSMutableArray *arrtitle;
	NSMutableArray *arrApid;
	NSMutableArray *startTime;
	NSMutableArray *sorted;
	NSMutableArray *arrDict;
}
-(IBAction)NewAppo;
-(void)JSONDisplayApt;
-(NSMutableArray *)sortByStringDate:(NSMutableArray *)unshortedArray;
@end
