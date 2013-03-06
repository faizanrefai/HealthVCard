//
//  Account_Information.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface Account_Information : UIViewController<UITextViewDelegate> {
    IBOutlet UITextField *txtName;
    
    IBOutlet UITextField *txtAdd;
    IBOutlet UITextField *txtCity;
    IBOutlet UITextField *txtProvince;
    
    IBOutlet UITextField *txtPostalCode;
    IBOutlet UITextField *txtDob;
    IBOutlet UITextField *txtSin;
    
    IBOutlet UITextField *txtHelthcardno;
    IBOutlet UITextView *txtAdiinfo;
    IBOutlet UIScrollView *scrl;
    CGFloat animatedDistance;
	NSMutableArray *arrlist;
	int flag;
	HealthVCardAppDelegate *appdel;
}
-(IBAction)click;
-(IBAction)save;
-(IBAction)Cancel;
-(IBAction)Delete;
-(void)JSON;
-(void)JSONDelete;
@end
