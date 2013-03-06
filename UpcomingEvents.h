//
//  UpcomingEvents.h
//  HealthVCard
//
//  Created by girish on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthVCardAppDelegate.h"

@interface UpcomingEvents : UIViewController<UITableViewDataSource,UITableViewDelegate> {

	IBOutlet UITableView *tblEvent;
	HealthVCardAppDelegate *appdel;
	NSMutableArray *arrtitle;
	NSMutableArray *arrApid;
	NSMutableArray *startTime;
	NSMutableArray *newArr;
	NSMutableArray * reverseArray;
}
-(void)JSONDisplayApt;
-(NSMutableArray *)sortByStringDate:(NSMutableArray *)unshortedArray;
@end
