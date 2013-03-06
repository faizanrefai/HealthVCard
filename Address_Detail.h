//
//  Address_Detail.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface Address_Detail : UIViewController<UIPickerViewDelegate,UITextViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate> {
    
    IBOutlet UIButton *btndelete;
    IBOutlet UIScrollView *scrl;
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
    CGFloat animatedDistance;
    
    UIActionSheet *actionSheet;
	IBOutlet UIPickerView *picker;
    HealthVCardAppDelegate *objappdel;
    
	
	NSMutableArray *arrlist;
    
	NSString *strCID;
	NSString *a;
	
	int alert1;
    
}
-(IBAction)click;
-(IBAction)deletedata;
-(IBAction)Save;
-(void)JSONDisplay;
-(IBAction)cancel;
@end
