//
//  Contact_Detail.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface Contact_Detail : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    IBOutlet UIButton *btndelete;
    IBOutlet UIScrollView *scrl;
    IBOutlet UITextField *txtname;
    
    IBOutlet UITextField *txttitle;
    IBOutlet UITextField *txtadd;
    IBOutlet UITextField *txtcity;
    IBOutlet UITextField *txtstate;
    IBOutlet UITextField *txtpostal;
    IBOutlet UITextField *txtcountry;
    IBOutlet UITextField *txtphone;
    IBOutlet UITextField *txtwork;
    IBOutlet UITextField *txtcell;
    IBOutlet UITextField *txtemail;
    IBOutlet UITextView *txtview;
	IBOutlet UIButton *btnPicker;
	IBOutlet UIButton *btnDone;
	IBOutlet UIToolbar *tool;
	IBOutlet UIPickerView *picker;
    HealthVCardAppDelegate *objappdel;
	
	
	NSMutableArray *arrlist;
    
	CGFloat  animatedDistance;
	
	UIActionSheet *actionSheet;
	
	NSString *strCID;
	NSString *a;

}
-(IBAction)click;
-(IBAction)deletedata;
-(IBAction)Save;
-(IBAction)cancel;
@end
