//
//  Select_Different_Account.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"
@interface Select_Different_Account : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView *tblaccount;
    NSMutableArray *arrlist;
    HealthVCardAppDelegate *appdel;
	NSMutableArray *arrActId;
	IBOutlet UIView *view;
}
-(IBAction)newaccount;
-(void)JSONDisplayNames;

@end
