//
//  AppointmentDetailMore.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"
@interface AppointmentDetailMore : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    
    IBOutlet UILabel *lbldate;
    IBOutlet UITextField *txttitle;
    IBOutlet UITextField *txtstarttime;
    IBOutlet UITextField *txtendtime;
    IBOutlet UIButton *txtworkday;
    IBOutlet UITextView *txtdetail;
    HealthVCardAppDelegate *objappdel;
    IBOutlet UIButton *btndelete;
    IBOutlet UIScrollView *scrol;
    CGFloat animatedDistance;
	NSMutableArray *arrlist;
	BOOL check;
	IBOutlet UIDatePicker *pickerViewDOB;
	UIActionSheet *actionSheetDOB;
	UIActionSheet *actionsheet;
	IBOutlet UIDatePicker *picker;
	IBOutlet UIButton *btnCancel;
	BOOL isflag;
	
}
@property(nonatomic,retain)UIDatePicker *pickerViewDOB;
-(IBAction)deleteappo;
-(IBAction)click;
-(IBAction)Save;
-(void)JSONSave;
-(IBAction)cancel;
-(IBAction)checkMark;
-(void)btn_pickerview_selected;
@end
