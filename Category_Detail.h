//
//  Category_Detail.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"
#import "TableCell.h"

@interface Category_Detail : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView *tblcategory;
    IBOutlet UILabel *lblcatogory;
    HealthVCardAppDelegate *objappdel;
	IBOutlet TableCell *tblViewCell;
    IBOutlet UILabel *lblcatogory1;
    IBOutlet UILabel *lblcatogory2;
    
    IBOutlet UIScrollView *scrl;
    IBOutlet UILabel *lblMsg;
    IBOutlet UILabel *lblselct;
    IBOutlet UILabel *lblselct1;
	IBOutlet UILabel *lblName;
    NSMutableArray *arrTitle;
	NSMutableArray *arrNote;
	NSMutableArray *arrNid;
	NSString *strTitle;
	NSString *strid;
	IBOutlet UIButton *btndelete;
	int flag;
}
@property(nonatomic,retain) IBOutlet TableCell *tblViewCell;

-(IBAction)Addnew;
-(IBAction)Delete;
-(IBAction)DeleteCate;
-(void)JSONDisplayNote;
-(IBAction)cancel1:(id)sender;
@end
