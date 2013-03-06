//
//  Registration.h
//  HealthVCard
//
//  Created by apple1 on 11/9/11.
//  Copyright 2011 openxcek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthVCardAppDelegate.h"

@interface Registration : UIViewController<UIScrollViewDelegate,UITextFieldDelegate> {

	CGFloat animatedDistance;
	IBOutlet UITextField *txtUserName;
	IBOutlet UITextField *txtPwd;
	IBOutlet UITextField *txtFirstNm;
	IBOutlet UITextField *txtLastNm;
	IBOutlet UITextField *txtEmail;
	IBOutlet UIScrollView *scroll;
	int flag;
	NSString *email;
	BOOL emailstatus;
	HealthVCardAppDelegate *objappdel;
	
	
}
-(IBAction)click;
-(IBAction)Register:(id)sender;
-(IBAction)back:(id)sender;
- (BOOL)validateEmailWithString:(NSString*)email11;
@end
