//
//  ImportantAddresses.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"


@interface ImportantAddresses : UIViewController <UITableViewDelegate,UITableViewDataSource>{    
   
	IBOutlet UITableView *tblcontact;
	HealthVCardAppDelegate *objappdel;
	NSMutableArray *arrName;
	NSMutableArray *arrAid;
}
-(IBAction)newcontact;
-(void)JSONDisplayNote;

@end
