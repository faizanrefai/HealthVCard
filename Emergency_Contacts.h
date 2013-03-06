//
//  Emergency_Contacts.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"
@interface Emergency_Contacts : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *tblcontact;
    HealthVCardAppDelegate *objappdel;
	NSMutableArray *arrlist;
	NSMutableArray *arrEid;
}
-(IBAction)newcontact;
-(void)JSONNames;
@end
